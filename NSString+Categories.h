//
//  NSString+Categories
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c)2014年 Marike Jave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma mark 类型转换

/**
 *  格式化字符串
 */
#define fmts(fmt,...)                                      [NSString stringWithFormat:fmt, ##__VA_ARGS__]

/**
 *  BOOL 转换成NSNumber
 */
#define bton(bool)                                         [NSNumber numberWithBool:bool]

/**
 *  BOOL 转换成NSString
 */
#define btos(bool)                                         [NSString stringWithFormat:@"%d", bool]

/**
 *  NSInteger 转换成NSString
 */

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE)|| TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#define itos(integer)                                      [NSString stringWithFormat:@"%ld", (long)integer]
#define uitos(integer)                                      [NSString stringWithFormat:@"%lu", (unsigned long)integer]
#else
#define itos(integer)                                      [NSString stringWithFormat:@"%d", integer]
#define uitos(integer)                                      [NSString stringWithFormat:@"%u", integer]
#endif

/**
 *  NSInteger 转换成NSNumber
 */
#define iton(integer)                                       [NSNumber numberWithInteger:integer]

/**
 *  CGFloat 转换成NSString
 */
#define ftos(flo)                                           [NSString stringWithFormat:@"%f", flo]

#define ftods(flo, numberOfDecimals)                        [NSString stringWithFormat:fmts(@"%%.%df",numberOfDecimals), flo]

/**
 *  float 转换成NSNumber
 */
#define fton(float)                                         [NSNumber numberWithFloat:float]

/**
 *   double 转换成NSNumber
 */
#define dton(double)                                        [NSNumber numberWithDouble:double]

/**
 *   BOOL 转换成NSNumber
 */
#define bton(bool)                                          [NSNumber numberWithBool:bool]

/**
 *  NSObject 转换成NSString
 */
#define otos(object)                                       [NSString stringWithFormat:@"%@", object]

/**
 *  NULL 转换成 空NSString
 */
#define ntoe(string)                                       [NSString emptyString:string]

/**
 *  NULL 转换成 NSNull
 */
#define ntonull(string)                                    select(string,string,[NSNull null])

/**
 *  NULL 转换成 默认对象
 */
#define ntodefault(obj , defaultClass)                     select(obj && [obj isKindOfClass:defaultClass], obj, [defaultClass new])

#define nstodefault(string , defaultString)                select(string && [string isKindOfClass:[NSString class]] && [string length], string, defaultString)

/**
 *  空串 转化成 默认字符串
 */
#define etodefault(sring , deft)                           select([string length], string, deft)

/**
 *  格式化字符串
 */
#define itoBS(integer)                                     [NSString stringWithByteSize:integer]


extern NSString* const egStringBetweenCharactersWordsKey;
extern NSString* const egStringBetweenCharactersWordsRangeKey;

@interface NSString (validate)

/**
 *  email合法性检查
 *
 *  @param email 邮箱地址
 *
 *  @return BOOL
 */
- (BOOL)isFullEmail;

- (BOOL)isEmail;

/**
 *  手机号码合法性检查
 *
 *  @param phoneNumber 电话号码
 *
 *  @return BOOL
 */
- (BOOL)isTelephoneFullNumber;

- (BOOL)isTelephoneNumber;

/**
 *  手机号码合法性检查
 *
 *  @param mobileNum 手机号码
 *
 *  @return BOOL
 */
- (BOOL)isMobileNumber __deprecated;

/**
 *  数字合法性检查
 *
 *  @param mobileNum 手机号码
 *
 *  @return BOOL
 */
- (BOOL)isNumber;

/**
 *  整数或者小数合法性检查
 *
 *  @param mobileNum 手机号码
 *
 *  @return BOOL
 */
- (BOOL)isNumberOrDecimals;

/**
 *  英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isEnglishCharacter;

/**
 *  数字或英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isNumberOrEnglishCharacter;

/**
 *  数字和英文字母组合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isNumberAndEnglishCharacter;

/**
 *  中文字符组合的合法性（纯中文）
 *
 *  @return 合法性
 */
- (BOOL)isChineseCharacter;

/**
 *  中文字符组合的合法性（包含中文）
 *
 *  @return 合法性
 */
- (BOOL)containChineseCharacter;

/**
 *  中英混合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isChineseOrEnglishCharacter;

/**
 *  中英数字混合的合法性
 *
 *  @return 合法性
 */
- (BOOL)isChineseOrEnglishOrNumberCharacter;

/**
 *  字符串是否中心对称
 *
 *  @return 对称状态
 */
- (BOOL)isSymmetric;

@end

@interface NSString (Length)

/**
 *  获取字符长度
 *
 *  @param string 字符串
 *
 *  @return 字符串长度
 */
