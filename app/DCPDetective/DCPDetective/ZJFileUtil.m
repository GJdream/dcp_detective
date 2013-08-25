//
//  ZJFileUtil.m
//  DCPDetective
//
//  Created by pantalones on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//
#include <CommonCrypto/CommonDigest.h>

#import "ZJFileUtil.h"

@implementation ZJFileUtil

// File-related methods

+ (BOOL)fileExists:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

// Sha1-Hash related methods
+ (NSData *)sha1:(NSString *)path
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *data = [NSData dataWithContentsOfFile:path];
    assert([data length] < 2000000000ULL);
    CC_SHA1([data bytes], (CC_LONG)[data length], digest);

    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}


@end



