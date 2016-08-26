//
//  NSString+Categories
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Categories.h"
#import "NSData+Categories.h"
#import "XLFConstants.h"

XLFLoadCategory(NSString_Categories)

NSString* const egStringBetweenCharactersWordsKey              = @"egStringBetweenCharactersWordsKey";
NSString* const egStringBetweenCharactersWordsRangeKey         = @"egStringBetweenCharactersWordsRangeKey";

@implementation NSString (validate)

#pragma mark - 合法性检查

- (BOOL)isFullEmail{
    
    NSString *email_regex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", email_regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail{
    
    NSString *email_regex = @"^([A-Z0-9a-z._%+-]*)|"
    "([A-Z0-9a-z._%+-]*@[A-Za-z0-9.-]*)|"
    "([A-Z0-9a-z._%+-]*@[A-Za-z0-9.-]*\\.{0,1}[A-Za-z.]{2,})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", email_regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isTelephoneFullNumber{
    
    //添加了兼容 0  +86 前缀方法
    NSString *phoneNumber = [[self class] handlePhoneNumber:self];
    
    NSString *phone_number_regex = @"^1[0-9]{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone_number_regex];
    return [predicate evaluateWithObject:phoneNumber];
}

- (BOOL)isTelephoneNumber{
    
    //添加了兼容 0  +86 前缀方法
    NSString *phoneNumber = [[self class] handlePhoneNumber:self];
    
    NSString *phone_number_regex = @"^(1{0,1})|(1[0-9]{0,10})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone_number_regex];
    return [predicate evaluateWithObject:phoneNumber];
}

//判断是否是电话号码
- (BOOL)isMobileNumber{
    
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349|7[0-9]{2})\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:self] == YES)
    //        || ([regextestcm evaluateWithObject:self] == YES)
    //        || ([regextestct evaluateWithObject:self] == YES)
    //        || ([regextestcu evaluateWithObject:self] == YES))
    //    {
    
    //        return YES;
    //    }
    //    else
    //    {
    
    //        return NO;
    //    }
    //
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1(3|4|5|7|8)\\d{9}$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  数字合法性检查
 *
 *  @return BOOL
 */
- (BOOL)isNumber;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  整数或者小数合法性检查
 *
 *  @return BOOL
 */
- (BOOL)isNumberOrDecimals;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^0|((([1-9]\\d*)|0)\\.\\d*)|([1-9]\\d*)$"];
    
    return [predicate evaluateWithObject:self];
}

/**
 *  英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isEnglishCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([A-Z]|[a-z])*|([A-Z]|[a-z])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  数字或英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isNumberOrEnglishCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d*|(\\d|[A-Z]|[a-z])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  数字和英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isNumberAndEnglishCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中文字符组合的合法性（纯中文）
 *
 *  @return 合法性
 */
- (BOOL)isChineseCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中文字符组合的合法性（包含中文）
 *
 *  @return 合法性
 */
- (BOOL)containChineseCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中英混合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isChineseOrEnglishCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]|[A-Z]|[a-z])*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  中英数字混合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isChineseOrEnglishOrNumberCharacter;{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^([\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]|[A-Z]|[a-z] | \\d)*$"];
    return [predicate evaluateWithObject:self];
}

/**
 *  字符串是否中心对称
 *
 *  @return 对称状态
 */
