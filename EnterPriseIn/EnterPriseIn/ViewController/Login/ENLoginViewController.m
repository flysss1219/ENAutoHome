//
//  ENLoginViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/26.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENLoginViewController.h"
#import "ENRegisterViewController.h"

@interface ENLoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;


@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *regitsterButton;


@end

@implementation ENLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}




- (IBAction)closeLogin:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)login:(UIButton *)sender {
    
    
}


- (IBAction)userRegister:(UIButton *)sender {
    
    ENRegisterViewController *vc = [[ENRegisterViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
    
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
