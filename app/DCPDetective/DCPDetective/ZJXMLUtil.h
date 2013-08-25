//
//  ZJXMLUtil.h
//  DCPDetective
//
//  Created by Jeffrey Schwab on 8/24/13.
//  Copyright (c) 2013 Unbuggy Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJXMLUtil : NSObject



+ (NSXMLDocument *)loadFile:(NSString *)path;
    // Parses the XML file at 'path'.  The behavior is undefined unless the file
    // is readable.

// Node-related methods

+ (NSString *)stringFromChild:(NSString *)key of:(NSXMLElement *)parent;
    // Returns the content of the child element of 'parent' having tag 'key'.

+ (int)intFromChild:(NSString *)key of:(NSXMLElement *)parent;
    // Returns the content of the child element of 'parent' having tag 'key',
    // parsed as an integer.

@end
