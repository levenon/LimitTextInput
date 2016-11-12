//
//  LTFormTextField.h
//  LimitTextInput
//
//  Created by Marike Jave on 14-9-29.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LTLimitTextField.h"

extern NSInteger KDefualtWidth ;

typedef NS_ENUM(NSInteger, LTLineMode){

    LTLineModeScaleToFillAll,
    LTLineModeScaleToFillContent
};
typedef NS_ENUM(NSInteger, LTLineStyle){

    LTLineStyleNone,
    LTLineStyleSolid,
    LTLineStyleDot
};
typedef NS_ENUM(NSInteger, LTFormTextFieldStyle){

    LTFormTextFieldStyleDefault       = 0,            // No line , no title , no detail text
    LTFormTextFieldStyleTitle         = 1 << 1,       // Title enable
    LTFormTextFieldStyleDetail        = 1 << 2,       // Detail text enable
    LTFormTextFieldStyleUnderline     = 1 << 3        // Underline enable
};

@interface LTFormTextField : LTLimitTextField

@property (strong , nonatomic) NSString *title ;
//@property (strong , nonatomic , readonly) UILabel *evlbTitle ;
@property (assign , nonatomic) CGFloat titleWidth;                // Default is KDefualtWidth
@property (strong , nonatomic) UIFont *titleFont;                 // Default is [UIFont systemFontOfSize:13].
@property (strong , nonatomic) UIColor *titleColor;               // Default is blackColor.
@property (assign , nonatomic) NSTextAlignment titleAlignment;    // Default is NSTextAlignmentLeft.

@property (strong , nonatomic) NSString *detail ;
//@property (strong , nonatomic , readonly) UILabel *evlbDetail ;
@property (assign , nonatomic) CGFloat detailWidth;               // Default is KDefualtWidth.
@property (strong , nonatomic) UIFont *detailFont;                // Default is [UIFont systemFontOfSize:13].
@property (strong , nonatomic) UIColor *detailColor;              // Default is blackColor.
@property (assign , nonatomic) NSTextAlignment detailAlignment;   // Default is NSTextAlignmentLeft.

@property (assign , nonatomic) LTLineStyle lineStyle;            // If style & TextFieldStyleUnderline is NO , the line is invisible , default is LineStyleNone.
@property (assign , nonatomic) LTLineMode lineMode;
@property (strong , nonatomic) UIColor *lineColor;                // Default is blackColor. if line image is nil, line color is enable, or use line image.
@property (strong , nonatomic) UIImage *lineImage;                // Default is nil.

@property (assign , nonatomic , readonly) LTFormTextFieldStyle style ;  // Default is FormTextFieldStyleDefault.
- (id)initWithFrame:(CGRect)frame style:(LTFormTextFieldStyle)style;

@end

