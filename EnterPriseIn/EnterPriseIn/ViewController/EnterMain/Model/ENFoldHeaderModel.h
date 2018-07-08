//
//  ENFoldHeaderModel.h
//  CustomTable
//
//  Created by iOSDev on 2018/7/2.
//  Copyright © 2018年 berui.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 一二级分类model
@interface ENFoldHeaderModel : NSObject

//控制是否展示cell
@property (nonatomic, assign) BOOL isShowCell;
//是否被选中
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) NSString *header_title;
//该分类的ID
@property (nonatomic, copy) NSString *header_id;
//父级分类ID
@property (nonatomic, copy) NSString *parent_id;

//1级分类才有 广告图url
@property (nonatomic, copy) NSString *adUrl;

//所处的层级
@property (nonatomic, assign) NSInteger level;

//该目录下的子集
@property (nonatomic, strong) NSArray<ENFoldHeaderModel*>* subModel;

//二级分类下的的子分类数据（3.4级）
@property (nonatomic, strong) NSArray *sonList;

//一级分类赋值
+ (ENFoldHeaderModel*)setFirstLevelData:(NSDictionary*)data;

//二级分类赋值
+ (ENFoldHeaderModel*)setSecondLevelData:(NSDictionary*)data;




@end
