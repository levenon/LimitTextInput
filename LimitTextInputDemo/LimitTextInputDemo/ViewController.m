//
//  ViewController.m
//  LimitTextInputDemo
//
//  Created by dihong on 16/8/26.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "ViewController.h"
#import "XLFLimitTextField.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet XLFLimitTextField *characterTextField;
@property (weak, nonatomic) IBOutlet XLFLimitTextField *numberTextField;
@property (weak, nonatomic) IBOutlet XLFLimitTextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet XLFLimitTextField *emailTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characterTextField.textLimitType = XLFTextLimitTypeLength;
    self.characterTextField.textLimitInputType = XLFTextLimitInputTypeEnglish;
    self.characterTextField.textLimitSize = 10;
    
    self.numberTextField.textLimitType = XLFTextLimitTypeLength;
    self.numberTextField.textLimitInputType = XLFTextLimitInputTypeNumber;
    
    self.telephoneTextField.textLimitType = XLFTextLimitTypeLength;
    self.telephoneTextField.textLimitInputType = XLFTextLimitInputTypeTelephoneNumber;
    
    self.emailTextField.textLimitType = XLFTextLimitTypeLength;
    self.emailTextField.textLimitInputType = XLFTextLimitInputTypeEmail;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
