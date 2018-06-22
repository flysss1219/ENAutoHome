//
//  ENEnterViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
// 分类

#import "ENEnterViewController.h"
#import "CarBranchView.h"
#import "YYFPSLabel.h"
#import "BranchScrollView.h"
@interface ENEnterViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) BranchScrollView *branchView;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation ENEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.branchView];
    
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = KDeviceHeight-64-49 - 20;
    _fpsLabel.left = 20;
    _fpsLabel.alpha = 0;
    [self.view addSubview:_fpsLabel];
    
    
    [self initData];
    
    
}

- (void)initData{
    CGFloat y = 0.f;
    for (int i = 0; i<20; i++) {
        
        CarBranchView *branchView = [[CarBranchView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth-100, KDeviceHeight)];
        CGFloat height = [branchView setCarBranchForData:@[@"奥迪",@"宝马",@"奔驰",@"阿斯顿马丁",@"劳斯莱斯",@"别克",@"雪佛兰",@"丰田",@"东风小康"] andBranchTitle:NSLocalizedString(@"AppName", nil) andInitTag:100];
        branchView.frame = CGRectMake(0, y,KDeviceWidth-100, height);
        [self.mainScrollView addSubview:branchView];
        y += height;
    }
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth-100, y);
    [self.branchView setBranchScrollViewForData:@[@"东风小康",@"劳斯莱斯",@"东风小康",@"劳斯莱斯"]];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}




- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(100,0, KDeviceWidth, KDeviceHeight-49-64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (BranchScrollView*)branchView{
    if (!_branchView) {
        _branchView = [[BranchScrollView alloc]initWithFrame:CGRectMake(0, 0, 100, KDeviceHeight-49-64)];
        _branchView.showsVerticalScrollIndicator = NO;
        _branchView.showsHorizontalScrollIndicator = NO;
        _branchView.delegate = self;
    }
    return _branchView;
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
