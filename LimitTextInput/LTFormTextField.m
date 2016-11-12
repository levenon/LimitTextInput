//
//  LTFormTextField.m
//  LimitTextInput
//
//  Created by Marike Jave on 14-9-29.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "LTFormTextField.h"

NSInteger KDefualtWidth = 100;
@interface LTFormTextField ()
@property (strong , nonatomic) UILabel *titleLabel ;
@property (strong , nonatomic) UILabel *detailLabel ;
@property (strong , nonatomic) UIImageView *underline ;
@property (assign , nonatomic) LTFormTextFieldStyle style ;

@property (strong , nonatomic) NSLayoutConstraint *lineLeft;
@property (strong , nonatomic) NSLayoutConstraint *lineRight;
@property (strong , nonatomic) NSLayoutConstraint *lineHeight;
@property (strong , nonatomic) NSLayoutConstraint *lineBottom;

@end
@implementation LTFormTextField

- (void)dealloc{
    [self setTitleLabel:nil];
    [self setDetailLabel:nil];
    [self setUnderline:nil];
}

- (id)initWithFrame:(CGRect)frame style:(LTFormTextFieldStyle)style;{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor blackColor]];
        [self setFont:[UIFont systemFontOfSize:13]];
        [self setLineColor:[UIColor grayColor]];
        [self setStyle:style];
        [self setTitleWidth:KDefualtWidth];
        [self setDetailWidth:KDefualtWidth];
    }
    return self;
}

- (void)setLineStyle:(LTLineStyle)lineStyle{
    if (!([self style] & LTFormTextFieldStyleUnderline)) {
        return;
    }
    _lineStyle = lineStyle;
    switch (lineStyle) {
        case LTLineStyleNone:
            [[self underline] setImage:nil];
            break;
        case LTLineStyleDot:
            [[self underline] setImage:[UIImage imageNamed:@"line_dot"]];
            break;
        case LTLineStyleSolid:
            [[self underline] setImage:[UIImage imageNamed:@"line_solid"]];
            break;
        default:
            break;
    }
}

//- (void)setFrame:(CGRect)frame{
//
//    [super setFrame:frame];
//
//    [self relayout];
//}

- (void)relayout{
    [[self titleLabel] setFrame:CGRectMake(0, 0, [self titleWidth] , CGRectGetHeight([self frame]))];
    [[self detailLabel] setFrame:CGRectMake(0, 0, [self detailWidth], CGRectGetHeight([self frame]))];
    if ([self lineMode] == LTLineModeScaleToFillAll) {
        if ([self underline]) {
            [[self lineLeft] setConstant:0];
            [[self lineRight] setConstant:0];
        }
    } else if ([self lineMode] == LTLineModeScaleToFillContent){
        if ([self underline]) {
            [[self lineLeft] setConstant:-[self titleWidth]];
            [[self lineRight] setConstant:[self detailWidth]];
        }
    }
}

- (void)updateConstraints{
    [super updateConstraints];
    [self relayout];
}

- (void)setStyle:(LTFormTextFieldStyle)style{
    if (!(style & LTFormTextFieldStyleTitle)) {
        [self removeTitle];
    }
    if (!(style & LTFormTextFieldStyleDetail)) {
        [self removeDetail];
    }
    if (!(style & LTFormTextFieldStyleUnderline)) {
        [self removeUnderline];
    }
    if ((style & LTFormTextFieldStyleTitle) && !(_style & LTFormTextFieldStyleTitle) ) {
        [self setTitleLabel:[self createTitle]];
        [self setLeftView:[self titleLabel]];
        [self setLeftViewMode:UITextFieldViewModeAlways];
    }
    if ((style & LTFormTextFieldStyleDetail) && !(_style & LTFormTextFieldStyleDetail) ) {
        [self setDetailLabel:[self createDetail]];
        [self setRightView:[self detailLabel]];
        [self setRightViewMode:UITextFieldViewModeAlways];
    }
    if ((style & LTFormTextFieldStyleUnderline) && !(_style & LTFormTextFieldStyleUnderline) ) {
        [self setUnderline:[self createUnderline]];
        [self addSubview:[self underline]];
        [[self underline] addConstraint:[self lineHeight]];
        [self addConstraints:[self evUnderlineLayoutContraints]];
    }
    _style = style;
    [self relayout];
}

- (void)setTitleWidth:(CGFloat)titleWidth{
    _titleWidth = titleWidth;
    [self relayout];
}

- (void)setTitle:(NSString *)title{
    [[self titleLabel] setText:title];
}

