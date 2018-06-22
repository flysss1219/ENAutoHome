//
//  UINavigationController+SafePushing.m
//  FirstHouse
//
//  Created by iOSDev on 2018/5/3.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import "UINavigationController+SafePushing.h"

@implementation UINavigationController (SafePushing)


- (id)navigationLock{
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated nvaigationLock:(id)navigationLock{
    if (!navigationLock || self.topViewController == navigationLock) {
        [self pushViewController:viewController animated:animated];
    }
}

- (NSArray*)popToViewController:(UIViewController*)viewController animated:(BOOL)animated navigationLock:(id)navigationLock{
    if (!navigationLock || self.topViewController == navigationLock) {
        return [self popToViewController:viewController animated:YES];
    }
    return @[];
}

- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)navigationLock{
    if (!navigationLock || self.topViewController == navigationLock) {
        return [self popToRootViewControllerAnimated:YES];
    }
    return @[];
}


@end
