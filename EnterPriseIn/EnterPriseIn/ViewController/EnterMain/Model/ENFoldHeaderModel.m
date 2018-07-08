//
//  ENFoldHeaderModel.m
//  CustomTable
//
//  Created by iOSDev on 2018/7/2.
//  Copyright © 2018年 berui.com. All rights reserved.
//

#import "ENFoldHeaderModel.h"

@implementation ENFoldHeaderModel

- (instancetype)init{
    if (self = [super init]) {
        self.isShowCell = NO;
        
        
    }
    return self;
}

//一级分类赋值
+ (ENFoldHeaderModel*)setFirstLevelData:(NSDictionary*)data{
    
    ENFoldHeaderModel *model = [[ENFoldHeaderModel alloc]init];
    model.header_id = data[@"id"];
    model.parent_id = data[@"parent_id"];
    model.header_title = data[@"name"];
    model.adUrl = data[@"adv_pic"];
    model.level = [data[@"_level"] integerValue];
    
    NSMutableArray *sonlist = [NSMutableArray arrayWithCapacity:0];
    NSArray *childrens = data[@"children"];
    for (NSDictionary *subDict in childrens) {
        ENFoldHeaderModel *subModel = [self setSecondLevelData:subDict];
        [sonlist addObject:subModel];
    }
    model.subModel = sonlist;
    
    return model;
}

//二级分类赋值
+ (ENFoldHeaderModel*)setSecondLevelData:(NSDictionary*)data{
    
    ENFoldHeaderModel *subModel = [[ENFoldHeaderModel alloc]init];
    subModel.header_id = data[@"id"];
    subModel.parent_id = data[@"parent_id"];
    subModel.header_title = data[@"name"];
    subModel.level = [data[@"_level"] integerValue];
    subModel.sonList = data[@"children"];
    
    return subModel;
}

@end
