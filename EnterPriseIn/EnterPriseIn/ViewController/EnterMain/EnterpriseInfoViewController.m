//
//  EnterpriseInfoViewController.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "EnterpriseInfoViewController.h"
#import "ENPictureCollectionView.h"


@interface EnterpriseInfoViewController ()<ENPictureCollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* mainScrollView;

@property (nonatomic, strong) UIImageView* headImageView;

@property (nonatomic, strong) ENPictureCollectionView *pictureCollectionView;


@end

@implementation EnterpriseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyView];
}

- (void)readyView{
    [self setLeftButton];
    self.title = @"企业详情";
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headImageView];
    [self.mainScrollView addSubview:self.pictureCollectionView];
    
    
    WS(ws);
    
    
}


- (void)requestEnterpriseInfomation{
    
    
}

#pragma mark - getter
- (ENPictureCollectionView*)pictureCollectionView{
    
    if (!_pictureCollectionView) {
        _pictureCollectionView = [[ENPictureCollectionView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 100) collectionViewLayout:[UICollectionViewLayout new]];
        _pictureCollectionView.pictureDelegate = self;
    }
    return _pictureCollectionView;
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

- (UIImageView*)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth,150)];
        _headImageView.image = [UIImage imageNamed:@"zxpic"];
    }
    return _headImageView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
