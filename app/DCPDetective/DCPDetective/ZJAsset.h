//
//  ZJAsset.h
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJAsset : NSObject
    // Each object of this class represents part of a Digital Cinema Package
    // (DCP).

@property NSString *uuid;            // UUID of this asset
@property NSString *annotationText;  // text describing this asset
@property NSArray *chunkList;        // chunks comprising this asset
@property BOOL packingList;          // true if this asset is a packing list

+ (ZJAsset *)assetWithUUID:(NSString *)uuid
            annotationText:(NSString *)text
                 chunkList:(NSArray *)chunkList
               packingList:(BOOL)packingList;
    // Returns a new ZJAsset having the specified 'uuid', 'chunkList', and
    // 'packingList' property values.

- (NSString *)description;
    // Returns a human-readable description of this object.

@end
