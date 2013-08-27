//
//  ZJXMLRichElement.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/27/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJXMLRichElement.h"

@implementation ZJXMLRichElement

+ (ZJXMLRichElement *)elementWithContentsOfFile:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];

    NSXMLDocument *doc = [[NSXMLDocument alloc]
                          initWithContentsOfURL:url
                          options:NSXMLDocumentTidyXML
                          error:nil];

    if (!doc) {
        NSLog(@"Warning: could not load XML file: %@", path);
        return nil;
    }

    return [self elementWithElement:doc.rootElement];
}

+ (ZJXMLRichElement *)elementWithElement:(NSXMLElement *)element
{
    ZJXMLRichElement *result = [[ZJXMLRichElement alloc] init];

    result.element = element;
    
    return result;
}

- (ZJXMLRichElement *)child:(NSString *)key
{
    NSArray *children = [self.element elementsForName:key];

    if (children.count != 1) {
        NSLog(@"Warning: did not find exactly one value for key %@", key);
        return nil;
    }

    return [ZJXMLRichElement elementWithElement:[children objectAtIndex:0]];
}

- (NSUInteger)childCount
{
    return self.element.childCount;
}

- (int)childInt:(NSString *)key
{
    return [self childString:key].intValue;
}

- (NSArray *)children
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.childCount];

    for (NSXMLElement *child in self.element.children) {
        [result addObject:[ZJXMLRichElement elementWithElement:child]];
    }

    return result;
}

- (NSString *)childString:(NSString *)key
{
    return [self child:key].element.stringValue;
}

- (NSString *)childStringOrEmpty:(NSString *)key
{
    return [self hasChild:key] ? [self childString:key] : @"";
}

- (BOOL)hasChild:(NSString *)key
{
    return [self.element elementsForName:key].count != 0;
}

@end
