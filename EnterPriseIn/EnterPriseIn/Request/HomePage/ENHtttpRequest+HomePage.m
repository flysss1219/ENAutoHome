//
//  ENHtttpRequest+HomePage.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/7.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHtttpRequest+HomePage.h"
#import "AdInfo.h"
#import "ENHtttpRequest+Private.h"
#import "ENApi.h"


@implementation ENHtttpRequest (HomePage)

+ (void)getENHomePageDataCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *ads,NSArray *branchs,NSArray *hotNews))completeBlock{
    NSString *url = [HTTPRequestPrivateBaseURL() stringByAppendingString:[ENApi getHomePageApi]];
    
    [self getCommand:NSStringFromSelector(_cmd)
                  url:url
           parameters:nil
        responseBlock:^(NSUInteger code, NSString *message, NSDictionary *data) {
            
            if (!completeBlock) {
                return;
            }
            
            if (code != 1) {
                completeBlock(NO, message, nil,nil,nil);
                return;
            }
            completeBlock(YES, message,nil,nil,nil);
        }];
}

+ (void)getRecommandEnterpriseListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *enterpriseList))completeBlock{
    
}

+ (void)getENAppLaunchImageCompleteBlock:(void (^)(BOOL ok, NSString *message, AdInfo *adInfo))completeBlock{
    
}



@end
