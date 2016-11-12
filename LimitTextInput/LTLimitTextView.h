//
//  LTLimitTextView.h
//  LTCommonKit
//
//  Created by Marike Jave on 14-1-22.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LTTextInputLimitManager.h"

@interface LTLimitTextView : UITextView<LTTextInput>

@property (nonatomic, assign) LTTextLimitInputType textLimitInputType;   // Default is LTTextLimitInputTypeNone.
@property (nonatomic, assign) LTTextLimitType textLimitType;      // Default is TextLimitTypeNone.
@property (nonatomic, assign) NSInteger textLimitSize;          // If textLimitType is not TextLimitTypeNone, default is NSIntegerMax, or is 0.
@property (nonatomic, assign) NSInteger maxSize;
@property (nonatomic, assign) NSInteger minusSize;

@property (nonatomic, assign, getter=isCorrect) BOOL correct;

@end
