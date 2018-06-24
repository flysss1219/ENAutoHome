//
//  ENPersonViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENPersonViewController.h"
#import "PersonHeadView.h"
#import "ENShareAppView.h"
#import "UserAccountInfoView.h"

@interface ENPersonViewController ()<UIScrollViewDelegate,UserAccountInfoViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) PersonHeadView *personHeadView;

@property (nonatomic, strong) UserAccountInfoView *infoView;

@property (nonatomic, strong) ENShareAppView *shareView;

@end

@implementation ENPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self readyView];
    
}
- (void)readyView{
    
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth, KDeviceHeight-64);
    [self.mainScrollView addSubview:self.personHeadView];
    [self.mainScrollView addSubview:self.infoView];
    [self.mainScrollView addSubview:self.shareView];
    
    WS(ws);
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
    [self.personHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mainScrollView.mas_top);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(130);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.personHeadView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(120);
    }];
}

#pragma mark - UserAccountInfoViewDelegate
- (void)userInfoViewEditUserAccount{
    
}

- (void)userInfoViewEditUserAddress{
    
    
}

#pragma mark - getter
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
- (PersonHeadView*)personHeadView{
    if(!_personHeadView){
        _personHeadView = [[[NSBundle mainBundle]loadNibNamed:@"PersonHeadView" owner:self options:nil]lastObject];
    }
    return _personHeadView;
}
- (UserAccountInfoView*)infoView{
    if(!_infoView){
        _infoView = [[[NSBundle mainBundle]loadNibNamed:@"UserAccountInfoView" owner:self options:nil]lastObject];
        _infoView.delegate = self;
    }
    return _infoView;
}

- (ENShareAppView*)shareView{
    if (!_shareView) {
        _shareView = [[ENShareAppView alloc]init];
//        _shareView.delegate = self;
    }
    return _shareView;
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
