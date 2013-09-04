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

static NSArray *dcpOK(NSString *path)
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
    enum ZJAssetMapFormat format;
    ZJXMLRichElement *assetMap = assetMapFromDCP(path, &format);

    if (!assetMap) {
        return [NSArray arrayWithObject:@"Error: asset map cannot be parsed"];
    }

    NSMutableArray *results = [NSMutableArray new];

    if (format == ZJAssetMapFormatSMPTE) {
        [results addObject:@"Warning: asset map has unsupported format SMPTE"];
    }

    return results;
}

static void printDiagnostics(NSArray *messages)
    // Formats 'messages' to the standard output stream.  If 'messages' contains
    // more than one element, each element is prefixed with a newline and a tab
    // character ("\n\t").  If 'messages' is empty, the string "OK" is printed.
{
    switch ([messages count]) {
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

        printDiagnostics(dcpOK(path));

        // TODO: Process each subdirectory of dir not called lost+found or
        // RECYCLER.
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
