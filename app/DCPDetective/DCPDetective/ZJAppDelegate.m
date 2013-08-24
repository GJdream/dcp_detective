//
//  ZJAppDelegate.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAppDelegate.h"

@interface Chunk : NSObject
@property NSString *path;
@property int       volumeIndex;
@end

@interface Asset : NSObject
@property NSString *assetID;
@property NSArray  *chunkList;
@end

@interface AssetMap : NSObject
@property NSArray *assetList;
// TODO: Add remaining AssetMap properties.
@end

static NSArray *loadAssetMap(NSString *dir)
    // TODO: Contract
{
    // If dir/ASSETMAP.xml exists,
    //  parse it as SMPTE;
    // else, if ASSETMAP exists,
    //  parse it as Interop.

    // TODO: Process each subdirectory of dir not called lost+found or RECYCLER.

    return nil;
}

@implementation ZJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // For each command-line argument (except the first, which is just the name
    // of this executable), find the name of the PKL file.

    NSMutableArray *args =
    [[[NSProcessInfo processInfo] arguments] mutableCopy];
    [args removeObjectAtIndex:0];

    for (NSString *arg in args) {
        NSLog(@"Detecting DCP: %@", arg);
    }
}

@end

@implementation Chunk
@end

// TODO: Add implementations of remaining interfaces.
