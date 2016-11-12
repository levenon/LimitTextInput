//
//  ViewController.m
//  LimitTextInputDemo
//
//  Created by dihong on 16/8/26.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "ViewController.h"
#import "LTLimitTextField.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LTLimitTextField *characterTextField;
@property (weak, nonatomic) IBOutlet LTLimitTextField *numberTextField;
@property (weak, nonatomic) IBOutlet LTLimitTextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet LTLimitTextField *emailTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.characterTextField.textLimitType = LTTextLimitTypeLength;
    self.characterTextField.textLimitInputType = LTTextLimitInputTypeEnglish;
    self.characterTextField.textLimitSize = 10;
    
    self.numberTextField.textLimitType = LTTextLimitTypeLength;
    self.numberTextField.textLimitInputType = LTTextLimitInputTypeNumber;
    
    self.telephoneTextField.textLimitType = LTTextLimitTypeLength;
    self.telephoneTextField.textLimitInputType = LTTextLimitInputTypeTelephoneNumber;
    
    self.emailTextField.textLimitType = LTTextLimitTypeLength;
    self.emailTextField.textLimitInputType = LTTextLimitInputTypeEmail;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
