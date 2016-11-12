//
//  LTLimitTextField.h
//  LTCommonKit
//
//  Created by Marike Jave on 4/11/13.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LTTextInputLimitManager.h"

@interface LTLimitTextField : UITextField<LTTextInput>

@property (nonatomic, assign) LTTextLimitInputType textLimitInputType;   // Default is LTTextLimitInputTypeNone.
@property (nonatomic, assign) LTTextLimitType textLimitType;      // Default is TextLimitTypeNone.
@property (nonatomic, assign) NSInteger textLimitSize;          // If textLimitType is not TextLimitTypeNone, default is NSIntegerMax, or is 0.
@property (nonatomic, assign) NSInteger minusSize;

@property (nonatomic, assign, getter=isCorrect) BOOL correct;

@end
