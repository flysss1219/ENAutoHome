//
//  UINavigationController+SafePushing.h
//  FirstHouse
//
//  Created by iOSDev on 2018/5/3.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SafePushing)


- (id)navigationLock;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated nvaigationLock:(id)navigationLock;

- (NSArray*)popToViewController:(UIViewController*)viewController animated:(BOOL)animated navigationLock:(id)navigationLock;

- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)navigationLock;


@end
