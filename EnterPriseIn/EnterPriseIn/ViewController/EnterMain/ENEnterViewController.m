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
#import "BranchListViewController.h"

@interface ENEnterViewController ()<UIScrollViewDelegate,BranchScrollViewDelegate,CarBranchViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) BranchScrollView *branchView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation ENEnterViewController
{
    NSMutableArray *_offsetArr;//记录每个分类模块的最大高度值
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyView];
    [self initData];
    
}

- (void)readyView{
    self.view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headImageView];
    [self.view addSubview:self.branchView];
    
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = KDeviceHeight-64-49 - 20;
    _fpsLabel.left = 20;
    _fpsLabel.alpha = 0;
    [self.view addSubview:_fpsLabel];
}

- (void)initData{
    
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.berui8.com/hefei/brzy/2018/05/20180511/3991W1526033145.png"]];
    
    _offsetArr = [NSMutableArray arrayWithCapacity:5];
    
    CGFloat y = 150.f;
    for (int i = 0; i<5; i++) {

        CarBranchView *branchView = [[CarBranchView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth-100, KDeviceHeight)];
        branchView.menuDelegate = self;
        CGFloat height = [branchView setCarBranchForData:@[@"奥迪",@"宝马",@"奔驰",@"阿斯顿马丁",@"劳斯莱斯",@"别克",@"雪佛兰",@"丰田",@"东风小康"] andBranchTitle:NSLocalizedString(@"AppName", nil) andInitTag:100];
        branchView.frame = CGRectMake(0, y,KDeviceWidth-100, height);
        [self.mainScrollView addSubview:branchView];
        
        [_offsetArr addObject:@(y)];
        y += height;
    }
    
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth-100, y);
    [self.branchView setBranchScrollViewForData:@[@"东风小康",@"劳斯莱斯",@"东风小康",@"劳斯莱斯",@"奔驰"]];
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat contentOffset_Y = scrollView.contentOffset.y;
//    if (scrollView == self.mainScrollView) {
//
//        if (contentOffset_Y >= [_offsetArr[0] floatValue]) {
//            [self.branchView branchButtonDidSelect:0];
//        }else if (contentOffset_Y >= [_offsetArr[1] floatValue]){
//            [self.branchView branchButtonDidSelect:1];
//        }else if (contentOffset_Y >= [_offsetArr[2] floatValue]){
//            [self.branchView branchButtonDidSelect:2];
//        }else if (contentOffset_Y >= [_offsetArr[3] floatValue]){
//            [self.branchView branchButtonDidSelect:3];
//        }else if (contentOffset_Y >= [_offsetArr[4] floatValue]){
//            [self.branchView branchButtonDidSelect:5];
//        }
//    }
    
    
}

#pragma mark - CarBranchViewDelegate
- (void)carBranchViewDidSelect:(NSInteger)index andMenuId:(NSString*)menuId{
    
    BranchListViewController *vc = [[BranchListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - BranchScrollViewDelegate
- (void)branchViewDidSelectInside:(NSInteger)index{
    
    CGFloat contentOffset = [_offsetArr[index] floatValue];
    [self.mainScrollView setContentOffset:CGPointMake(0, contentOffset) animated:YES];
}

#pragma mark -
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(100,0, KDeviceWidth, KDeviceHeight-49-64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (UIImageView*)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth-100, 150)];
        _headImageView.image = [UIImage imageNamed:@"zxpic"];
    }
    return _headImageView;
}

- (BranchScrollView*)branchView{
    if (!_branchView) {
        _branchView = [[BranchScrollView alloc]initWithFrame:CGRectMake(0,0,100, KDeviceHeight-49-64)];
        _branchView.showsVerticalScrollIndicator = NO;
        _branchView.showsHorizontalScrollIndicator = NO;
        _branchView.delegate = self;
        _branchView.branchDelegate = self;
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
