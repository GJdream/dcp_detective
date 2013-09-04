//
//  ZJAppDelegate.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAsset.h"
#import "ZJAssetMap.h"
#import "ZJChunk.h"
#import "ZJFileUtil.h"

#import "ZJAppDelegate.h"

static NSString *dcpOK(NSString *path)
    // Considers the DCP directory at 'path'; returns a descriptive message if
    // any inconsistencies are found in the DCP, and nil otherwise.  Returns nil
    // if all of the following conditions are met:
    //
    // * An ASSETMAP file is found at the root of the DCP directory.
    // * All asset sizes and hashes match the associated packing list.
{
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
            puts("Inconsistencies:");
            puts([message UTF8String]);
        }
        else {
            puts("OK");
        }
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
