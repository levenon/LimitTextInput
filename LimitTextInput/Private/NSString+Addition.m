//
//  NSString+Addition
//  LimitTextInput
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSString+Addition.h"
#import "LTConstants.h"

LTLoadCategory(NSString_Addition)

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
