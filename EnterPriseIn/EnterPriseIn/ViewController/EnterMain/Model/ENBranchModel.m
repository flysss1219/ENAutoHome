//
//  ENBranchModel.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/5.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENBranchModel.h"

@implementation ENBranchModel


//三级分类赋值
+ (ENBranchModel*)setThirdLevelData:(NSDictionary *)data{
    
    ENBranchModel *model = [[ENBranchModel alloc]init];
    model.branch_id = data[@"id"];
    model.parent_id = data[@"parent_id"];
    model.branch_title = data[@"name"];
    model.logo = data[@"logo"];
    model.level = [data[@"_level"] integerValue];
    
    NSMutableArray *sonlist = [NSMutableArray arrayWithCapacity:0];
    NSArray *childrens = data[@"children"];
    for (NSDictionary *subDict in childrens) {
        ENBranchModel *subModel = [self setFourthLevelData:subDict];
        [sonlist addObject:subModel];
    }
    model.subModel = sonlist;
    
    return model;
}

//四级分类赋值
+ (ENBranchModel*)setFourthLevelData:(NSDictionary *)data{
    
    ENBranchModel *subModel = [[ENBranchModel alloc]init];
    subModel.branch_id = data[@"id"];
    subModel.parent_id = data[@"parent_id"];
    subModel.branch_title = data[@"name"];
    subModel.logo = data[@"logo"];
    subModel.level = [data[@"_level"] integerValue];
    
    return subModel;
}


@end
