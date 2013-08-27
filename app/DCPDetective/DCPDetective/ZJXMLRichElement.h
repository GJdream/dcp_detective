//
//  ZJXMLRichElement.h
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/27/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJXMLRichElement : NSObject
    // Each object of this class wraps an NSXMLElement, and provides convenient
    // methods for accessing properties of the element.  For example, the
    // 'intChild' method access a child element having a specified tag name,
    // and parses the child's text as an integer.

@property NSXMLElement *element;  // the wrapped XML element

+ (ZJXMLRichElement *)elementWithElement:(NSXMLElement *)element;
    // Returns a rich element wrapping the specified 'element'.

- (ZJXMLRichElement *)initWithElement:(NSXMLElement *)element;
    // Initializes the receiver to wrap the specified 'element'.

- (NSXMLElement *)child:(NSString *)key;
    // Returns the child element having tag 'key'.  The behavior is undefined
    // unless 'parent' has exactly one child for tag 'key'.

- (int)childInt:(NSString *)key;
    // Returns the content of the child element having tag 'key', parsed as an
    // integer.

- (NSString *)childString:(NSString *)key;
    // Returns the content of the child element having tag 'key'.

@end
