//
//  XLFLimitTextField.h
//  XLFCommonKit
//
//  Created by Marike Jave on 4/11/13.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XLFTextInputLimitManager.h"

@interface XLFLimitTextField : UITextField<XLFTextInput>

@property (nonatomic, assign) XLFTextLimitInputType textLimitInputType;   // Default is XLFTextLimitInputTypeNone.
@property (nonatomic, assign) XLFTextLimitType textLimitType;      // Default is TextLimitTypeNone.
@property (nonatomic, assign) NSInteger textLimitSize;          // If textLimitType is not TextLimitTypeNone, default is NSIntegerMax, or is 0.
@property (nonatomic, assign) NSInteger minusSize;

@property (nonatomic, assign, getter=isCorrect) BOOL correct;

@end
