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

+ (ZJXMLRichElement *)elementWithContentsOfFile:(NSString *)path;
    // Returns a rich element representing the contents of the file at 'path',
    // or nil if the file cannot be parsed.

+ (ZJXMLRichElement *)elementWithElement:(NSXMLElement *)element;
    // Returns a rich element wrapping the specified 'element'.

- (ZJXMLRichElement *)child:(NSString *)key;
    // Returns the child element having tag 'key', or nil if the receiver does
    // not have exactly one matching child.

- (NSUInteger)childCount;
    // Returns the number of children in the wrapped element.

- (int)childInt:(NSString *)key;
    // Returns the content of the child element having tag 'key', parsed as an
    // integer.

- (NSArray *)children;
    // Returns an array of ZJXMLRichElement objects wrapping the children of
    // the wrapped NSXMLElement.

- (NSString *)childString:(NSString *)key;
    // Returns the content of the child element having tag 'key'.

- (NSString *)childStringOrEmpty:(NSString *)key;
    // Returns the content of the child element having tag 'key', or an empty
    // string if no child has tag 'key'.

- (BOOL)hasChild:(NSString *)key;
    // Returns true if the receiver has a child element for tag 'key'.

@end
