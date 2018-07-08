//
//  ENRegisterViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/26.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENRegisterViewController.h"
#import "CurrentUser.h"

@interface ENRegisterViewController ()<UITextFieldDelegate>
{
    
    dispatch_source_t _timer;
    NSString * _codeButtonTitle ;
    
}

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UITextField *accountField;

@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UITextField *confrimField;


@property (weak, nonatomic) IBOutlet UITextField *needField;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;


@property (weak, nonatomic) IBOutlet UILabel *codeLabel;


@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;

@property (weak, nonatomic) IBOutlet UILabel *comfrimLabel;

@property (weak, nonatomic) IBOutlet UILabel *demandLabel;


@property (weak, nonatomic) IBOutlet UILabel *registerLabel;


@end

@implementation ENRegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self readyView];
    
    
}

- (void)readyView{
    
    self.pwdField.secureTextEntry = YES;
    self.confrimField.secureTextEntry = YES;
    
    self.registerBtn.layer.cornerRadius = 2.0f;
    self.registerBtn.layer.masksToBounds = YES;
    
    self.sendCodeBtn.layer.cornerRadius = 2.0f;
    self.sendCodeBtn.layer.masksToBounds = YES;
    
    
    self.closeButton.layer.cornerRadius = 2.0f;
    self.closeButton.layer.borderColor = ThemeColor.CGColor;
    self.closeButton.layer.borderWidth = 0.5f;
    self.closeButton.layer.masksToBounds = YES;
    
    self.pwdField.delegate = self;
    self.confrimField.delegate = self;
    self.accountField.delegate = self;
    self.codeField.delegate = self;
    self.needField.delegate = self;
    
    self.registerLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Register", nil);
    if ([LanguageLocalizableHelper shareInstance].currentLanguage == Language_zh_Hans) {
        self.accountLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"AccountNamePhone", nil);
    }else{
        self.accountLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Email", nil);
    }
    self.pwdLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"Password", nil);
    self.codeLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"VertifyCode", nil);
    self.comfrimLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"ConfirmPassword", nil);
    self.demandLabel.text =  LocalizableHelperGetStringWithKeyFromTable(@"DemandTrips", nil);
    
    
    self.accountField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"InputPhoneNum", nil);
    self.pwdField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillinPWD", nil);
    self.codeField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);
    self.confrimField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseConfirmPassword", nil);
    self.needField.placeholder =  LocalizableHelperGetStringWithKeyFromTable(@"PleaseInput", nil);

    [self.registerBtn setTitle:LocalizableHelperGetStringWithKeyFromTable(@"Register", nil) forState:UIControlStateNormal];
    [self.closeButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"Back", nil) forState:UIControlStateNormal];
    [self.sendCodeBtn setTitle:LocalizableHelperGetStringWithKeyFromTable(@"SendVertifyCode", nil) forState:UIControlStateNormal];

    
    
    
    
}



- (IBAction)closeRegister:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)userRegisterAction:(UIButton *)sender {
    
    
}

- (IBAction)sendVetifyCode:(UIButton *)sender {
    
    UIButton *codeBtn = (UIButton*)sender;
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [codeBtn setEnabled:YES];
                [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            _codeButtonTitle = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [codeBtn setEnabled:NO];
                [codeBtn setTitle:[NSString stringWithFormat:@"%@s后重试",_codeButtonTitle] forState:UIControlStateDisabled];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    
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
