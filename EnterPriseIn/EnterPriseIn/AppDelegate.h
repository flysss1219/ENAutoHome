//
//  AppDelegate.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENTabBarController.h"

@class ENTabBarController;
@class RTRootNavigationController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ENTabBarController* tabBarViewController;

@end

