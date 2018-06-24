//
//  ENEnterpriseViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENEnterpriseViewController.h"
#import "ApplyEnterpriseEnterView.h"

@interface ENEnterpriseViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) ApplyEnterpriseEnterView *applyView;

@end

@implementation ENEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"TabBarHomeEnter", nil);
    
    [self readyView];
}

- (void)readyView{
    
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth, KDeviceHeight-64);
    [self.mainScrollView addSubview:self.applyView];
    
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth, KDeviceHeight-49-64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.scrollEnabled = YES;
    }
    return _mainScrollView;
}

- (ApplyEnterpriseEnterView*)applyView{
    if(!_applyView){
        _applyView = [[[NSBundle mainBundle]loadNibNamed:@"ApplyEnterpriseEnterView" owner:self options:nil]lastObject];
    }
    return _applyView;
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
