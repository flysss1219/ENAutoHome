//
//  ENHttp.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/8.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHttp.h"
#import <AFNetworking.h>
#import "AFNetworkReachabilityManager.h"
#import "cJSON.h"
#import "NSData+Base64.h"
#import "JSONKit.h"
#import "NSDictionary+Null.h"
#import "NSArray+Null.h"
#import "ENApi.h"

//model
#import "AdInfo.h"
#import "NewsItem.h"
#import "ENBranchModel.h"
#import "EnterpriseInfoModel.h"
#import "ENFoldHeaderModel.h"

static NSString * const kBaseURL  = @"/api/home/index";    // 公网服务器

@implementation ENHttp

static NSString* JSONStringFromDictionary(NSDictionary *dictionary) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
    return JSONStringFromData(data);
}

static NSString* JSONStringFromData(NSData *data) {
    
    cJSON *json = cJSON_Parse(data.bytes);
    if (!json) {
        NSLog(@"parse parameter JSON string failed! response is: %s", data.bytes);
        return @"";
    }
    
    char *cstring = cJSON_Print(json);
    NSString *jsonString = [NSString stringWithCString:cstring encoding:NSUTF8StringEncoding];
    free(cstring);
    cJSON_Delete(json);
    
    return jsonString;
}

#pragma mark - Public functions
NSString* HTTPRequestPrivateBaseURL() {
    return [NSString stringWithFormat:@"%@",kBaseURL];
}
#pragma mark - Requst
//首页顶部广告图、企业类目、新闻头条
+ (void)getENHomePageDataCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *ads,NSArray *branchs,NSArray *hotNews))completeBlock{
    
    NSString *url = [HTTPRequestPrivateBaseURL() stringByAppendingString:[ENApi getHomePageApi]];
    
    [self getCommand:NSStringFromSelector(_cmd) url:url parameters:nil responseBlock:^(NSUInteger code, NSString *message, id data) {
       
        if (!completeBlock) {
            completeBlock(NO, message, nil,nil,nil);
            return;
        }
        
        if (code != 1) {
            completeBlock(NO, message, nil,nil,nil);
            return;
        }
        NSMutableArray *adsArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *branchArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *newsArr = [NSMutableArray arrayWithCapacity:0];
        
        NSArray *ads = data[@"slide_data"];
        for (NSDictionary *dict in ads) {
            AdInfo *adinfo = [[AdInfo alloc]init];
            adinfo.adId = dict[@"bind_company_id"];
            adinfo.adContentUrl = dict[@"image"];
            [adsArr addObject:adinfo];
        }
        NSArray *cates = data[@"cate_data"];
        for (NSDictionary *dict in cates) {
            ENBranchModel *model = [[ENBranchModel alloc]init];
            model.branch_id = dict[@"id"];
            model.logo = dict[@"image"];
            model.branch_title = dict[@"name"];
            [branchArr addObject:model];
        }
        NSArray *news = data[@"article_data"];
        for (NSDictionary *dict in news) {
            NewsItem *item = [[NewsItem alloc]init];
            item.newsId = dict[@"id"];
            item.newsTitle = dict[@"post_title"];
            [newsArr addObject:item];
        }
        completeBlock(YES, message, adsArr,branchArr,newsArr);
    }];
}

//首页合作商家
+ (void)getHomePageCoorporationListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *coorporationList))completeBlock{
    NSString *url = [HTTPRequestPrivateBaseURL() stringByAppendingString:[ENApi getEnterpriseApi]];
    
    [self getCommand:NSStringFromSelector(_cmd) url:url parameters:nil responseBlock:^(NSUInteger code, NSString *message, id data) {
        
        if (!completeBlock) {
            completeBlock(NO, message, nil);
            return;
        }
        
        if (code != 1) {
            completeBlock(NO, message,nil);
            return;
        }
        if (![data isKindOfClass:[NSArray class]]) {
            completeBlock(NO, message,nil);
            return;
        }
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in data) {
            EnterpriseInfoModel *model = [[EnterpriseInfoModel alloc]init];
            model.company_id = dict[@"id"];
            model.company_logo = dict[@"logo"];
            model.company_title = dict[@"company_title"];
            model.company_hits = dict[@"hits"];
            model.company_address = dict[@"p_c_a"];
            model.is_vip = [dict[@"is_vip"] boolValue];
            [array addObject:model];
        }
        
        completeBlock(YES, message,array);
    }];
}

