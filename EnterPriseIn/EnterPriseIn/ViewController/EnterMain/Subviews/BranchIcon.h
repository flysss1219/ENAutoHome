//
//  BranchIcon.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/21.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ENBranchModel;
@class BranchIcon;
@protocol BranchIconSelectDelegate<NSObject>
@optional
- (void)branchIconDidSelect:(NSInteger)index andMenuId:(NSString*)menuId;

@end

@interface BranchIcon : UIView

@property (nonatomic, strong) ENBranchModel *model;
@property (nonatomic, weak) id<BranchIconSelectDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString*)imageUrl andTitle:(NSString*)title;

- (instancetype)initWithFrame:(CGRect)frame andImageStr:(NSString*)image title:(NSString*)title;

@end
