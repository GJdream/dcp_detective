//
//  ZJAssetMap.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJAssetMap.h"

@implementation ZJAssetMap

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n\tId = %@\n\tVolumeCount = %d",
            self.assetMapID,
            self.volumeCount];
}

@end
