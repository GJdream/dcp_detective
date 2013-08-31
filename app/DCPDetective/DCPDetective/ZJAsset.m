//
//  ZJAsset.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAsset.h"

#import "ZJChunk.h"

@implementation ZJAsset

+ (ZJAsset *)assetWithUUID:(NSString *)uuid
            annotationText:(NSString *)text
                 chunkList:(NSArray *)chunkList
               packingList:(BOOL)packingList
{
    ZJAsset *result = [[ZJAsset alloc] init];

    result.uuid = uuid;
    result.annotationText = text;
    result.chunkList = chunkList;
    result.packingList = packingList;

    return result;
}

- (NSString *)description
{
    NSMutableString *chunks = [NSMutableString new];

    for (ZJChunk *chunk in self.chunkList) {
        [chunks appendFormat:@"\n%@", chunk.description];
    }

    return [NSString stringWithFormat:@"ZJAsset:"
            "\n\tuuid:           %@"
            "\n\tannotationText: %@"
            "\n\tchunkList:      (%lu chunk%s)%@"
            "\n\tpackingList:    %@",
        self.uuid,
        self.annotationText,
        self.chunkList.count,
        self.chunkList.count == 1 ? "" : "s",
        chunks,
        self.packingList ? @"true" : @"false"];
}

@end
