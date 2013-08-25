//
//  ZJAssetMap.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAssetMap.h"

#import "ZJFileUtil.h"
#import "ZJXMLUtil.h"

static ZJAssetMap *loadSMPTE(ZJAssetMap *result, NSString *fileName)
    // Parses the file having the specified fileName as an SMPTE asset map.
{
    NSLog(@"Warning: SMPTE asset maps are not yet been supported.");

    // TODO
    
    return nil;
}

static ZJAssetMap *loadInterop(ZJAssetMap *result, NSString *path)
    // Parses the file at 'path' as an Interop-formatted asset map, loading the
    // parsed data into 'result'.  Returns 'result' on success, or nil on error.
{
    ZJAssetMap *map = [[ZJAssetMap alloc] init];
    NSXMLDocument *doc = [ZJXMLUtil loadFile:path];

    if (!doc) {
        return nil;
    }

    NSXMLElement *root = [doc rootElement];

    map.uuid = [ZJXMLUtil stringFromChild:@"Id" of:root];
    map.volumeCount = [ZJXMLUtil intFromChild:@"VolumeControl" of:root];

    // TODO
    
    return map;
}

@implementation ZJAssetMap

+ (id)assetMapFromDCP:(NSString *)path
{
    // If dir/ASSETMAP.xml exists,
    //  parse it as SMPTE;

    NSString *assetMapName =
        [path stringByAppendingPathComponent:@"ASSETMAP.xml"];

    if ([ZJFileUtil fileExists:assetMapName]) {
        return loadSMPTE([ZJAssetMap new], assetMapName);
    }

    // else, if ASSETMAP exists,
    //  parse it as Interop.

    assetMapName = [path stringByAppendingPathComponent:@"ASSETMAP"];

    if ([ZJFileUtil fileExists:assetMapName]) {
        return loadInterop([ZJAssetMap new], assetMapName);
    }

    // TODO: Process each subdirectory of dir not called lost+found or RECYCLER.
    
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n\tId = %@\n\tVolumeCount = %d",
            self.uuid,
            self.volumeCount];
}

@end
