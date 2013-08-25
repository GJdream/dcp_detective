//
//  ZJXMLUtil.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJXMLUtil.h"
#import "ZJFileUtil.h"

@implementation ZJXMLUtil

// Node-related methods

+ (NSString *)stringFromChild:(NSString *)key of:(NSXMLElement *)parent
{
    NSString *result = nil;

    for (NSXMLElement *child in [parent elementsForName:key]) {
        result = [child stringValue];
    }

    return result;
}

+ (int)intFromChild:(NSString *)key of:(NSXMLElement *)parent
{
    int result = 0;

    for (NSXMLElement *child in [parent elementsForName:key]) {
        result = [[child stringValue] intValue];
    }

    return result;
}

@end
