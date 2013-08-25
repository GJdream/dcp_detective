//
//  ZJFileUtil.h
//  DCPDetective
//
//  Created by pantalones on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJFileUtil : NSObject

// File-related methods

+ (BOOL)fileExists:(NSString *)path;
// Returns true if a file exists at 'path', and false otherwise.

@end
