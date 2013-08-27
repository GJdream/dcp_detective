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

// File-related methods

+ (NSXMLDocument *)loadFile:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];

    return [[NSXMLDocument alloc]
            initWithContentsOfURL:url
            options:NSXMLDocumentTidyXML
            error:nil];
}

// Node-related methods

+ (int)intFromChild:(NSString *)key of:(NSXMLElement *)parent
{
    return [self stringFromChild:key of:parent].intValue;
}

+ (NSString *)stringFromChild:(NSString *)key of:(NSXMLElement *)parent
{
    NSArray *children = [parent elementsForName:key];

    if (children.count != 1) {
        NSLog(@"Warning: did not find exactly one value for key %@", key);
        return nil;
    }

    return [[children objectAtIndex:0] stringValue];
}


@end