//企业分类
+ (void)getEnterpriseBranchListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *branchList))completeBlock{
    NSString *url = [HTTPRequestPrivateBaseURL() stringByAppendingString:[ENApi getEnterpriseBranchApi]];
    
    [self getCommand:NSStringFromSelector(_cmd) url:url parameters:nil responseBlock:^(NSUInteger code, NSString *message, id data) {
        
        if (!completeBlock) {
            completeBlock(NO, message, nil);
            return;
        }
        
        if (code != 1) {
            completeBlock(NO, message,nil);
            return;
        }
        if (![data isKindOfClass:[NSArray class]]) {
            completeBlock(NO, message,nil);
            return;
        }
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dict in data) {
            
            ENFoldHeaderModel *model;
            model = [ENFoldHeaderModel setFirstLevelData:dict];
            [array addObject:model];
        }
        
        
        
        completeBlock(YES, message,array);
    }];
}

//启动页图片
+ (void)getAppLaunchImageCompleteBlock:(void (^)(BOOL ok, NSString *message, AdInfo *adInfo))completeBlock{
    NSString *url = [HTTPRequestPrivateBaseURL() stringByAppendingString:[ENApi getLauuchImageApi]];
    
    [self getCommand:NSStringFromSelector(_cmd) url:url parameters:nil responseBlock:^(NSUInteger code, NSString *message, id data) {
        
        if (!completeBlock) {
            completeBlock(NO, message, nil);
            return;
        }
        
        if (code != 1) {
            completeBlock(NO, message,nil);
            return;
        }
        if (![data isKindOfClass:[NSDictionary class]]) {
            completeBlock(NO, message,nil);
            return;
        }
        AdInfo *ad = [[AdInfo alloc]init];
        ad.adId = data[@"bind_company_id"];
        ad.adContentUrl = data[@"image"];

        completeBlock(YES, message,ad);
    }];
}




#pragma mark - private methods
+ (void)getCommand:(NSString *)command
               url:(NSString *)url
        parameters:(NSDictionary *)parameters
     responseBlock:(HTTPRequestResponseBlock)responseBlock{
    return [self startRequestCommand:command url:url parameters:parameters timeout:60 responseBlock:responseBlock];
}

+ (void)startRequestCommand:(NSString *)command
                        url:(NSString *)url
                 parameters:(NSDictionary *)parameters
                    timeout:(NSTimeInterval)timeout
              responseBlock:(HTTPRequestResponseBlock)responseBlock {
    
    url = [NSString stringWithFormat:@"%@%@",kBasePort,url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = timeout;
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSLog(@"%@ url --%@ response JSON is: %@ ", NSStringFromClass(self.class),url,JSONStringFromData(responseObject));
            NSDictionary *response= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
            
            if ([response isKindOfClass:[NSDictionary class]]) {
                
                response = [response dictionaryWithoutNull];
                
                NSString *message = response[@"msg"];
                NSNumber *code = response[@"code"];
                NSDictionary *data = response[@"data"];
                
                if (responseBlock) {
                    
                    if ([code integerValue] == 1) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            responseBlock([code integerValue], message, data);
                        });
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            responseBlock([code integerValue], message, nil);
                        });
                    }
                }else {
                    if (responseBlock) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            responseBlock(-1, @"当前网络状况不佳", nil);
                        });
                    }
                }
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ request failed, error is: %@", command, error);
        if (responseBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                responseBlock(error.code, @"当前网络状况不佳", nil);
            });
        }
    }];
    
}




@end
