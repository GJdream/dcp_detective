//
//  ZJChunk.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJChunk.h"

@implementation ZJChunk

+ (ZJChunk *)chunkWithOriginalFileName:(NSString *)name
                                  path:(NSString *)path
                           volumeIndex:(int)index
{
    ZJChunk *result = [ZJChunk new];

    result.originalFileName = name;
    result.path = path;
    result.volumeIndex = index;

    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"ZJChunk:"
                "\n\tOriginalFileName: %@"
                "\n\tPath:             %@"
                "\n\tVolumeIndex       %d",
            self.originalFileName,
            self.path,
            self.volumeIndex];
}


@end