- (BOOL)isSymmetric;{
    
    for (NSInteger nIndex = 0; nIndex < ([self length] + 1)/2; nIndex++) {
        
        NSString *header = [self substringWithRange:NSMakeRange(nIndex, 1)];
        NSString *tailer = [self substringWithRange:NSMakeRange([self length] - 1 - nIndex, 1)];
        
        if (![header isEqualToString:tailer]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark  处理电话号码
//处理  0 +86 等前缀,系统将统一去掉这些前缀
+ (NSString*)handlePhoneNumber:(NSString*)phoneNumber{
    
    if ([phoneNumber hasPrefix:@"0"]) {
        
        return  [phoneNumber substringFromIndex:1];
    }
    else if([phoneNumber hasPrefix:@"86"]){
        
        return  [phoneNumber substringFromIndex:2];
    }
    else if([phoneNumber hasPrefix:@"+86"]){
        
        return  [phoneNumber substringFromIndex:3];
    }
    else{
        
        return phoneNumber;
    }
}

@end

@implementation  NSString (Length)

- (NSInteger)englishStringLength{
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] ==0 ) {
        
        return 0;
    }else{
        
        const char  *cString = [self UTF8String];
        
        return strlen(cString);
    }
}

/**
 *  计算中英文混合的字符串的字节数
 *
 *  @param string 中英文混合的字符串
 *
 *  @return 字节数
 */
- (NSInteger)stringLength {
    
    NSInteger strlength = 0;
    
    //  这里一定要使用gbk的编码方式，网上有很多用Unicode的，但是混合的时候都不行
    
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    char* p = (char*)[self cStringUsingEncoding:gbkEncoding];
    
    for (NSInteger i=0 ; i<[self lengthOfBytesUsingEncoding:gbkEncoding] ;i++) {
        
        if (p) {
            
            p++;
            strlength++;
        }
        else {
            
            p++;
        }
    }
    return strlength;
}

/**
 *  中英文混合的字符串限制在字节数以内
 *
 *  @param  byteSize 字节数
 *
 *  @return 中英字符
 */
- (NSString*)substringInLimitByteSize:(NSInteger)byteSize;{
    
    NSString *subString = nil;
    NSInteger curLength = 0;
    
    for (NSInteger nIndex = 0; nIndex < [self length]; nIndex++) {
        
        NSString *etSubString = [self substringWithRange:NSMakeRange(nIndex, 1)];
        
        NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        curLength += [etSubString lengthOfBytesUsingEncoding:gbkEncoding];
        
        if (curLength > byteSize && nIndex) {
            
            break;
        }
        else{
            
            subString = [self substringToIndex:nIndex+1];
        }
    }
    return subString;
}

@end

@implementation NSString (Format)

/**
 *  字符串是否为空
 *
 *  @param aString
 *
 *  @return
 */
+ (BOOL)isEmptyString:(NSString*)string;{
    
    return [self emptyString:string].length > 0 ? NO : YES;
}

/**
 *  格式化字符串
 *
 *  @param aString
 *
 *  @return 字符串
 */
+ (NSString *)emptyString:(NSString*)string;{
    
    NSString *resultString = @"";
    if ([string isKindOfClass:[NSNumber class]]) {
        resultString = [NSString stringWithFormat:@"%@",string];
        
        return resultString;
    }
    if ([string length] == 0)
        resultString = @"";
    
    else{
        
        resultString = string;
    }
    return resultString;
}

/**
 *  字节数 追加单位 B,KB,MB,保留2位小数
 *
 *  @param byteSize 字节数
 *
 *  @return 带单位的字节字符串
 */

+ (NSString*)stringFormatByteSize:(NSInteger)byteSize;{
    
    if (byteSize >= 0 && byteSize < 1024) {
        return fmts(@"%dB",byteSize);
    }
    if (byteSize >= 1024 && byteSize < 1024 * 1024) {
        
        return fmts(@"%.2fKB",byteSize/1024.f);
    }
    if (byteSize >= 1024 * 1024) {
        return fmts(@"%.2fMB",byteSize/1024.f/1024.f);
    }
    
    return nil;
}

@end

@implementation  NSString (Transform)

- (NSString*)transformTextToRichText {
    
    NSString *plainData = [NSMutableString stringWithString:self];
    
    NSString *resultData = [NSMutableString string];
    
    NSScanner *scanner = nil;
    NSString *text = nil ;
    NSString *key = nil ;
    
    NSRange range ;
    
    NSInteger begin = 0;
    NSInteger end = 0;
    NSInteger lastEnd = 0;
    
    scanner = [NSScanner scannerWithString:self];
    
    while (![scanner isAtEnd]) {
        
        //Begin element(such sdfdsf[daas]gweasfs[30]gsgsdgsg)
        
        NSString* ch = [self substringWithRange:NSMakeRange([scanner scanLocation ], 1) ];
        
        if ([ch isEqualToString:@"[" ]){
            
            begin = [scanner scanLocation] ;
            end = begin ;
        }
        else if ([ch isEqualToString:@"]" ]){
            
            end = [scanner scanLocation] ;
            
            if ( end > begin ) {
                
                range = NSMakeRange(begin, end - begin + 1 ) ;
                
                text = [plainData substringWithRange: range ] ;
                
                key = [text substringWithRange:NSMakeRange(1, [text length ] - 2 )] ;
                
                NSString *path = [NSString stringWithFormat:@"expression.bundle/%@.gif",key ];
                
                NSString *replaceString = [NSString stringWithFormat:@"<img src=%@>", path ] ;
                
                NSString *appendString = [plainData substringWithRange:NSMakeRange(lastEnd, begin - lastEnd ? begin - lastEnd - 1 : begin - lastEnd ) ] ;
                
                if ( [appendString length ] ) {
                    
                    appendString = [NSString stringWithFormat:@"  %@",appendString ] ;
                }
                
                resultData = [resultData stringByAppendingString: appendString ];
                
                resultData = [resultData stringByAppendingString:replaceString ];
                
                lastEnd = end + 1 ;
            }
        }
        else {
            end = end;
        }
        
        [scanner setScanLocation:[scanner scanLocation]+1 ] ;
    }
    
    NSString *subString = [plainData substringFromIndex:lastEnd ] ;
    
    if ( [subString length ] ) {
        
        subString = [NSString stringWithFormat:@"  %@",subString ] ;
    }
    resultData = [resultData stringByAppendingString:subString ];
    
    NSLog(@"transform:%@" , resultData ) ;
    
    return resultData ;
}

- (NSString*)transformEmojiTextToText ;{
    
    NSString *resultString = nil ;
    
    __block NSString *newString = [self mutableCopy];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         NSString *emojiString = nil ;
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     emojiString = [NSString stringWithFormat:@"<%d#%d>",hs,ls] ;
                 }
             }
         }
         else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 
                 emojiString = [NSString stringWithFormat:@"<%d>",ls] ;
             }
             
         }
         else {
             
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 
                 emojiString = [NSString stringWithFormat:@"<%d>",hs] ;
             }
             else if(0x2B05 <= hs && hs <= 0x2b07) {
                 
                 emojiString = [NSString stringWithFormat:@"<%d>",hs] ;
             }
             else if(0x2934 <= hs && hs <= 0x2935) {
                 
                 emojiString = [NSString stringWithFormat:@"<%d>",hs] ;
             }
             else if(0x3297 <= hs && hs <= 0x3299) {
                 
                 emojiString = [NSString stringWithFormat:@"<%d>",hs] ;
             }
             else if(hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 
                 emojiString = [NSString stringWithFormat:@"<%d>",hs] ;
             }
         }
         if ( emojiString ) {
             
             newString = [newString stringByReplacingOccurrencesOfString:substring withString:emojiString ];
         }
     }] ;
    
    resultString = [newString mutableCopy] ;
    
    return resultString ;
}

