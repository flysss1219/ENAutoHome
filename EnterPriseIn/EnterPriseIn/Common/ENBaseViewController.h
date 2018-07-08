//
//  ENBaseViewController.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class RTRootNavigationController;

@interface ENBaseViewController : UIViewController


@property(strong,nonatomic) UIButton* backBtn;

@property (nonatomic, strong) UIButton *serviceButton;

#pragma mark - HUD

- (void)showHUDSimple;
- (void)showHUDWithLabel:(NSString *)tips;
- (void)setHUDProgress:(float)progress;
- (void)showHUDInfoWithStatuslabel:(NSString *)tips;
- (void)showHUDErrorWithStatuslabel:(NSString *)tips;
- (void)showSuccessWithStatuslabel:(NSString *)tips;
- (void)hideHUD;

#pragma mark - Toast
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration;


#pragma mark - UINavigationItem
- (void)addLeftBarButtonItem:(UIBarButtonItem *)item;

- (void)addLeftBarButtonItems:(NSArray *)items;

- (void)addRightBarButtonItem:(UIBarButtonItem *)item;

- (void)addRightBarButtonItems:(NSArray*)items;

//左侧按钮返回方法
-(void)setLeftButton;

-(void)backBtnClick;

- (void)connectCustomerService;


@end
