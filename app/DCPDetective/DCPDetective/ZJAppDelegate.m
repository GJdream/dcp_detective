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

@implementation ZJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // For each DCP directory specified on the command line, load the DCP's
    // asset map.  Skip argument 0, which is just the program name.

    NSMutableArray *args =
        [[[NSProcessInfo processInfo] arguments] mutableCopy];
    [args removeObjectAtIndex:0];

    for (NSString *path in args) {
        ZJAssetMap *assetMap = [ZJAssetMap assetMapFromDCP:path];

        // TODO
        
        NSLog(@"\n%@", assetMap);
//        NSLog(@"SHA-1: %@",
//              [ZJFileUtil
//               sha1:[path stringByAppendingPathComponent:@"ASSETMAP"]]);
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
