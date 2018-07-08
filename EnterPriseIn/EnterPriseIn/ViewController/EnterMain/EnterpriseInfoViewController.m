//
//  EnterpriseInfoViewController.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "EnterpriseInfoViewController.h"
#import "ENPictureCollectionView.h"
#import "ENEnterpriseInfoView.h"
#import "EnterpriseAddressView.h"
#import "NoRegisterLookView.h"
#import "ENFooterView.h"
#import "EnterpriseIntroduceView.h"

@interface EnterpriseInfoViewController ()<ENPictureCollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* mainScrollView;

@property (nonatomic, strong) UIImageView* headImageView;

@property (nonatomic, strong) ENPictureCollectionView *pictureCollectionView;

@property (nonatomic, strong) ENEnterpriseInfoView *infoView;

@property (nonatomic, strong) EnterpriseAddressView *addressView;

@property (nonatomic, strong) NoRegisterLookView *unlookView;

@property (nonatomic, strong) EnterpriseIntroduceView *introduceView;

@property (nonatomic, strong) ENFooterView *footerView;


@end

@implementation EnterpriseInfoViewController
{
    CGFloat _contentY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyView];
    
    [self requestEnterpriseInfomation];
}

- (void)readyView{
    [self setLeftButton];
    self.title = @"企业详情";
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headImageView];
    [self.mainScrollView addSubview:self.pictureCollectionView];
    [self.mainScrollView addSubview:self.infoView];
    [self.mainScrollView addSubview:self.addressView];
    [self.mainScrollView addSubview:self.unlookView];
    [self.mainScrollView addSubview:self.introduceView];
    [self.view addSubview:self.footerView];
    self.unlookView.hidden = YES;
    
    WS(ws);
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mainScrollView.mas_top);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(170);
    }];
    [self.pictureCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.headImageView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(100);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.pictureCollectionView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(60);
    }];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.infoView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(60);
    }];
    [self.unlookView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.infoView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(60);
    }];
    [self.introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.addressView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(50);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom);
        make.left.equalTo(ws.view.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(49);
    }];
}


- (void)requestEnterpriseInfomation{
    
    WS(ws);
    _contentY = 460;
    [self.headImageView setImageWithURL:[NSURL URLWithString:@"http://img.berui.com/hefei/news/simg/2018/04/12/1523502931_923026.jpg"] options:YYWebImageOptionProgressive];
    
    CGFloat height = [self.introduceView setEnterpriseIntroduce:nil];
    [self.introduceView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth, _contentY+height);
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

- (UIImageView*)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth,150)];
        _headImageView.image = [UIImage imageNamed:@"zxpic"];
    }
    return _headImageView;
}
- (ENPictureCollectionView*)pictureCollectionView{
    
    if (!_pictureCollectionView) {
        _pictureCollectionView = [[ENPictureCollectionView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 100) collectionViewLayout:[UICollectionViewLayout new]];
        _pictureCollectionView.pictureDelegate = self;
    }
    return _pictureCollectionView;
}

- (ENEnterpriseInfoView*)infoView{
    if (!_infoView) {
        _infoView = [[[NSBundle mainBundle] loadNibNamed:@"ENEnterpriseInfoView" owner:self options:nil] lastObject];
    }
    return _infoView;
}

- (EnterpriseAddressView*)addressView{
    if (!_addressView) {
        _addressView = [[[NSBundle mainBundle] loadNibNamed:@"EnterpriseAddressView" owner:self options:nil] lastObject];
    }
    return _addressView;
}
- (NoRegisterLookView*)unlookView{
    if (!_unlookView) {
        _unlookView = [[[NSBundle mainBundle] loadNibNamed:@"NoRegisterLookView" owner:self options:nil] lastObject];
    }
    return _unlookView;
}

- (EnterpriseIntroduceView*)introduceView{
    if (!_introduceView) {
        _introduceView = [[EnterpriseIntroduceView alloc]init];
    }
    return _introduceView;
}
- (ENFooterView*)footerView{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"ENFooterView" owner:self options:nil] lastObject];
    }
    return _footerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

