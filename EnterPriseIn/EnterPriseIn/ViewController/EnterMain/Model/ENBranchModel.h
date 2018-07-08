//
//  ENBranchModel.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/5.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <Foundation/Foundation.h>


// 三四级分类model

@interface ENBranchModel : NSObject

@property (nonatomic, copy) NSString *branch_title;

@property (nonatomic, copy) NSString *branch_image;

@property (nonatomic, copy) NSString *branch_id;

@property (nonatomic, copy) NSString *logo;

//父级分类ID
@property (nonatomic, copy) NSString *parent_id;
//所处的层级
@property (nonatomic, assign) NSInteger level;

//该分类的企业数据
@property (nonatomic, strong) NSArray *companys;

//该目录下的子集
@property (nonatomic, strong) NSArray<ENBranchModel*>* subModel;

@property (nonatomic, assign) BOOL isSelected;

//三级分类赋值
+ (ENBranchModel*)setThirdLevelData:(NSDictionary*)data;

//四级分类赋值
+ (ENBranchModel*)setFourthLevelData:(NSDictionary*)data;


@end
