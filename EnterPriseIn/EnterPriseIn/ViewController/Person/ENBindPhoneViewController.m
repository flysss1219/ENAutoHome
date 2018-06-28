//
//  ENBindPhoneViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENBindPhoneViewController.h"

@interface ENBindPhoneViewController ()

@property (weak, nonatomic) IBOutlet UIButton *bindButton;

@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;


@end

@implementation ENBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"BindAccount", nil);
    [self setLeftButton];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)bindUserPhone:(UIButton *)sender {
    
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
