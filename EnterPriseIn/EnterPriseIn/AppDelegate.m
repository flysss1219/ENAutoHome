//
//  AppDelegate.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "AppDelegate.h"
#import "CurrentUser.h"
#import "IQKeyboardManager.h"
#import "Reachability.h"
#import "ENAdViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "AdInfo.h"
#import "LanguageLocalizableHelper.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    //各种配置
    [self configSDKWithApplication:application options:launchOptions];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveLanguageChangedNotification:) name:LANGUAGEHADCHANGED object:nil];
    

    //收缩键盘
    [self configurateKeyBoard];
    
    //设置弹出框样式
    [SVProgressHUD setForegroundColor:[UIColor colorWithHex:0xffffff]];
    [SVProgressHUD setBackgroundColor:[[UIColor colorWithHex:0x000000] colorWithAlphaComponent:0.7]];
    
    //广告
    ENAdViewController *adViewController = [ENAdViewController new];
    [adViewController setSkipLoginStatus:^(AdInfo *adInfo){
        [self changeToHomeViewController:adInfo];
    }];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = adViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)changeToHomeViewController:(AdInfo *)adInfo {
    RTRootNavigationController *nav =  [[RTRootNavigationController alloc]initWithRootViewControllerNoWrapping:self.tabBarViewController];
    self.window.rootViewController = nav;
    if (adInfo.adId.length > 0  && [GlobalFunction isUrlAddress:adInfo.adJumpUrl]) {
        
    }
    
}
// 配置键盘
- (void)configurateKeyBoard{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;
}

- (void)configSDKWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions{
    //全局样式
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UINavigationBar appearance] setBackgroundImage:[PureColorToImage imageWithColor:[UIColor colorWithHex:0x4a72ff] andWidth:10 andHeight:10]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色
    [[UINavigationBar appearance] setShadowImage:[PureColorToImage imageWithColor:[UIColor colorWithHex:0xe5e5e5] andWidth:ScreenSize.width andHeight:0.5]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveLanguageChangedNotification:(NSNotification*)notification{
    
    RTRootNavigationController *nav =  [[RTRootNavigationController alloc]initWithRootViewControllerNoWrapping:[[ENTabBarController alloc]init]];
    self.window.rootViewController = nav;
    
}

#pragma mark - getter

- (ENTabBarController *)tabBarViewController {
    if (!_tabBarViewController) {
        _tabBarViewController = [ENTabBarController new];
    }
    return _tabBarViewController;
}

@end
