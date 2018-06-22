//
//  NetworkErrorView.h
//  FirstHouse
//
//  Created by Ting on 2017/8/4.
//  Copyright © 2017年 Berui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NetworkErrorView;

@protocol NetworkErrorViewDelegate <NSObject>
@optional
- (void)reloadWithNetworkErrorView:(NetworkErrorView *)networkErrorView;

- (void)checkNetworkErrorResolve;

@end

@interface NetworkErrorView : UIView

@property (weak, nonatomic) IBOutlet UIButton *resolveButton;


@property (weak,nonatomic) id<NetworkErrorViewDelegate> delegate;


- (void)showResolveView;


@end
