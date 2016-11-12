//
//  XLFTextInputLimitManager.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-12-4.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "XLFTextInputLimitManager.h"
#import "NSString+Categories.h"

NSString *const XLFKeyboardDidReturnNotifacation = @"KeyboardDidReturnNotifacation";

@interface XLFTextInputLimitManager ()

@end

@implementation XLFTextInputLimitManager

- (void)dealloc{
    
    [self setDelegate:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (IBAction)didTextChanged:(NSNotification*)sender{
    
    id<XLFTextInput> textInput = [sender object];
    
    if (textInput == [self textInput] && [textInput textLimitType] != XLFTextLimitTypeNone && ![[textInput markedTextRange] start]) {
        
        if ([textInput textLimitType] == XLFTextLimitTypeByte) {
            
            if ([[textInput text] stringLength] > [textInput textLimitSize]) {
                
                [textInput setText:[[textInput text] substringInLimitByteSize:[textInput textLimitSize]]];
            }
        }
        else if ([textInput textLimitType] == XLFTextLimitTypeLength){
            
            if ([[textInput text] length] > [textInput textLimitSize]) {
                
                [textInput setText:[[textInput text] substringToIndex:[textInput textLimitSize]-1]];
            }
        }
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(id<XLFTextInput>)textView;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        
        return [[self delegate] textViewShouldBeginEditing:(id)textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(id<XLFTextInput>)textView;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        
        return [[self delegate] textViewShouldEndEditing:(id)textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(id<XLFTextInput>)textView;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        
        [[self delegate] textViewDidBeginEditing:(id)textView];
    }
}

- (void)textViewDidEndEditing:(id<XLFTextInput>)textView;{
    
    [textView setCorrect:[[self class] contentAllowTextInput:textView text:[textView text]]];
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textViewDidEndEditing:)]) {
        
        [[self delegate] textViewDidEndEditing:(id)textView];
    }
}

- (BOOL)textView:(UITextView<XLFTextInput> *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;{
    BOOL result = YES;
    UITextRange *markedTextRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textView positionFromPosition:[markedTextRange start] offset:0];
    NSString *content = [textView text];
    if (position) {
        NSString *markedText = [textView textInRange:markedTextRange];
        NSRange markedRange = [content rangeOfString:markedText];
        markedText = [markedText stringByReplacingOccurrencesOfString:@" " withString:@""];
        content = [content stringByReplacingCharactersInRange:markedRange withString:markedText];
        NSInteger contentOffset = markedRange.length - markedText.length;
        if (range.location > content.length) {
            range.location -= contentOffset;
        } else {
            range.length -= contentOffset;
        }
    }
    if ([text length]) {
        if ([textView textLimitType] == XLFTextLimitTypeByte) {
            
            result = [[self class] textInput:textView content:content shouldChangeTextInRange:range limitTextByteWithReplacementText:text marked:position != nil];
        }
        else if ([textView textLimitType] == XLFTextLimitTypeLength) {
            
            result = [[self class] textInput:textView content:content shouldChangeTextInRange:range limitTextLengthWithReplacementText:text marked:position != nil];
        }
    }
    if (result) {
        if ([text length]) {
            
            result = [[self class] textInput:textView content:content shouldAllowInputInRange:range inputText:text];
        }
        NSString *destination = [[textView text] stringByReplacingCharactersInRange:range withString:text];
        [textView setCorrect:[[self class] contentAllowTextInput:textView text:destination]];
    }
    if (result && [self delegate] && [[self delegate] respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        result = [[self delegate] textView:(id)textView shouldChangeTextInRange:range replacementText:text];
    }
    if (result && [text isEqualToString:@"\n"] && [textView returnKeyType] != UIReturnKeyDefault) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XLFKeyboardDidReturnNotifacation object:[NSNumber numberWithInteger:[textView returnKeyType]]];
    }
    return result;
}

