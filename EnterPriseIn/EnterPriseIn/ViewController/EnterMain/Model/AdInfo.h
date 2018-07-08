//
//  AdInfo.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/5.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdInfo : NSObject

@property (nonatomic, copy) NSString *adId;                     //广告id
@property (nonatomic, copy) NSString *adTitle;                  //广告标题
@property (nonatomic, copy) NSString *adJumpUrl;                //广告跳转地址
@property (nonatomic, copy) NSArray  *adContentUrl;             //广告内容

@end
