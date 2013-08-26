//
//  ZJFileUtil.h
//  DCPDetective
//
//  Created by pantalones on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZJFileUtil : NSObject

+ (BOOL)fileExists:(NSString *)path;
    // Returns true if a file exists at 'path', and false otherwise.

+ (NSData *)sha1:(NSString *)path;
    // Returns the SHA-1 hash value of the contents of the file at 'path'.

@end
