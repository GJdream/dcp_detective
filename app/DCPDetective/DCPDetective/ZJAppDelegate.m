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
    NSLog(@"%@",[ZJFileUtil sha1:@"/Users/zacharymanning/Downloads/public-AD-ACT_OF_KILLING_060313_TRL_TIFF_S-archive-24-Aug-2013/CPL_cddc222e-c5ea-d34d-a9dc-0c0f3086d965.xml"]);
    

    for (NSString *path in args) {
        ZJAssetMap *assetMap = [ZJAssetMap assetMapFromDCP:path];

        // TODO
        
        NSLog(@"%@", assetMap);
        NSLog(@"%@", [ZJFileUtil sha1:path]);
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
