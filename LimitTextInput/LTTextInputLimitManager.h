//
//  LTTextInputLimitManager.h
//  LTCommonKit
//
//  Created by Marike Jave on 14-1-22.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LTTextLimitType) {

    LTTextLimitTypeNone,  // 无限制
    LTTextLimitTypeByte,  // 字节数限制
    LTTextLimitTypeLength,    // 字符个数限制
};

typedef NS_ENUM(NSInteger, LTTextLimitInputType) {
    
    LTTextLimitInputTypeNone,          // 没有限制
    LTTextLimitInputTypeEnglish,       // 纯英文
    LTTextLimitInputTypeChinese,       // 纯中文
    LTTextLimitInputTypeNumber,        // 纯数字
    LTTextLimitInputTypeFloatNumber,   // 小数
    LTTextLimitInputTypeTelephoneNumber,  // 手机号码
    LTTextLimitInputTypeEmail,            // 邮箱
    LTTextLimitInputTypeEnglishOrChinese, // 中英混合
    LTTextLimitInputTypeEnglishOrNumber,  // 英文和数字混合
    LTTextLimitInputTypeEnglishAndChinese, // 中英混合
    LTTextLimitInputTypeEnglishAndNumber,  // 英文和数字混合
};

extern NSString *const LTKeyboardDidReturnNotifacation;

@protocol LTTextInput <UITextInput, UITextInputTraits>

@property(nonatomic, copy) NSString *text;

@property (nonatomic, assign, getter=isCorrect) BOOL correct;

@property (nonatomic, assign) LTTextLimitInputType textLimitInputType;   // Default is LTTextLimitInputTypeNone.
@property (nonatomic, assign) LTTextLimitType textLimitType;       // Default is TextLimitTypeNone.
@property (nonatomic, assign) NSInteger textLimitSize;          // If textLimitType is not TextLimitTypeNone, default is NSIntegerMax, or is 0.
@property (nonatomic, assign) NSInteger minusSize;

@end

@interface LTTextInputLimitManager : NSObject<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) id delegate;

@property (nonatomic, assign) id<LTTextInput> textInput;

+ (BOOL)contentAllowTextInput:(id<LTTextInput>)textInput text:(NSString *)text;

@end
