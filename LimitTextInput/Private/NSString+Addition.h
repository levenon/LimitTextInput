//
//  NSString+Addition
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c)2014年 Marike Jave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

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