- (void)textViewDidChange:(UITextView *)textView;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textViewDidChange:)]) {
        
        [[self delegate] textViewDidChange:(id)textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        
        [[self delegate] textViewDidBeginEditing:(id)textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        
        return [[self delegate] textView:(id)textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textView: shouldInteractWithTextAttachment:inRange:)]) {
        
        return [[self delegate] textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(id<XLFTextInput>)textField;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        
        return [[self delegate] textFieldShouldBeginEditing:(id)textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(id<XLFTextInput>)textField;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        
        [[self delegate] textFieldDidBeginEditing:(id)textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(id<XLFTextInput>)textField;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        
        return [[self delegate] textFieldShouldEndEditing:(id)textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(id<XLFTextInput>)textField;{
    
    [textField setCorrect:[[self class] contentAllowTextInput:textField text:[textField text]]];
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        
        [[self delegate] textFieldDidEndEditing:(id)textField];
    }
}

- (BOOL)textField:(id<XLFTextInput>)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{
    BOOL result = YES;
    UITextRange *markedTextRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:[markedTextRange start] offset:0];
    NSString *content = [textField text];
    if (position) {
        NSString *markedText = [textField textInRange:markedTextRange];
        NSRange markedRange = [content rangeOfString:markedText];
        markedText = [markedText stringByReplacingOccurrencesOfString:@" " withString:@""];
        content = [content stringByReplacingCharactersInRange:markedRange withString:markedText];
        NSInteger contentOffset = markedRange.length - markedText.length;
        if (range.location > content.length) {
            range.location -= contentOffset;
        } else {
            range.length -= contentOffset;
        }
    }
    if ([string length]) {
        if ([textField textLimitType] == XLFTextLimitTypeByte) {
            
            result = [[self class] textInput:textField content:content shouldChangeTextInRange:range limitTextByteWithReplacementText:string marked:position != nil];
        }
        else if ([textField textLimitType] == XLFTextLimitTypeLength) {
            
            result = [[self class] textInput:textField content:content shouldChangeTextInRange:range limitTextLengthWithReplacementText:string marked:position != nil];
        }
    }
    if (result) {
        if ([string length]) {
            result = [[self class] textInput:textField content:content shouldAllowInputInRange:range inputText:string];
        }
        NSString * destination = [content stringByReplacingCharactersInRange:range withString:string];
        [textField setCorrect:[[self class] contentAllowTextInput:textField text:destination]];
    }
    if (result && [self delegate] && [[self delegate] respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [[self delegate] textField:(id)textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return result;
}

- (BOOL)textFieldShouldClear:(id<XLFTextInput>)textField;{
    
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [[self delegate] textFieldShouldClear:(id)textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(id<XLFTextInput>)textField;{
    
    BOOL result = YES;
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(textFieldShouldReturn:)]) {
        result = [[self delegate] textFieldShouldReturn:(id)textField];
    }
    
    if (result) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XLFKeyboardDidReturnNotifacation object:[NSNumber numberWithInteger:[textField returnKeyType]]];
    }
    
    return result;
}

+ (BOOL)textInput:(id<XLFTextInput>)textInput content:(NSString *)content shouldChangeTextInRange:(NSRange)range limitTextByteWithReplacementText:(NSString *)text marked:(BOOL)marked;{
    if (![textInput isKindOfClass:[UITextField class]] && ![textInput isKindOfClass:[UITextView class]]) {
        return NO;
    }
    NSString *string = [content stringByReplacingCharactersInRange:range withString:text];
    if (!marked) {
        NSString *rangeText = [content substringWithRange:range];
        if ([rangeText stringLength] > [text stringLength]) {
            if ([string stringLength] > [textInput textLimitSize]){
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        } else {
            if ([content stringLength] <= [textInput textLimitSize]) {
                return [string stringLength] <= [textInput textLimitSize];
            } else {
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        }
    } else {
        UITextRange *markedRange = [textInput markedTextRange];
        NSString *rangeText = [textInput textInRange:markedRange];
        if ([rangeText stringLength] > [text length]) {
            if ([string stringLength] <= [textInput textLimitSize]) {
                return YES;
            } else {
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        } else {
            if ([content stringLength] <= [textInput textLimitSize]) {
                return [string stringLength] <= [textInput textLimitSize];
            } else {
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        }
    }
    return YES;
}

+ (BOOL)textInput:(id<XLFTextInput>)textInput content:(NSString *)content shouldChangeTextInRange:(NSRange)range limitTextLengthWithReplacementText:(NSString *)text marked:(BOOL)marked{
    if (![textInput isKindOfClass:[UITextField class]] && ![textInput isKindOfClass:[UITextView class]]) {
        return NO;
    }
    NSString *string = [content stringByReplacingCharactersInRange:range withString:text];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!marked) {
        NSString *rangeText = [content substringWithRange:range];
        if ([rangeText length] > [text length]) {
            if ([string length] <= [textInput textLimitSize]) {
                return YES;
            } else {
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        } else {
            if ([content length] <= [textInput textLimitSize]) {
                return [string length] <= [textInput textLimitSize];
            } else {
                
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        }
    } else {
        UITextRange *markedRange = [textInput markedTextRange];
        NSString *rangeText = [textInput textInRange:markedRange];
        if ([rangeText length] > [text length]) {
            if ([string length] <= [textInput textLimitSize]) {
                return YES;
            } else {
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        } else {
            if ([content length] <= [textInput textLimitSize]) {
                return [string length] <= [textInput textLimitSize];
            } else {
                
                //                [textInput setText:[content stringByReplacingCharactersInRange:range withString:@""]];
                return NO;
            }
        }
    }
}

+ (BOOL)textInput:(id<XLFTextInput>)textInput content:(NSString *)content shouldAllowInputInRange:(NSRange)range inputText:(NSString *)inputText{
    NSString *text = [content stringByReplacingCharactersInRange:range withString:inputText];
    switch ([textInput textLimitInputType]) {
            
            case XLFTextLimitInputTypeNone:
            return YES;
            break;
            
            case XLFTextLimitInputTypeEnglish:       // 纯英文
            return [text isEnglishCharacter];
            break;
            
            case XLFTextLimitInputTypeChinese:       // 纯中文
            return [text isChineseCharacter];
            break;
            
            case XLFTextLimitInputTypeNumber:        // 纯数字
            return [text isNumber];
            break;
            
            case XLFTextLimitInputTypeFloatNumber:      // 小数
            return [text isNumberOrDecimals];
            break;
            
            case XLFTextLimitInputTypeTelephoneNumber:  // 手机号码
            return [text isTelephoneNumber];
            break;
            
            case XLFTextLimitInputTypeEmail:            // 邮箱
            return [text isEmail];
            break;
            
            case XLFTextLimitInputTypeEnglishOrChinese: // 中英混合
            case XLFTextLimitInputTypeEnglishAndChinese:// 中英混合
            return [text isChineseOrEnglishCharacter];
            break;
            
            case XLFTextLimitInputTypeEnglishOrNumber:  // 英文或数字混合
            case XLFTextLimitInputTypeEnglishAndNumber: // 英文和数字混合
            return [text isNumberOrEnglishCharacter];
            break;
    }
    return YES;
}

+ (BOOL)contentAllowTextInput:(id<XLFTextInput>)textInput{
    return [self contentAllowTextInput:textInput text:[textInput text]];
}

+ (BOOL)contentAllowTextInput:(id<XLFTextInput>)textInput text:(NSString *)text{
    BOOL correct = YES;
    switch ([textInput textLimitInputType]) {
            
            case XLFTextLimitInputTypeNone:
            correct = YES;
            break;
            
            case XLFTextLimitInputTypeEnglish:       // 纯英文
            correct = [text isEnglishCharacter];
            break;
            
            case XLFTextLimitInputTypeChinese:       // 纯中文
            correct = [text isChineseCharacter];
            break;
            
            case XLFTextLimitInputTypeNumber:        // 纯数字
            correct = [text isNumber];
            break;
            
            case XLFTextLimitInputTypeFloatNumber:      // 小数
            correct = [text isNumberOrDecimals];
            break;
            
            case XLFTextLimitInputTypeTelephoneNumber:  // 手机号码
            correct = [text isTelephoneNumber];
            break;
            
            case XLFTextLimitInputTypeEmail:            // 邮箱
            correct = [text isFullEmail];
            break;
            
            case XLFTextLimitInputTypeEnglishOrChinese:// 中英混合
            correct = [text isChineseOrEnglishCharacter];
            break;
            
            case XLFTextLimitInputTypeEnglishOrNumber: // 英文和数字混合
            correct = [text isNumberOrEnglishCharacter];
            break;
            
            case XLFTextLimitInputTypeEnglishAndChinese:// 中英混合
            correct = [text isChineseOrEnglishCharacter];
            break;
            
            case XLFTextLimitInputTypeEnglishAndNumber: // 英文和数字混合
            correct = [text isNumberAndEnglishCharacter];
            break;
    }
    return correct && [text length] >= [textInput minusSize];
}
@end