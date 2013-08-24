//
//  ZJAppDelegate.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAppDelegate.h"

//TODO create separate files for implementation classes

@interface ZJChunk : NSObject
@property NSString *path;
@property int       volumeIndex;
@end

@interface ZJAsset : NSObject
@property NSString *assetID;
@property NSArray  *chunkList;
@property BOOL      packingList;
@end

@interface ZJAssetMap : NSObject
@property NSString *assetMapID;
@property int volumeCount;
@property NSArray *assetList;

// TODO: Add remaining AssetMap properties.
@end

BOOL fileExists(NSString *fileName)
{
    return false; // TODO
}

ZJAssetMap *parseSMPTEAssetMap(NSString *fileName)
{
    return nil; // TODO
}

ZJAssetMap *parseInteropAssetMap(NSString *fileName)
{
    return nil; // TODO
}

static ZJAssetMap *loadAssetMap(NSString *dir)
    // TODO: Contract
{
    // If dir/ASSETMAP.xml exists,
    //  parse it as SMPTE;
    // else, if ASSETMAP exists,
    //  parse it as Interop.

    NSLog(@"%@", dir);
    NSString *assetMapName = [dir stringByAppendingPathComponent:@"ASSETMAP.xml"];

    if (fileExists(assetMapName)) {
        return parseSMPTEAssetMap(assetMapName);
    }
    
    assetMapName = [dir stringByAppendingPathComponent:@"ASSETMAP"];

    if (fileExists(assetMapName)) {
        return parseInteropAssetMap(assetMapName);
    }
    

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
        //NSLog(@"Detecting DCP: %@", arg);
        ZJAssetMap *assetMap = loadAssetMap(arg);
        (void)assetMap;
        
    }
    
}

@end

@implementation Chunk
@end

// TODO: Add implementations of remaining interfaces.
