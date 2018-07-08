//
//  ENHtttpRequest+HomePage.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/7.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHtttpRequest.h"

@class AdInfo;
@interface ENHtttpRequest (HomePage)

+ (void)getENHomePageDataCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *ads,NSArray *branchs,NSArray *hotNews))completeBlock;

+ (void)getRecommandEnterpriseListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *enterpriseList))completeBlock;

+ (void)getENAppLaunchImageCompleteBlock:(void (^)(BOOL ok, NSString *message, AdInfo *adInfo))completeBlock;


@end
