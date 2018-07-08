//
//  EnterpriseInfoModel.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/8.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnterpriseInfoModel : NSObject

@property (nonatomic,copy) NSString *company_id;

@property (nonatomic,copy) NSString *company_title;

@property (nonatomic,copy) NSString *company_logo;

@property (nonatomic,copy) NSString *company_hits;

@property (nonatomic,copy) NSString *company_address;

@property (nonatomic,assign) BOOL   is_vip;

@end
