//
//  ENSetNickViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENSetNickViewController.h"

@interface ENSetNickViewController ()

@end

@implementation ENSetNickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"SetNickName", nil);
    [self setLeftButton];
    // Do any additional setup after loading the view from its nib.
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
