//
//  XLFTextInputLimitManager.h
//  XLFCommonKit
//
//  Created by Marike Jave on 14-1-22.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XLFTextLimitType) {

    XLFTextLimitTypeNone,  // 无限制
    XLFTextLimitTypeByte,  // 字节数限制
    XLFTextLimitTypeLength,    // 字符个数限制
};

typedef NS_ENUM(NSInteger, XLFTextLimitInputType) {
    
    XLFTextLimitInputTypeNone,          // 没有限制
    XLFTextLimitInputTypeEnglish,       // 纯英文
    XLFTextLimitInputTypeChinese,       // 纯中文
    XLFTextLimitInputTypeNumber,        // 纯数字
    XLFTextLimitInputTypeFloatNumber,   // 小数
    XLFTextLimitInputTypeTelephoneNumber,  // 手机号码
    XLFTextLimitInputTypeEmail,            // 邮箱
    XLFTextLimitInputTypeEnglishOrChinese, // 中英混合
    XLFTextLimitInputTypeEnglishOrNumber,  // 英文和数字混合
    XLFTextLimitInputTypeEnglishAndChinese, // 中英混合
    XLFTextLimitInputTypeEnglishAndNumber,  // 英文和数字混合
};

extern NSString *const XLFKeyboardDidReturnNotifacation;

@protocol XLFTextInput <UITextInput, UITextInputTraits>

@property(nonatomic, copy) NSString *text;

@property (nonatomic, assign, getter=isCorrect) BOOL correct;

@property (nonatomic, assign) XLFTextLimitInputType textLimitInputType;   // Default is XLFTextLimitInputTypeNone.
@property (nonatomic, assign) XLFTextLimitType textLimitType;       // Default is TextLimitTypeNone.
@property (nonatomic, assign) NSInteger textLimitSize;          // If textLimitType is not TextLimitTypeNone, default is NSIntegerMax, or is 0.
@property (nonatomic, assign) NSInteger minusSize;

@end

@interface XLFTextInputLimitManager : NSObject<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) id delegate;

@property (nonatomic, assign) id<XLFTextInput> textInput;

+ (BOOL)contentAllowTextInput:(id<XLFTextInput>)textInput text:(NSString *)text;

@end
