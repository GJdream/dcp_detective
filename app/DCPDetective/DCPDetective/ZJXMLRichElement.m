//
//  ZJXMLRichElement.m
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/27/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import "ZJXMLRichElement.h"

#import "ZJXMLUtil.h"

@implementation ZJXMLRichElement

+ (ZJXMLRichElement *)elementWithElement:(NSXMLElement *)element
{
    return [[ZJXMLRichElement alloc] initWithElement:element];
}

- (ZJXMLRichElement *)initWithElement:(NSXMLElement *)element
{
    if ((self = [super init])) {
        _element = element;
    }

    return self;
}

- (NSXMLElement *)child:(NSString *)key
{
    return [ZJXMLUtil child:key of:self.element];
}

- (int)childInt:(NSString *)key
{
    return [ZJXMLUtil childInt:key of:self.element];
}

- (NSString *)childString:(NSString *)key
{
    return [ZJXMLUtil childString:key of:self.element];
}

@end
