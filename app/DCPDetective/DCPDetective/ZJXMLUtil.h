//
//  ZJXMLUtil.h
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJXMLUtil : NSObject
    // This stateless utility class provides static methods for working with
    // XML documents.

// File-related methods

+ (NSXMLDocument *)loadFile:(NSString *)path;
    // Parses the XML file at 'path'.  The behavior is undefined unless the file
    // is readable.

// Node-related methods

+ (NSXMLElement *)child:(NSString *)key of:(NSXMLElement *)parent;
    // Returns the child element of 'parent' having tag 'key'.  The behavior is
    // undefined unless 'parent' has exactly one child for tag 'key'.

+ (int)childInt:(NSString *)key of:(NSXMLElement *)parent;
    // Returns the content of the child element of 'parent' having tag 'key',
    // parsed as an integer.

+ (NSString *)childString:(NSString *)key of:(NSXMLElement *)parent;
    // Returns the content of the child element of 'parent' having tag 'key'.

@end
