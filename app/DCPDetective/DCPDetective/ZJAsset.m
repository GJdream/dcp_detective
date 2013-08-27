//
//  ZJAsset.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAsset.h"

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
    return [NSString stringWithFormat:@"ZJAsset:"
            "\n\tuuid:           %@"
            "\n\tannotationText: %@"
            "\n\tchunkList:      [%lu chunks]"
            "\n\tpackingList:    %@",
        self.uuid,
        self.annotationText,
        (unsigned long)self.chunkList.count,
        self.packingList ? @"true" : @"false"];
}

@end
