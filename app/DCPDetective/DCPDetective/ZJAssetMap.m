//
//  ZJAssetMap.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAssetMap.h"

#import "ZJAsset.h"
#import "ZJChunk.h"
#import "ZJFileUtil.h"
#import "ZJXMLRichElement.h"

static ZJAssetMap *loadSMPTE(ZJAssetMap *result, NSString *fileName)
    // Parses the file having the specified fileName as an SMPTE asset map.
{
    NSLog(@"Warning: SMPTE asset maps are not yet supported.");

    // TODO

    return nil;
}

static ZJChunk *parseChunk(ZJXMLRichElement *element)
    // Returns a chunk having the value of the specified XML 'element'.
{
    NSString *originalFileName =
        [element childStringOrEmpty:@"OriginalFileName"];

    NSString *path = [element childString:@"Path"];

    int volumeIndex = [element childInt:@"VolumeIndex"];

    return [ZJChunk chunkWithOriginalFileName:originalFileName
                                         path:path
                                  volumeIndex:volumeIndex];
}

static NSArray *parseChunkList(ZJXMLRichElement *element)
    // Returns an array of Chunk objects having the values of the children of
    // teh specified "ChunkList" 'element'.
{
    NSMutableArray *result =
      [NSMutableArray arrayWithCapacity:element.childCount];

    for (ZJXMLRichElement *child in element.children) {
        [result addObject:parseChunk(child)];
    }

    return result;
}

static ZJAsset *parseAsset(ZJXMLRichElement *element)
    // Returns an asset having the value represented by the specified XML
    // 'element'.
{
    NSString *annotationText = [element childStringOrEmpty:@"AnnotationText"];
    NSArray *chunkList = parseChunkList([element child:@"ChunkList"]);

    BOOL packingList =
        [element hasChild:@"PackingList"]
    && [[element childString:@"PackingList"]
        caseInsensitiveCompare:@"true"] == NSOrderedSame;

    return [ZJAsset assetWithUUID:[element childString:@"Id"]
                   annotationText:annotationText
                        chunkList:chunkList
                      packingList:packingList];
}

static NSArray *parseAssetList(ZJXMLRichElement *element)
    // Returns an array of Asset objects having the values of the children of
    // the specified "AssetList" 'element'.
{
    NSMutableArray *result =
        [NSMutableArray arrayWithCapacity:element.childCount];

    for (ZJXMLRichElement *child in element.children) {
        [result addObject:parseAsset(child)];
    }

    return result;
}

static ZJAssetMap *loadInterop(ZJAssetMap *result, NSString *path)
    // Parses the file at 'path' as an Interop-formatted asset map, loading the
    // parsed data into 'result'.  Returns 'result' on success, or nil on error.
{
    ZJAssetMap *map = [ZJAssetMap new];

    ZJXMLRichElement *root =
        [ZJXMLRichElement elementWithContentsOfFile:path];

    map.uuid        = [root childString:@"Id"];
    map.volumeCount = [root childInt:@"VolumeCount"];
    map.issueDate   = [root childString:@"IssueDate"];
    map.issuer      = [root childString:@"Issuer"];
    map.creator     = [root childString:@"Creator"];
    map.assetList   = parseAssetList([root child:@"AssetList"]);

    return map;
}

@implementation ZJAssetMap

+ (id)assetMapFromDCP:(NSString *)path
{
    // If dir/ASSETMAP.xml exists,
    //  parse it as SMPTE.

    NSString *assetMapName =
        [path stringByAppendingPathComponent:@"ASSETMAP.xml"];

    if ([ZJFileUtil fileExists:assetMapName]) {
        return loadSMPTE([ZJAssetMap new], assetMapName);
    }

    // Else, if ASSETMAP exists,
    //  parse it as Interop.

    assetMapName = [path stringByAppendingPathComponent:@"ASSETMAP"];

    if ([ZJFileUtil fileExists:assetMapName]) {
        return loadInterop([ZJAssetMap new], assetMapName);
    }

    // TODO: Process each subdirectory of dir not called lost+found or RECYCLER.

    NSLog(@"Warning: could not find asset map for DCP: %@", path);
    return nil;
}

- (NSString *)description
{
    NSMutableString *assets = [NSMutableString new];

    for (ZJAsset *asset in self.assetList) {
        [assets appendFormat:@"\n%@", asset.description];
    }

    return [NSString stringWithFormat:@"ZJAssetMap"
            "\n\tId          = %@"
            "\n\tVolumeCount = %d"
            "\n\tIssueDate   = %@"
            "\n\tIssuer      = %@"
            "\n\tCreator     = %@"
            "\n\tAssetList   = (%lu asset%s)%@",
            self.uuid,
            self.volumeCount,
            self.issueDate,
            self.issuer,
            self.creator,
            self.assetList.count,
            self.assetList.count == 1 ? "" : "s",
            assets];

    // TODO: Format asset list.
}

@end
