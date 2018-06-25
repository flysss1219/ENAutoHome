//
//  NavigationManager.h
//  FirstHouse
//
//  Created by iOSDev on 2017/10/20.
//  Copyright © 2017年 Berui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NavigationManager : NSObject

+ (instancetype)sharedInstance;

- (void)startThirdAppNavigationWithStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint inView:(UIViewController*)vc;

@end
