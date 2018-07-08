//
//  ENHttp.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/8.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HTTPRequestResponseBlock)(NSUInteger code,
                                        NSString *message,
                                        id data);

@class AdInfo;

@interface ENHttp : NSObject

//首页顶部广告图、企业类目、新闻头条
+ (void)getENHomePageDataCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *ads,NSArray *branchs,NSArray *hotNews))completeBlock;

//首页合作商家
+ (void)getHomePageCoorporationListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *coorporationList))completeBlock;

//企业分类
+ (void)getEnterpriseBranchListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *branchList))completeBlock;

//启动页图片
+ (void)getAppLaunchImageCompleteBlock:(void (^)(BOOL ok, NSString *message, AdInfo *adInfo))completeBlock;


@end