- (NSString*)transformTextToEmojiText;{
    
    NSString *plainData = [NSString stringWithString:self];
    NSString *resultData = [NSString string];
    NSScanner *scanner = nil;
    NSString *text = nil ;
    NSString *key = nil ;
    NSRange range ;
    NSInteger begin = 0;
    NSInteger end = 0;
    NSInteger lastEnd = 0;
    
    scanner = [NSScanner scannerWithString:self];
    
    while (![scanner isAtEnd]) {
        
        //Begin element(such sdfdsf[daas]gweasfs[30]gsgsdgsg)
        
        NSString* ch = [self substringWithRange:NSMakeRange([scanner scanLocation ], 1) ];
        
        if ([ch isEqualToString:@"<" ]){
            
            end = begin = [scanner scanLocation] ;
        }
        else if ([ch isEqualToString:@">" ]){
            
            end = [scanner scanLocation] ;
            
            if ( end > begin ) {
                
                range = NSMakeRange(begin, end - begin + 1 ) ;
                
                text = [plainData substringWithRange: range ] ;
                
                key = [text substringWithRange:NSMakeRange(1, [text length ] - 2 )] ;
                
                NSString *emojiValue = nil ;
                
                NSRange cutRange = [key rangeOfString:@"#"] ;
                
                unichar str[2] ;
                
                if (cutRange.length) {
                    
                    unichar hs = [[key substringToIndex:cutRange.location] integerValue ] ;
                    
                    unichar ls = [[key substringFromIndex:cutRange.location+1] integerValue ] ;
                    
                    if (0xd800 <= hs && hs <= 0xdbff) {
                        
                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                        
                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                            
                            str[0] = hs ;
                            str[1] = ls ;
                            
                            emojiValue = [NSString stringWithCharacters:str length:2 ] ;
                        }
                        else{
                            
                            emojiValue = [text mutableCopy ] ;
                        }
                    }
                    else if(ls == 0x20e3){
                        
                        str[0] = 0 ;
                        str[1] = ls ;
                        
                        emojiValue = [NSString stringWithCharacters:str length:2 ] ;
                    }
                    else{
                        
                        emojiValue = [text mutableCopy ] ;
                    }
                }
                
                else{
                    
                    unichar hs = [key integerValue ] ;
                    
                    if ((0x2100 <= hs && hs <= 0x27ff) ||
                        (0x2B05 <= hs && hs <= 0x2b07) ||
                        (0x3297 <= hs && hs <= 0x3299) ||
                        hs == 0xa9 ||
                        hs == 0xae ||
                        hs == 0x303d ||
                        hs == 0x3030 ||
                        hs == 0x2b55 ||
                        hs == 0x2b1c ||
                        hs == 0x2b1b ||
                        hs == 0x2b50) {
                        
                        str[0] = hs ;
                        emojiValue = [NSString stringWithCharacters:str length:1 ] ;
                    }
                    else{
                        
                        emojiValue = [text mutableCopy ] ;
                    }
                }
                
                NSString *appendString = [plainData substringWithRange:NSMakeRange(lastEnd, begin - lastEnd ? begin - lastEnd - 1 : begin - lastEnd ) ] ;
                
                if ( [appendString length ] ) {
                    
                    appendString = [NSString stringWithFormat:@"%@",appendString ] ;
                }
                
                resultData = [resultData stringByAppendingString: appendString ];
                
                resultData = [resultData stringByAppendingString:emojiValue ];
                
                lastEnd = end + 1 ;
            }
        }
        else{
            end = end;
        }
        
        [scanner setScanLocation:[scanner scanLocation]+1 ] ;
    }
    
    NSString *subString = [plainData substringFromIndex:lastEnd ] ;
    
    resultData = [resultData stringByAppendingString:subString ];
    
    NSLog(@"transform:%@" , resultData ) ;
    
    return resultData ;
}