- (NSInteger)englishStringLength;

/**
 *  计算中英文混合的字符串的字节数
 *
 *  @param string 中英文混合的字符串
 *
 *  @return 字节数
 */
- (NSInteger)stringLength;

/**
 *  中英文混合的字符串限制在字节数以内
 *
 *  @param  byteSize 字节数
 *
 *  @return 中英字符
 */
- (NSString*)substringInLimitByteSize:(NSInteger)byteSize;

@end

@interface NSString (Format)

/**
 *  字符串是否为空
 *
 *  @param aString
 *
 *  @return
 */
+ (BOOL)isEmptyString:(NSString*)string;

/**
 *  空指针 转化成 空字符串
 *
 *  @param aString
 *
 *  @return 字符串
 */
+ (NSString *)emptyString:(NSString*)string;

/**
 *  字节数 追加单位 B,KB,MB,保留2位小数
 *
 *  @param byteSize 字节数
 *
 *  @return 带单位的字节字符串
 */
+ (NSString*)stringFormatByteSize:(NSInteger)byteSize;

@end

@interface NSString (Transform)

/**
 *  将带富文本编码的字符串转换成富文本
 *
 *  @param string 字符串
 *
 *  @return 富文本
 */
- (NSString*)transformTextToRichText;

/**
 *  将带Emoji编码的字符串转换成Emoji字符串
 *
 *  @param string 字符串
 *
 *  @return Emoji文本
 */
- (NSString*)transformEmojiTextToText;

/**
 *  将带Emoji的字符串转换成Emoji编码字符串
 *
 *  @param string Emoji字符串
 *
 *  @return Emoji编码字符串
 */
- (NSString*)transformTextToEmojiText;

/**
 *  16进制字符串转成整型
 *
 *  @return 整型数
 */
- (NSInteger)hexValue;

/**
 *  影藏手机号码4-7位
 *
 *  @return 转化后的电话号码
 */
- (NSString *)secretTelephone;

@end

@interface NSString (Code)

/**
 *  转换成MD5
 *
 *  @return md5的字符串 默认小写
 */
- (NSString*)encodeMD5;

/**
 *  转换成MD5
 *
 *  @param uppercase 是否大写
 *
 *  @return md5的字符串
 */
- (NSString*)encodeMD5Uppercase:(BOOL)uppercase;

/**
 *  转换成SHA1
 *
 *  @return md5的字符串 默认小写
 */
- (NSString*)encodeSHA1;

/**
 *  转换成SHA1
 *
 *  @param uppercase 是否大写
 *
 *  @return md5的字符串
 */
- (NSString*)encodeSHA1Uppercase:(BOOL)uppercase;

/**
 *  url 编码转换
 *
 *  @param encoding 编码类型
 *
 *  @return 编码后的url
 */
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

/**
 *  url 解码转换
 *
 *  @param encoding 解码类型
 *
 *  @return 解码后的url
 */
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;

@end

@interface NSString (Utils)

/**
 *  html字符串转换成纯文本
 *
 *  @return 纯文本
 */
- (NSString *)htmlFlatten;

/**
 *  token 去掉尖括号 和 空格
 *
 *  @return 返回连续的字符串
 */
- (NSString *)tokenByTrimmingCharactersAndSpace;

/**
 *  拆分字符串
 *
 *  @param from 起始字符串
 *  @param to   结尾字符串
 *
 *  @return 字符串数组
 */
- (NSArray *)stringBetweenCharactersSeparatedFrom:(NSString *)from to:(NSString *)to;

/**
 *  截取头部字符串
 *
 *  @param toIndex 截取终点
 *
 *  @return 截取后的字符串
 */
- (NSString *)headStringWithLength:(NSInteger)length;

/**
 *  截取尾部字符串
 *
 *  @param fromIndex 截取起点
 *
 *  @return 截取后的字符串
 */
- (NSString *)lastStringWithLength:(NSInteger)length;

@end

@interface NSString (TextSize)

/**
 *  有限宽度计算文本高度
 *
 *  @param font   字体
 *  @param height 宽度
 *
 *  @return 高度
 */
- (CGFloat)heightWithFont:(UIFont*)font forWidth:(CGFloat)width;

/**
 *  有限高度计算文本宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 宽度
 */
- (CGFloat)widthWithFont:(UIFont*)font forHeight:(CGFloat)height;

@end

@interface NSString (JSONDeserializing)

- (id)objectFromJSONString;
- (id)objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options;
- (id)objectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;
- (id)mutableObjectFromJSONString;
- (id)mutableObjectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options;
- (id)mutableObjectFromJSONStringWithParseOptions:(NSJSONReadingOptions)options error:(NSError **)error;
@end
