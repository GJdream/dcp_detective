//
//  ZJAppDelegate.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAppDelegate.h"

#import "ZJFileUtil.h"
#import "ZJXMLRichElement.h"

enum ZJAssetMapFormat {
    ZJAssetMapFormatSMPTE,
    ZJAssetMapFormatInterop
};

static NSError *packError(NSString *message)
    // Returns an NSError object having domain "ZJError", code 1, and a
    // dictionary mapping the string "message" to the specified 'message'.
{
    return [NSError errorWithDomain:@"ZJError" code:1 userInfo:
            [NSDictionary dictionaryWithObject:message forKey:@"message"]];
}

static NSString *unpackError(NSError *error)
    // Returns the string associated with the key "message" in the user info of
    // the specified 'error' object.
{
    return (NSString *)error.userInfo[@"message"];
}

static ZJXMLRichElement *assetMapFromDCP(NSString              *path,
                                         enum ZJAssetMapFormat *format)
    // Returns the root element of the asset map in the specified directory
    // 'path', and sets '*format' to indicate the asset map format: SMPTE if the
    // file is called ASSETMAP.xml, or Interop if the file is called ASSETMAP.
    // Returns nil, and leaves '*format' in an unspecified state, if the asset
    // map cannot be parsed.
{
    NSString *smpteName = [path stringByAppendingPathComponent:@"ASSETMAP.xml"];

    if ([ZJFileUtil fileExists:smpteName]) {
        *format = ZJAssetMapFormatSMPTE;
        return [ZJXMLRichElement elementWithContentsOfFile:smpteName];
    }

    NSString *interopName = [path stringByAppendingPathComponent:@"ASSETMAP"];

    if ([ZJFileUtil fileExists:interopName]) {
        *format = ZJAssetMapFormatInterop;
        return [ZJXMLRichElement elementWithContentsOfFile:interopName];
    }

    return nil;
}

static BOOL isPackingList(ZJXMLRichElement *asset)
    // Returns YES if 'asset' represents a packing list, and NO otherwise.
{
    return [asset hasChild:@"PackingList"]
    && [[asset childString:@"PackingList"]
        caseInsensitiveCompare:@"true"] == NSOrderedSame;
}

static NSString *packingListPath(ZJXMLRichElement  *assetMap,
                                 NSError          **error)
    // Returns the path to the packing list specified in 'assetMap', or sets
    // 'error' and returns nil if the path cannot be determined.  An error is
    // reported if the packing list has more than one chunk.
{
    // Find the asset list.

    ZJXMLRichElement *assetList = [assetMap child:@"AssetList"];

    if (!assetList) {
        *error = packError(@"Asset map has no asset list");
        return nil;
    }

    // Find the packing list asset.

    ZJXMLRichElement *asset = nil;

    for (ZJXMLRichElement *element in [assetList children]) {
        if (isPackingList(element)) {
            if (asset) {
                *error = packError(@"Asset map has multiple packing lists");
                return nil;
            }
            asset = element;
        }
    }

    if (!asset) {
        *error = packError(@"Asset map has no packing list");
        return nil;
    }

    // Find the packing list asset's chunk.

    ZJXMLRichElement *chunkList = [asset child:@"ChunkList"];

    if (!chunkList) {
        *error = packError(@"Cannot find chunk list for packing list");
        return nil;
    }

    if (chunkList.childCount == 0) {
        *error = packError(@"Chunk list for packing list is empty");
        return nil;
    }

    if (chunkList.childCount > 1) {
        *error =
        packError(@"Chunk list for packing list has multiple elements");

        return nil;
    }

    NSString *chunkPath = [chunkList childString:@"Chunk"];

    if (!chunkPath) {
        *error =
        packError(@"Chunk list for packing list contains non-chunk element");

        return nil;
    }

    return chunkPath;
}

static NSArray *dcpIssues(NSString *path)
    // Diagnoses problems in the DCP at directory 'path', and returns diagnostic
    // messages.  Returns an empty array if no problems are found.  Failures of
    // the following conditions are considered problems:
    //
    // * An ASSETMAP file is found at the root of the DCP directory.
    // * All asset sizes and hashes match the associated packing list.
    //
    // Each message begins with either "Error" or "Warning" to indicate relative
    // severity.
{
    // Load the asset map.

    enum ZJAssetMapFormat format;
    ZJXMLRichElement *assetMap = assetMapFromDCP(path, &format);

    if (!assetMap) {
        return [NSArray arrayWithObject:@"Error: cannot parse asset map"];
    }

    NSMutableArray *results = [NSMutableArray new];

    if (format == ZJAssetMapFormatSMPTE) {
        [results addObject:@"Warning: asset map has unsupported format SMPTE"];
    }

    // Load the packing list.

    NSError *error;
    NSString *pklPath = packingListPath(assetMap, &error);

    if (!pklPath) {
        [results addObject:
         [NSString stringWithFormat:@"Error: %@", unpackError(error)]];
        return results;
    }

    ZJXMLRichElement *packingList =
    [ZJXMLRichElement elementWithContentsOfFile:path];

    if (!packingList) {
        [results addObject:@"Error: cannot parse packing list"];
        return nil;
    }

    // TODO

    // For each asset in the packing list,
    //  Get the corresponding path

    return results;
}

static void printDiagnostics(NSArray *messages)
    // Formats 'messages' to the standard output stream.  If 'messages' contains
    // more than one element, each element is prefixed with a newline and a tab
    // character ("\n\t").  If 'messages' is empty, the string "OK" is printed.
{
    switch (messages.count) {
        case 0:
            puts("OK");
            return;
        case 1:
            puts([messages[0] UTF8String]);
            return;
    }
    printf("\n\t%s\n",
           [[messages componentsJoinedByString:@"\n\t"] UTF8String]);
}

@implementation ZJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // For each DCP directory specified on the command line, load the DCP's
    // asset map.  Skip argument 0, which is just the program name.

    NSMutableArray *args =
    [[[NSProcessInfo processInfo] arguments] mutableCopy];

    [args removeObjectAtIndex:0];

    for (NSString *path in args) {
        printf("%s: ", [path UTF8String]);
        fflush(stdout);

        printDiagnostics(dcpIssues(path));

        // TODO: Process each subdirectory of dir not called lost+found or
        // RECYCLER.
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