/**
 *  16进制字符串转成整型
 *
 *  @return 整型数
 */
- (NSInteger)hexValue;{
    
    NSString *strHex = [self mutableCopy];
    strHex = [strHex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    strHex = [strHex stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    
    unsigned int integer;
    NSScanner * scanner = [[NSScanner alloc] initWithString:strHex];
    [scanner scanHexInt: &integer];
    return integer;
}

/**
 *  影藏手机号码4-7位
 *
 *  @return 转化后的电话号码
 */
- (NSString *)secretTelephone;{
    
    NSInteger offset = 0;
    
    if ([self hasPrefix:@"0"]) {
        offset = 1;
    }
    
    if ([self hasPrefix:@"86"]) {
        offset = 2;
    }
    
    if ([self hasPrefix:@"+86"]) {
        offset = 3;
    }
    
    NSString *telephone = [self substringFromIndex:offset];
    
    if ([telephone isTelephoneFullNumber]) {
        
        return [self stringByReplacingCharactersInRange:NSMakeRange(offset + 3, 4) withString:@"****"];
    }
    return nil;
}

@end

@implementation NSString (Code)

/**
 *  转换成MD5
 *
 *  @return md5的字符串 默认小写
 */
- (NSString*)encodeMD5;{
    
    return [self encodeMD5Uppercase:NO];
}

/**
 *  转换成MD5
 *
 *  @param uppercase 是否大写
 *
 *  @return md5的字符串
 */
- (NSString*)encodeMD5Uppercase:(BOOL)uppercase;{
    
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return uppercase ? [hash uppercaseString ] : [hash lowercaseString ];
}

/**
 *  转换成SHA1
 *
 *  @return md5的字符串 默认小写
 */
- (NSString*)encodeSHA1;{
    
    return [self encodeSHA1Uppercase:NO];
}

/**
 *  转换成SHA1
 *
 *  @param uppercase 是否大写
 *
 *  @return md5的字符串
 */
- (NSString*)encodeSHA1Uppercase:(BOOL)uppercase;{
    
    const char *original_str = [self UTF8String];
    unsigned char result[16];
    
    CC_SHA1(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return uppercase ? [hash uppercaseString ] : [hash lowercaseString ];
}

/**
 *  url 编码转换
 *
 *  @param encoding 编码类型
 *
 *  @return 编码后的url
 */
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;{
    
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 CFSTR("!*'\"();:@&=+$,/?%#[]% "),CFStringConvertNSStringEncodingToEncoding(encoding));
}

/**
 *  url 解码转换
 *
 *  @param encoding 解码类型
 *
 *  @return 解码后的url
 */
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;{
    
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end

@implementation NSString (Utils)

/**
 *  html字符串转换成纯文本
 *
 *  @return 纯文本
 */
- (NSString *)htmlFlatten;{
    
    NSString *text = nil;
    NSString *html = [self mutableCopy];
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    while (![theScanner isAtEnd]) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
    }
    return html;
}

/**
 *  token 去掉尖括号 和 空格
 *
 *  @return 返回连续的字符串
 */
- (NSString *)tokenByTrimmingCharactersAndSpace;{
    
    return  [[self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 *  拆分字符串
 *
 *  @param from 起始字符串
 *  @param to   结尾字符串
 *
 *  @return 字符串数组
 */
- (NSArray *)stringBetweenCharactersSeparatedFrom:(NSString *)from to:(NSString *)to;{
    
    NSString *stringBetweenBrackets = nil;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSUInteger fIndex = 0;
    NSUInteger tIndex = 0;
    while (![scanner isAtEnd]) {
        
        stringBetweenBrackets = nil;
        [scanner scanUpToString:from intoString:nil];
        fIndex = [scanner scanLocation];
        [scanner scanString:from intoString:nil];
        [scanner scanUpToString:to intoString:&stringBetweenBrackets];
        tIndex = [scanner scanLocation];
        if (stringBetweenBrackets) {
            
            @autoreleasepool {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:stringBetweenBrackets forKey:egStringBetweenCharactersWordsKey];
                [dic setObject:[NSValue valueWithRange:NSMakeRange(fIndex, tIndex + 1 - fIndex)] forKey:egStringBetweenCharactersWordsKey];
                [array addObject:dic];
            }
        }
    }
    return array;
}

/**
 *  截取头部字符串
 *
 *  @param toIndex 截取长度
 *
 *  @return 截取后的字符串
 */
- (NSString *)headStringWithLength:(NSInteger)length;{
    
    length = MIN([self length], length);
    length = MAX(0, length);
    
    if (length > 0) {
        
        return [self substringToIndex:length - 1];
    }
    return nil;
}

/**
 *  截取尾部字符串
 *
 *  @param fromIndex 截取起点
 *
 *  @return 截取后的字符串
 */
- (NSString *)lastStringWithLength:(NSInteger)length;{
    
    length = MIN([self length], length);
    
    if (length > 0) {
        
        return [self substringFromIndex:[self length] - length];
    }
    return nil;
}

@end

@implementation NSString (TextSize)

/**
 *  有限宽度计算文本高度
 *
 *  @param font   字体
 *  @param height 宽度
 *
 *  @return 高度
 */
- (CGFloat)heightWithFont:(UIFont*)font forWidth:(CGFloat)width;{
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        return [self boundingRectWithSize:CGSizeMake(width, NSIntegerMax)
                                  options:NSStringDrawingTruncatesLastVisibleLine|
                NSStringDrawingUsesLineFragmentOrigin|
                NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil].size.height;
    }
    return [self sizeWithFont:font constrainedToSize:CGSizeMake(width, NSIntegerMax)].height;
}

/**
 *  有限高度计算文本宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 宽度
 */
- (CGFloat)widthWithFont:(UIFont*)font forHeight:(CGFloat)height;{
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        return [self boundingRectWithSize:CGSizeMake(NSIntegerMax, height)
                                  options:NSStringDrawingTruncatesLastVisibleLine|
                NSStringDrawingUsesLineFragmentOrigin|
                NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil].size.width;
    }
    return [self sizeWithFont:font constrainedToSize:CGSizeMake(NSIntegerMax, height)].width;
}

@end

@implementation NSString (JSONDeserializing)

- (id)objectFromJSONString;{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
}

- (id)objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options;{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONDataWithParseOptions:options];
}

- (id)objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONDataWithParseOptions:options error:error];
}

- (id)mutableObjectFromJSONString;{
    return [[self objectFromJSONString] mutableCopy];
}

- (id)mutableObjectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options;{
    return [[self objectFromJSONStringWithParseOptions:options] mutableCopy];
}

- (id)mutableObjectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;{
    return [[self objectFromJSONStringWithParseOptions:options] mutableCopy];
}

@end
