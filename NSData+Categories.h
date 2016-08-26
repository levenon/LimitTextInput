//
//  NSData+Categories.h
//  XLFCommonKit
//
//  Created by Marike Jave on 15/9/23.
//  Copyright © 2015年 Marike Jave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(Categories)

+ (NSData *) dataWithBase64EncodedString:(NSString *) string;
- (id) initWithBase64EncodedString:(NSString *) string;

- (NSString *) base64EncodingString;
- (NSString *) base64EncodingStringWithLineLength:(unsigned int) lineLength;
- (NSString *) urlEncodedString;

@end

@interface NSData (JSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;
- (id)objectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options;
- (id)objectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;
- (id)mutableObjectFromJSONData;
- (id)mutableObjectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options;
- (id)mutableObjectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;
@end
