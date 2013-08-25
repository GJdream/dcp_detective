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

#import "ZJAppDelegate.h"

@implementation ZJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // For each command-line argument (except the first, which is just the name
    // of this executable), find the name of the PKL file.

    NSMutableArray *args =
        [[[NSProcessInfo processInfo] arguments] mutableCopy];

    [args removeObjectAtIndex:0];

    for (NSString *path in args) {
        ZJAssetMap *assetMap = [ZJAssetMap assetMapFromDCP:path];
        
        NSLog(@"%@", assetMap);
    }

    // Exit the application.

    [[NSApplication sharedApplication] terminate:nil];
}

@end
