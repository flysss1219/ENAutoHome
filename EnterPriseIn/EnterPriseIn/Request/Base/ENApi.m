//
//  ENApi.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/7.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENApi.h"

//http://wiki.qxswt.com/index.php?act=api&tag=6&tid=125#info_api_3def184ad8f4755ff269862ea77393dd
//https://gitee.com/Jeffe/qimopei/invite_link?invite=d1952e32adf7a6b6f609598fe68e763163fd8d12c1f2cb8a23a42de95d8bc05ed3e186d7cdef5209
@implementation ENApi

//首页顶部广告图、企业类目、新闻头条
+ (NSString*)getHomePageApi{
    return @"/home_data";
}

//首页合作商家
+ (NSString*)getEnterpriseApi{
    
    return @"/home_cooperate_company";
}
//启动页的图片
+ (NSString*)getLauuchImageApi{
    return @"/launch_pic";
}

//企业分类
+ (NSString*)getEnterpriseBranchApi{
    return @"/company_category_list";
}

//
+ (NSString*)getEnterpriseInfoApi{
    return nil;
}
//
+ (NSString*)getNewsMainApi{
    return nil;
}
//
+ (NSString*)getApplyEnterApi{
    return nil;
}
//
+ (NSString*)getUserInfoApi{
    return nil;
}
//
+ (NSString*)getLoginApi{
    return nil;
}
//
+ (NSString*)getRegisterApi{
    return nil;
}
//
+ (NSString*)getVertifyCodeApi{
    return nil;
}
//
+ (NSString*)getForgetPasswordApi{
    return nil;
}
//
+ (NSString*)getResetNickNameApi {
    return nil;
}
//
+ (NSString*)getResetAddressApi {
    return nil;
}


@end
