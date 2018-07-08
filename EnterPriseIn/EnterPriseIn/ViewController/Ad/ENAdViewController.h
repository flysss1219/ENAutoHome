//
//  ENAdViewController.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/5.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENBaseViewController.h"


@class AdInfo;


@interface ENAdViewController : ENBaseViewController

@property (nonatomic,copy)void(^skipLoginStatus)(AdInfo *adInfo);

@end
