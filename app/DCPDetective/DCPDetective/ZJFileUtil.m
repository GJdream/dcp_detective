//
//  ZJFileUtil.m
//  DCPDetective
//
//  Created by pantalones on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJFileUtil.h"

@implementation ZJFileUtil

// File-related methods

+ (BOOL)fileExists:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end



