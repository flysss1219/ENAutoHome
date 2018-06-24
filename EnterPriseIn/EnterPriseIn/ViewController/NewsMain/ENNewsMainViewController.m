//
//  ENNewsMainViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENNewsMainViewController.h"
#import "ENNewsBaseTableView.h"


@interface ENNewsMainViewController ()

@property (nonatomic, strong) ENNewsBaseTableView *baseTableView;


@end

@implementation ENNewsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"TabBarHomeNews", nil);
    
    [self.view addSubview:self.baseTableView];
    
    [self.baseTableView reloadTableVieWithDataSourceArray:@[@"1",@"2",@"3",@"4",@"5"] withKeyWord:nil];
}


- (ENNewsBaseTableView*)baseTableView{
    if (!_baseTableView) {
        _baseTableView = [[ENNewsBaseTableView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, KDeviceHeight-64-49) style:UITableViewStylePlain];
    }
    return _baseTableView;
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
