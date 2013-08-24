//
//  ZJAppDelegate.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAppDelegate.h"

//TODO create separate files for implementation classes

// CLASS INTERFACES

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

- (NSString *)description;
@end

// STATIC FUNCTIONS

static BOOL fileExists(NSString *fileName)
{
    return [[NSFileManager defaultManager] fileExistsAtPath:fileName];
}

static NSXMLDocument *loadXMLFile(NSString *fileName)
{
    assert(fileExists(fileName));
    NSURL *url = [NSURL fileURLWithPath:fileName];
    return [[NSXMLDocument alloc]
            initWithContentsOfURL:url
            options:NSXMLDocumentTidyXML
            error:nil];

}

static ZJAssetMap *parseSMPTEAssetMap(NSString *fileName)
    // Parses the file having the specified fileName as an SMPTE asset map.
{
    return nil; // TODO
}

static NSString *getString(NSXMLElement *x, NSString *key)
    // Returns the string text of the 'key' sub-element of element x.
{
    NSString *result = nil;

    for (NSXMLElement *child in [x elementsForName:key]) {
        result = [child stringValue];
    }

    return result;
}

static int getInt(NSXMLElement *x, NSString *key)
    // Returns the integer value of the 'key' sub-element of element x.
{
    int result = 0;

    for (NSXMLElement *child in [x elementsForName:key]) {
        result = [[child stringValue] intValue];
    }

    return result;
}

static ZJAssetMap *parseInteropAssetMap(NSString *fileName)
    // Parses the file having the specified fileName as an Interop-formatted
    // asset map.
{
    ZJAssetMap *map = [[ZJAssetMap alloc] init];
    NSXMLDocument *doc = loadXMLFile(fileName);

    if (!doc) {
        return nil;
    }

    NSXMLElement *root = [doc rootElement];

    map.assetMapID = getString(root, @"Id");
    map.volumeCount = getInt(root, @"VolumeCount");

    return map; // TODO
}

static ZJAssetMap *loadAssetMap(NSString *dir)
    // Returns an object representing the asset map in directory 'dir', or nil
    // if no asset map exists, or the asset map cannot be parsed.  Parses the
    // asset map as SMPTE format if called ASSETMAP.xml, or in Interop format if
    // called ASSETMAP (with no extension).
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

// CLASS IMPLEMENTATIONS

@implementation ZJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // For each command-line argument (except the first, which is just the name
    // of this executable), find the name of the PKL file.

    NSMutableArray *args =
    [[[NSProcessInfo processInfo] arguments] mutableCopy];
    [args removeObjectAtIndex:0];

    for (NSString *arg in args) {
        ZJAssetMap *assetMap = loadAssetMap(arg);
        
        NSLog(@"%@", assetMap);
    }
}

@end

@implementation ZJChunk
@end

@implementation ZJAsset
@end

@implementation ZJAssetMap

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n\tId = %@\n\tVolumeCount = %d",
            self.assetMapID,
            self.volumeCount];
}

@end

// TODO: Add implementations of remaining interfaces.
