//
//  NSData+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/9/23.
//  Copyright © 2015年 Marike Jave. All rights reserved.
//

#import "NSData+Categories.h"
#import "XLFConstants.h"

XLFLoadCategory(NSData_Categories)

static char encodingTable[64] = {
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
    'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
    'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
    'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };

@implementation NSData(Categories)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    NSData *result = [[NSData alloc] initWithBase64EncodedString:string];
    return result;
}

- (id)initWithBase64EncodedString:(NSString *)string {
    NSMutableData *mutableData = nil;
    
    if( string ){
        unsigned long ixtext = 0;
        unsigned long lentext = 0;
        unsigned char ch = 0;
        unsigned char inbuf[4], outbuf[3];
        short i = 0, ixinbuf = 0;
        BOOL flignore = NO;
        BOOL flendtext = NO;
        NSData *base64Data = nil;
        const unsigned char *base64Bytes = nil;
        
        // Convert the string to ASCII data.
        base64Data = [string dataUsingEncoding:NSASCIIStringEncoding];
        base64Bytes = [base64Data bytes];
        mutableData = [NSMutableData dataWithCapacity:[base64Data length]];
        lentext = [base64Data length];
        
        while( YES ){
            if( ixtext >= lentext )break;
            ch = base64Bytes[ixtext++];
            flignore = NO;
            
            if( ( ch >= 'A' )&& ( ch <= 'Z' ))ch = ch - 'A';
            else if( ( ch >= 'a' )&& ( ch <= 'z' ))ch = ch - 'a' + 26;
            else if( ( ch >= '0' )&& ( ch <= '9' ))ch = ch - '0' + 52;
            else if( ch == '+' )ch = 62;
            else if( ch == '=' )flendtext = YES;
            else if( ch == '/' )ch = 63;
            else flignore = YES;
            
            if( ! flignore ){
                short ctcharsinbuf = 3;
                BOOL flbreak = NO;
                
                if( flendtext ){
                    if( ! ixinbuf )break;
                    if( ( ixinbuf == 1 ) || ( ixinbuf == 2 ))ctcharsinbuf = 1;
                    else ctcharsinbuf = 2;
                    ixinbuf = 3;
                    flbreak = YES;
                }
                
                inbuf [ixinbuf++] = ch;
                
                if( ixinbuf == 4 ){
                    ixinbuf = 0;
                    outbuf [0] = ( inbuf[0] << 2 ) | ( ( inbuf[1] & 0x30)>> 4 );
                    outbuf [1] = ( ( inbuf[1] & 0x0F )<< 4 ) | ( ( inbuf[2] & 0x3C )>> 2 );
                    outbuf [2] = ( ( inbuf[2] & 0x03 )<< 6 ) | ( inbuf[3] & 0x3F );
                    
                    for( i = 0; i < ctcharsinbuf; i++ )
                        [mutableData appendBytes:&outbuf[i] length:1];
                }
                
                if( flbreak ) break;
            }
        }
    }
    
    self = [self initWithData:mutableData];
    return self;
}

#pragma mark -

- (NSString *)base64EncodingString {
    
    return [self base64EncodingStringWithLineLength:0];
}

- (NSString *)base64EncodingStringWithLineLength:(unsigned int)lineLength {
    
    const unsigned char    *bytes = [self bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:[self length]];
    unsigned long ixtext = 0;
    unsigned long lentext = [self length];
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    short i = 0;
    short charsonline = 0, ctcopy = 0;
    unsigned long ix = 0;
    
    while( YES ){
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 )break;
        
        for( i = 0; i < 3; i++ ){
            ix = ixtext + i;
            if( ix < lentext )inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        
        outbuf [0] = (inbuf [0] & 0xFC)>> 2;
        outbuf [1] = ((inbuf [0] & 0x03)<< 4) | ((inbuf [1] & 0xF0)>> 4);
        outbuf [2] = ((inbuf [1] & 0x0F)<< 2) | ((inbuf [2] & 0xC0)>> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        
        switch( ctremaining ){
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for( i = 0; i < ctcopy; i++ ){
            
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        }
        for( i = ctcopy; i < 4; i++ ){
         
            [result appendFormat:@"%c",'='];
        }
        ixtext += 3;
        charsonline += 4;
        
        if( lineLength > 0 ){
            if (charsonline >= lineLength){
                charsonline = 0;
                [result appendString:@"\n"];
            }
        }
    }
    
    return result;
}

- (NSString*)urlEncodedString
{
    char *hex = "0123456789ABCDEF";
    unsigned char* data = (unsigned char*)[self bytes];
    NSUInteger len = [self length];
    //NSLog(@"len = %d", len);
    NSMutableString* s = [NSMutableString string];
    for(int i = 0;i<len;i++){
        unsigned char c = data[i];
        if( ('a' <= c && c <= 'z')
           || ('A' <= c && c <= 'Z')
           || ('0' <= c && c <= '9')){
            NSString* ts = [[NSString alloc] initWithBytes:(char *)&c length:1 encoding:NSUTF8StringEncoding];
            
            [s appendString:ts];
        } else {
            [s appendString:@"%"];
            char ts1 = hex[c >> 4];
            //	NSLog(@"ts = %c", ts1);
            NSString* ts = [[NSString alloc] initWithBytes:&ts1 length:1 encoding:NSUTF8StringEncoding];
            [s appendString:ts];
            char ts2 = hex[c & 15];
            ts = [[NSString alloc] initWithBytes:&ts2 length:1 encoding:NSUTF8StringEncoding];
            [s appendString:ts];
            
        }
    }
    return s;
}

@end

@implementation NSData (JSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}

- (id)objectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options;{
    return [NSJSONSerialization JSONObjectWithData:self options:options error:nil];
}

- (id)objectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;{
    return [NSJSONSerialization JSONObjectWithData:self options:options error:error];
}

- (id)mutableObjectFromJSONData;{
    return [[self objectFromJSONData] mutableCopy];
}

- (id)mutableObjectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options;{
    return [[self objectFromJSONDataWithParseOptions:options] mutableCopy];
}

- (id)mutableObjectFromJSONDataWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;{
    return [[self objectFromJSONDataWithParseOptions:options error:error] mutableCopy];
}

@end
