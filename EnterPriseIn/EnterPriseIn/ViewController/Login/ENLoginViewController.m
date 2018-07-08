//
//  ENLoginViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/26.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENLoginViewController.h"
#import "ENRegisterViewController.h"
#import "ENFindPwdViewController.h"

@interface ENLoginViewController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *regitsterButton;


@property (weak, nonatomic) IBOutlet UIButton *forgetButton;


@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;


@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;



@end

@implementation ENLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = YES;
    
    [self readyView];
    
    
}

- (void)readyView{
    
    self.regitsterButton.layer.cornerRadius = 2.0f;
    self.regitsterButton.layer.borderColor = ThemeColor.CGColor;
    self.regitsterButton.layer.borderWidth = 0.5f;
    self.regitsterButton.layer.masksToBounds = YES;
    self.pwdField.secureTextEntry = YES;
    self.loginButton.layer.cornerRadius = 2.0f;
    self.loginButton.layer.masksToBounds = YES;
    
    self.phoneField.delegate = self;
    self.pwdField.delegate = self;
    
    
    self.loginLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Login", nil);
    if ([LanguageLocalizableHelper shareInstance].currentLanguage == Language_zh_Hans) {
        self.accountLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"AccountNamePhone", nil);
    }else{
        self.accountLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Email", nil);
    }
    self.pwdLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Password", nil);
    self.phoneField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);
    self.pwdField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);
    [self.regitsterButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"Register", nil) forState:UIControlStateNormal];
    [self.loginButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"Login", nil) forState:UIControlStateNormal];
    [self.forgetButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"ForgetPwd", nil) forState:UIControlStateNormal];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSInteger res = 0;
//    if (textField == _phoneField) {
//        res = 11 - [new length];
//    }else if(textField == _pwdField){
//        res = 6 - [new length];
//    }
//
//    if(res >= 0){
//        return YES;
//    }else{
//        NSRange rg = {0,[string length]+res};
//        if (rg.length>0) {
//            NSString *s = [string substringWithRange:rg];
//            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
//        }
//
//        return NO;
//    }
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//
//    NSMutableString *toBeString = [NSMutableString stringWithFormat:@"%@",textField.text];
//
//    if (textField == self.quickLoginView.phoneNumberTextField) {
//
//        if ([textField.text length] > 11) {
//            textField.text = [toBeString substringToIndex:11];
//            [self makeToast:@"手机号的最大位数为11位" duration:1];
////            [GlobalAnimation errorAnimationWithView:textField];
//            return NO;
//        }
//
//        NSString *validRegEx =@"^[0-9]*$";
//        NSPredicate *regExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEx];
//        BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:textField.text];
//        if (!myStringMatchesRegEx){
//            [self makeToast:@"只能输入数字" duration:1];
//            [GlobalAnimation errorAnimationWithView:textField];
//            textField.text = @"";
//            return NO;
//        }
//
//    }else if (textField == self.quickLoginView.codeTextField) {
//
//        if ([textField.text length] > 6) {
//            textField.text = [toBeString substringToIndex:6];
//            [self makeToast:@"验证码的最大位数为6位" duration:1];
//            [GlobalAnimation errorAnimationWithView:textField];
//            return NO;
//        }
//    }
//
//    return YES;
//}




- (IBAction)closeLogin:(UIButton *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)login:(UIButton *)sender {
    
    
}



- (IBAction)userRegister:(UIButton *)sender {
    
    ENRegisterViewController *vc = [[ENRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)forgetPwdClick:(UIButton *)sender {
    
    ENFindPwdViewController *vc = [[ENFindPwdViewController alloc]init];
   [self.navigationController pushViewController:vc animated:YES];
    
    
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
