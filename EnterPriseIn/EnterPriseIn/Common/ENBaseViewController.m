//
//  ENBaseViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENBaseViewController.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "UIColor+Hex.h"
#import "ENTabBarController.h"


@interface ENBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *theNavigationController;

@end

@implementation ENBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0xffffff];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self myStatusBarStyle];
}

- (UIStatusBarStyle )myStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
#pragma mark - HUD

- (void)showHUDSimple {
    [SVProgressHUD showWithStatus:nil];
}

- (void)showHUDWithLabel:(NSString *)tips {
    [SVProgressHUD showWithStatus:tips];
}

- (void)showHUDInfoWithStatuslabel:(NSString *)tips{
    [SVProgressHUD showInfoWithStatus:tips];
}

- (void)showHUDErrorWithStatuslabel:(NSString *)tips{
    [SVProgressHUD showErrorWithStatus:tips];
}

- (void)showSuccessWithStatuslabel:(NSString *)tips{
    [SVProgressHUD showSuccessWithStatus:tips];
    
}
- (void)setHUDProgress:(float)progress {
    [SVProgressHUD showProgress:progress status:@"加载中..."];
}

- (void)hideHUD {
    [SVProgressHUD dismiss];
}
#pragma mark - Toast

- (void)makeToast:(NSString *)message {
    [self makeToast:message duration:1];
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration {
    if (message.length > 0) {
        UIWindow *toastDisplaywindow = [UIApplication sharedApplication].keyWindow;
        toastDisplaywindow.backgroundColor = [UIColor clearColor];
        [toastDisplaywindow makeToast:message duration:duration HeightScale:0.5];
    }
}

#pragma mark - UINavigationItem

- (void)addLeftBarButtonItem:(UIBarButtonItem *)item {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = - 5;
    }else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = - 15;
    }
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)item {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = - 5;
    }
    else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = - 15;
    }
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, item];
}


- (void)addLeftBarButtonItems:(NSArray *)items {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = - 5;
    } else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = - 15;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:negativeSpacer];
    for (UIBarButtonItem *item in items) {
        [array addObject:item];
    }
    self.navigationItem.leftBarButtonItems = array;
}

- (void)addRightBarButtonItems:(NSArray *)items {
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        negativeSpacer.width = - 5;
    } else {
        // Load resources for iOS 7 or later
        negativeSpacer.width = -15;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:negativeSpacer];
    for (UIBarButtonItem *item in items) {
        [array addObject:item];
    }
    self.navigationItem.rightBarButtonItems = array;
}

- (void)setLeftButton{
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,44, 44)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    _backBtn.adjustsImageWhenHighlighted = NO;
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (IOS_VERSION >= 11) {
        _backBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15,0,0)];
    }
    [self addLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:_backBtn]];
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
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
