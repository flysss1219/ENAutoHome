//
//  ENEditInfomationViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/26.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENEditInfomationViewController.h"

@interface ENEditInfomationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property (weak, nonatomic) IBOutlet UITextField *userField;

@property (weak, nonatomic) IBOutlet UITextField *demandField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;

@end

@implementation ENEditInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}





- (IBAction)closeEditInfo:(UIButton *)sender {
}


- (IBAction)submitEnterpriseInfomation:(UIButton *)sender {
    
}

- (IBAction)selectAddressArea:(UIButton *)sender {
    
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