- (NSString*)title{
    return [[self titleLabel] text];
}

- (void)setTitleFont:(UIFont *)titleFont{
    [[self titleLabel] setFont:titleFont];
}

- (UIFont*)titleFont{
    return [[self titleLabel] font];
}

- (void)setTitleColor:(UIColor *)titleColor{
    [[self titleLabel] setTextColor:titleColor];
}

- (UIColor*)titleColor{
    return [[self titleLabel] textColor];
}

- (void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    [[self titleLabel] setTextAlignment:titleAlignment];
}

- (NSTextAlignment)titleAlignmen{
    return [[self titleLabel] textAlignment];
}

- (void)setDetailWidth:(CGFloat)detailWidth{
    _detailWidth = detailWidth;
    [self relayout];
}

- (void)setDetail:(NSString *)evDetail{
    [[self detailLabel] setText:evDetail];
}

- (NSString*)evDetail{
    return [[self detailLabel] text];
}

- (void)setDetailFont:(UIFont *)evDetailFont{
    [[self detailLabel] setFont:evDetailFont];
}

- (UIFont*)evDetailFont{
    return [[self detailLabel] font];
}

- (void)setDetailColor:(UIColor *)evDetailColor{
    [[self detailLabel] setTextColor:evDetailColor];
}

- (UIColor*)evDetailColor{
    return [[self detailLabel] textColor];
}

- (void)setDetailAlignment:(NSTextAlignment)evDetailAlignment{
    [[self detailLabel] setTextAlignment:evDetailAlignment];
}

- (NSTextAlignment)evDetailAlignmen{
    return [[self detailLabel] textAlignment];
}

- (void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        if (![self lineImage]) {
            [[self underline] setBackgroundColor:lineColor];
        }
    }
}

- (void)setLineImage:(UIImage *)lineImage{
    if (_lineImage != lineImage) {
        _lineImage = lineImage;
        [[self underline] setImage:lineImage];
        if (!lineImage) {
            [[self underline] setBackgroundColor:[self lineColor]];
        }
    }
}

- (void)removeSubViews{
    [self removeTitle];
    [self removeDetail];
    [self removeUnderline];
}

- (void)removeTitle{
    [self setLeftView:nil];
    [self setTitleLabel:nil];
}

- (void)removeDetail{
    [self setRightView:nil];
    [self setDetailLabel:nil];
}

- (void)removeUnderline{
    [[self underline] removeConstraints:[self evUnderlineLayoutContraints]];
    [[self underline] removeFromSuperview];
    [self setUnderline:nil];
}

- (UILabel*)createTitle{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self titleWidth], CGRectGetHeight([self frame]))];
    [lbTitle setBackgroundColor:[UIColor clearColor]];
    [lbTitle setTextColor:[UIColor blackColor]];
    [lbTitle setFont:[UIFont systemFontOfSize:13]];
    return lbTitle;
}

- (UILabel*)createDetail{
    UILabel *lbDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self detailWidth], CGRectGetHeight([self frame]))];
    [lbDetail setBackgroundColor:[UIColor clearColor]];
    [lbDetail setTextColor:[UIColor blackColor]];
    [lbDetail setFont:[UIFont systemFontOfSize:13]];
    return lbDetail;
}

- (UIImageView*)createUnderline{
    UIImageView *underline = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([self frame]) - 1, [self detailWidth],1) ];
    [underline setBackgroundColor:[self lineColor]];
    [underline setTranslatesAutoresizingMaskIntoConstraints:NO];
    return underline;
}

- (NSLayoutConstraint*)lineLeft{
    if (!_lineLeft) {
        _lineLeft = [NSLayoutConstraint constraintWithItem:[self underline] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    }
    return _lineLeft;
}

- (NSLayoutConstraint *)lineRight{
    if (!_lineRight) {
        _lineRight = [NSLayoutConstraint constraintWithItem:[self underline] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    }
    return _lineRight;
}

- (NSLayoutConstraint *)lineHeight{
    if (!_lineHeight) {
        _lineHeight = [NSLayoutConstraint constraintWithItem:[self underline] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1];
    }
    return _lineHeight;
}

- (NSLayoutConstraint *)lineBottom{
    if (!_lineBottom) {
        _lineBottom = [NSLayoutConstraint constraintWithItem:[self underline] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1];
    }
    return _lineBottom;
}

- (NSArray*)evUnderlineLayoutContraints;{
    return @[[self lineLeft], [self lineRight], [self lineBottom]];
}

@end
