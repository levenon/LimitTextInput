//
//  LTLimitTextView.m
//  LimitTextInput
//
//  Created by teamone on 14-1-22.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "LTLimitTextView.h"

@interface LTLimitTextView ()

@property (nonatomic , strong) LTTextInputLimitManager *limitManager;

@end
@implementation LTLimitTextView

- (void)awakeFromNib{
    [super awakeFromNib];

    [self config];
}

- (instancetype)init{
    self = [super init];

    if (self) {

        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self config];
    }
    return self;
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate{
    
    [[self limitManager] setDelegate:delegate];
}

- (id<UITextViewDelegate>)delegate{
    
    return [[self limitManager] delegate];
}

- (LTTextInputLimitManager *)limitManager{
    
    if (!_limitManager) {
        
        _limitManager = [[LTTextInputLimitManager alloc] init];
        [_limitManager setTextInput:self];
        [_limitManager setDelegate:[super delegate]];
    }
    return _limitManager;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self setCorrect:[LTTextInputLimitManager contentAllowTextInput:self text:text]];
}

- (void)setTextLimitType:(LTTextLimitType)textLimitType{
    _textLimitType = textLimitType;

    [self config];
}

- (void)config;{
    
    [self setTextLimitSize:NSIntegerMax];

    [super setDelegate:[self limitManager]];
}

- (void)unmarkText;{
    if ([self textLimitType] != LTTextLimitTypeNone) {
        UITextRange *markedTextRange = [self markedTextRange];
        NSString *originMarkedText = [self textInRange:markedTextRange];
        NSInteger markedStartOffset = [self offsetFromPosition:[self beginningOfDocument] toPosition:[markedTextRange start]];
        // default is marked text
        NSRange replaceRange = NSMakeRange(markedStartOffset, [originMarkedText length]);
        if ([[self limitManager] respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            if ([[self limitManager] textView:self shouldChangeTextInRange:replaceRange replacementText:originMarkedText]) {
                [super unmarkText];
            }
        }
    }
    else{
        [super unmarkText];
    }
}

- (void)setMarkedText:(NSString *)markedText selectedRange:(NSRange)selectedRange;{
    if ([self textLimitType] != LTTextLimitTypeNone) {
        UITextRange *markedTextRange = [self markedTextRange];
        NSString *originMarkedText = [self textInRange:markedTextRange];
        NSInteger markedStartOffset = [self offsetFromPosition:[self beginningOfDocument] toPosition:[markedTextRange start]];
        NSInteger markedEndOffset = [self offsetFromPosition:[self beginningOfDocument] toPosition:[markedTextRange end]];
        // default is marked text
        NSString *replacement = markedText;
        NSRange replaceRange = NSMakeRange(markedStartOffset, [originMarkedText length]);
        // append marked text
        if (selectedRange.location > originMarkedText.length) {
            
            replacement = [[markedText stringByReplacingOccurrencesOfString:originMarkedText withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
            replaceRange = NSMakeRange(markedEndOffset, 0);
        }
        if ([[self limitManager] respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            if ([[self limitManager] textView:self shouldChangeTextInRange:replaceRange replacementText:replacement]) {
                [super setMarkedText:markedText selectedRange:selectedRange];
            }
        }
    }
    else{
        [super setMarkedText:markedText selectedRange:selectedRange];
    }
}

@end
