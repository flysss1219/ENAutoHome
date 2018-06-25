//
//  BranchListViewController.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/25.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BranchListViewController.h"
#import "BusinessTableView.h"

@interface BranchListViewController ()

@property (nonatomic, strong) BusinessTableView *businessTableView;

@property (nonatomic, copy)  NSString *branchName;

@property (nonatomic, copy)  NSString *branchId;

@end

@implementation BranchListViewController

- (instancetype)initWithBranchName:(NSString*)name branchId:(NSString*)branchId{
    
    if (self = [super init]) {
        _branchId = branchId;
        _branchName = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyView];
    [self requestData];
}

- (void)readyView{
    self.view.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    [self.view addSubview:self.businessTableView];
}
- (void)requestData{
 
    [self.businessTableView setBusinessInfo:nil haveSectionHeader:NO];
    
}

- (BusinessTableView*)businessTableView{
    if (!_businessTableView) {
        _businessTableView = [[BusinessTableView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth,KDeviceHeight-64-59) style:UITableViewStylePlain];
    }
    return _businessTableView;
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
