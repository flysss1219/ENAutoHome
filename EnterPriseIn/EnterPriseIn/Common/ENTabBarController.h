//
//  ENTabBarController.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTRootNavigationController;

@interface ENTabBarController : UITabBarController<UITabBarControllerDelegate, UITabBarDelegate>

@property (nonatomic, weak) id tabBarDelegate;

- (void)tabBarSelectAtIndex:(NSInteger )index;
// 是否显示未读消息小红点

- (void)showMessagePointView:(BOOL)showPointView;

- (void)showTabBarItemWithIndex:(NSInteger )index;


@end
