//
//  ENRegisterViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/26.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENRegisterViewController.h"

@interface ENRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *insideButton;

@property (weak, nonatomic) IBOutlet UIButton *outsideButton;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UITextField *accountField;

@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UITextField *confrimField;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;

@end

@implementation ENRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self readyView];
    
}

- (void)readyView{
    
    self.insideButton.layer.cornerRadius = 2.0f;
    self.insideButton.layer.masksToBounds = YES;
    
    self.outsideButton.layer.cornerRadius = 2.0f;
    self.outsideButton.layer.borderColor = ThemeColor.CGColor;
    self.outsideButton.layer.borderWidth = 0.5f;
    self.outsideButton.layer.masksToBounds = YES;
    
    self.pwdField.secureTextEntry = YES;
    self.confrimField.secureTextEntry = YES;
    
    self.registerBtn.layer.cornerRadius = 2.0f;
    self.registerBtn.layer.masksToBounds = YES;
    
    self.sendCodeBtn.layer.cornerRadius = 2.0f;
    self.sendCodeBtn.layer.masksToBounds = YES;
}



- (IBAction)closeRegister:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)countryInsideClick:(UIButton *)sender {
    
    
}

- (IBAction)countryOutsideClick:(UIButton *)sender {
}

- (IBAction)userRegisterAction:(UIButton *)sender {
    
    
}

- (IBAction)sendVetifyCode:(UIButton *)sender {
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
