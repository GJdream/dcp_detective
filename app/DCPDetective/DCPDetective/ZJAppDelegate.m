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
    return [[NSFileManager defaultManager] fileExistsAtPath:fileName];
}

NSXMLDocument *loadXMLFile(NSString *fileName)
{
    assert(fileExists(fileName));
    NSURL *url = [NSURL fileURLWithPath:fileName];
    return [[NSXMLDocument alloc]
            initWithContentsOfURL:url
            options:NSXMLDocumentTidyXML
            error:nil];

}

ZJAssetMap *parseSMPTEAssetMap(NSString *fileName)
    // Parse the file having the specified fileName as an SMPTE asset map.
{
    return nil; // TODO
}

ZJAssetMap *parseInteropAssetMap(NSString *fileName)
    // Parse the file having the specified fileName as an Interop-formatted
    // asset map.
{
    NSXMLDocument *doc = loadXMLFile(fileName);
    
    if (!doc) {
        return nil;
    }
    
    NSXMLElement *root = [doc rootElement];
    
    NSLog(@"%@", root);
    
    ZJAssetMap *map = [[ZJAssetMap alloc] init];
    
//    map.assetMapID =
    
    return map; // TODO
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
        NSLog(@"found SMPTE asset map");
        return parseSMPTEAssetMap(assetMapName);
    }

    assetMapName = [dir stringByAppendingPathComponent:@"ASSETMAP"];

    if (fileExists(assetMapName)) {
        NSLog(@"found Interop asset map");
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

@implementation ZJChunk
@end

@implementation ZJAsset
@end

@implementation ZJAssetMap
@end

// TODO: Add implementations of remaining interfaces.
