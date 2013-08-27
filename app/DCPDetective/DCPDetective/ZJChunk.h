//
//  ZJChunk.h
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJChunk : NSObject
    // Each object of this class represents all or part of one _asset_.  Each
    // Digital Cinema Package (DCP) is in turn comprised of assets.

@property NSString *originalFileName;   // file from which chunk was derived
@property NSString *path;               // file containing this chunk
@property int volumeIndex;              // disk on which chunk is stored

+ (ZJChunk *)chunkWithOriginalFileName:(NSString *)name
                                  path:(NSString *)path
                           volumeIndex:(int)index;
    // Returns a trunk having the specified 'name', 'path', and 'index'.

- (NSString *)description;
    // Returns a human-readable string describing this object;

@end
