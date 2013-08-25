//
//  ZJAssetMap.h
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJAssetMap : NSObject
    // Each object of this class represents a set of assets (i.e., files)
    // comprising a Digital Cinema Package (DCP).
    //
    // TODO: Add remaining AssetMap properties.

// DATA

@property NSString *uuid;       // UUID of this map
@property int volumeCount;      // number of disks storing assets
@property NSString *issueDate;  // when this DCP was issued
@property NSString *issuer;     // who issued this DCP
@property NSString *creator;    // application used to create this DCP
@property NSArray *assetList;   // assets comprising this DCP

// METHODS

- (NSString *)description;
    // Returns a string representing this object.

@end
