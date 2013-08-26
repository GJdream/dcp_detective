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

+ (BOOL)fileExists:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (NSData *)sha1:(NSString *)path
{
    // Read the file contents into memory.

    NSData *data = [NSData dataWithContentsOfFile:path];

    if (!data) {
        return nil;
    }

    // Check that the file size does not exceed the range of the input length
    // parameter to CC_SHA1.

    assert([data length] < 2000000000ULL);

    // Compute the SHA-1 value as a sequence of bytes.

    unsigned char digest[CC_SHA1_DIGEST_LENGTH];

    if (!CC_SHA1([data bytes], (CC_LONG)[data length], digest)) {
        return nil;
    }

    // Copy the hash value into an object, and return the object.

    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}


@end



