//
//  ENFindPwdViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/26.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENFindPwdViewController.h"

@interface ENFindPwdViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountField;

@property (weak, nonatomic) IBOutlet UITextField *vetifyField;

@property (weak, nonatomic) IBOutlet UITextField *resetPwdField;

@property (weak, nonatomic) IBOutlet UITextField *confirmField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;


@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UILabel *findpwdLabel;


@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@property (weak, nonatomic) IBOutlet UILabel *resetLabel;

@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;





@end

@implementation ENFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self readyView];
    
}

- (void)readyView{
    
    self.resetPwdField.secureTextEntry = YES;
    self.confirmField.secureTextEntry = YES;
    
    self.submitButton.layer.cornerRadius = 2.0f;
    self.submitButton.layer.masksToBounds = YES;
    
    self.sendCodeButton.layer.cornerRadius = 2.0f;
    self.sendCodeButton.layer.masksToBounds = YES;
    
    
    self.closeButton.layer.cornerRadius = 2.0f;
    self.closeButton.layer.borderColor = ThemeColor.CGColor;
    self.closeButton.layer.borderWidth = 0.5f;
    self.closeButton.layer.masksToBounds = YES;
    
    self.accountField.delegate = self;
    self.vetifyField.delegate = self;
    self.resetPwdField.delegate = self;
    self.confirmField.delegate = self;
    
    self.findpwdLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"FindBackPassword", nil);
    if ([LanguageLocalizableHelper shareInstance].currentLanguage == Language_zh_Hans) {
        self.accountLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"AccountNamePhone", nil);
    }else{
        self.accountLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Email", nil);
    }
    self.codeLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"VertifyCode", nil);
    self.resetLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"ResetPassword", nil);
    self.confirmLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"ConfirmPassword", nil);
    
    
    self.accountField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"InputPhoneNum", nil);
    self.vetifyField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);
    self.resetPwdField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillinPWD", nil);
    self.confirmField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseConfirmPassword", nil);
    
    [self.submitButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"Confirm", nil) forState:UIControlStateNormal];
    [self.closeButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"Back", nil) forState:UIControlStateNormal];
    [self.sendCodeButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"SendVertifyCode", nil) forState:UIControlStateNormal];
    
}




- (IBAction)closeFindPwd:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitResetPassword:(UIButton *)sender {
    
    
}


- (IBAction)sendVertifyCode:(UIButton *)sender {
    
    
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
