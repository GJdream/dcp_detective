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

static NSString *dcpOK(NSString *path)
    // Considers the DCP directory at 'path'; returns a descriptive message if
    // any inconsistencies are found in the DCP, and nil otherwise.  Returns nil
    // if all of the following conditions are met:
    //
    // * An ASSETMAP file is found at the root of the DCP directory.
    // * All asset sizes and hashes match the associated packing list.
    //
    // The result message may contain multiple lines.  If so, the message is
    // prefixed by a newline ('\n') and each line is prefixed with a tab ('\t')
    // to appear indented one level when logged.
{
    enum ZJAssetMapFormat format;
    ZJXMLRichElement *assetMap = assetMapFromDCP(path, &format);

    if (!assetMap) {
        return @"asset map could not be parsed";
    }

    return nil;
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

        NSString *message = dcpOK(path);

        if (message) {
            puts([message UTF8String]);
        }
        else {
            puts("OK");
        }

        // TODO: Process each subdirectory of dir not called lost+found or
        // RECYCLER.
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
