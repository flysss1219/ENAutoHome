//
//  BranchListViewController.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/25.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BranchListViewController.h"
#import "BusinessTableView.h"
#import "EnterpriseInfoViewController.h"

@interface BranchListViewController ()<BusinessTableViewDelegate>

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
    self.title = @"分类";
    [self setLeftButton];
    self.view.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    [self.view addSubview:self.businessTableView];
}
- (void)requestData{
 
    [self.businessTableView setBusinessInfo:nil haveSectionHeader:NO];
    
}

#pragma mark - BusinessTableViewDelegate
- (void)businessTableView:(BusinessTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EnterpriseInfoViewController *vc = [[EnterpriseInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BusinessTableView*)businessTableView{
    if (!_businessTableView) {
        _businessTableView = [[BusinessTableView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth,KDeviceHeight-64-49) style:UITableViewStylePlain];
        _businessTableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        _businessTableView.businessDelegate = self;
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
