//
//  LTPlaceholderTextView.h
//  LimitTextInput
//
//  Created by Marike Jave on 13-11-7.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LTLimitTextView.h"

@interface LTPlaceholderTextView : LTLimitTextView

@property(nonatomic, copy  ) NSString *placeholder;

@property(nonatomic, strong) UIColor *placeholderTextColor;

@end
