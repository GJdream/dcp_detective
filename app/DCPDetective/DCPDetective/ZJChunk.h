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

@property NSString *path;   // path to the file containing this chunk
@property int volumeIndex;  // ID of the disk on which this chunk is stored

@end
