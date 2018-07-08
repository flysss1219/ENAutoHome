//
//  ENEditPhoneViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENEditPhoneViewController.h"

@interface ENEditPhoneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation ENEditPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LocalizableHelperGetStringWithKeyFromTable(@"ResetAccount", nil);
    [self setLeftButton];
    self.view.backgroundColor = ThemebgViewColor;
}




- (IBAction)sendVertifyCode:(UIButton *)sender {
}

- (IBAction)resetUserPhoneNumber:(id)sender {
    
    
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
