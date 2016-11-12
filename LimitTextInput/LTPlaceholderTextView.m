//
//  LTPlaceholderTextView.m
//  LimitTextInput
//
//  Created by apple on 13-11-7.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "LTPlaceholderTextView.h"

@interface LTPlaceholderTextView ()

@end

@implementation LTPlaceholderTextView

- (void)dealloc{
    
    [self unregisterNotification];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self registerNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self registerNotification];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder{
    
    if (_placeholder != placeholder) {
        
        _placeholder = [placeholder copy];
        
        [self setNeedsDisplay];
    }
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor{
    
    if (_placeholderTextColor != placeholderTextColor) {
        
        _placeholderTextColor = placeholderTextColor;
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect{
    
    if (![[self text] length ]) {
        
        UIColor *color = [self placeholderTextColor] ? [self placeholderTextColor] : [UIColor colorWithRed:182/255. green:182/255. blue:183/255. alpha:1.0];
        
        UIFont *font = [self font] ? [[self font] fontWithSize:[[self font] pointSize] - 1] : [UIFont systemFontOfSize:[UIFont labelFontSize]];
        
        if ([[self placeholder] respondsToSelector:@selector(drawInRect:withAttributes:)]) {
            
            NSDictionary *attributes = @{ NSFontAttributeName:font, NSForegroundColorAttributeName:color};
            
            [[self placeholder] drawInRect:CGRectInset(rect, 6, 8) withAttributes:attributes];
        }
        else{
            
            [color set];
            [self.placeholder drawInRect:CGRectInset(rect, 15, 10) withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        }
    }
}

- (void)registerNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTextViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)unregisterNotification;{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - actions

- (IBAction)didTextViewTextDidChangeNotification:(NSNotification *)notification{
    
    if ([notification object] == self) {
        
        [self setNeedsDisplay];
    }
}


@end
