//
//  CarBranchView.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/21.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CarBranchView;
@class ENBranchModel;
@protocol CarBranchViewDelegate<NSObject>

- (void)carBranchViewDidSelect:(NSInteger)index andMenuId:(NSString*)menuId;
@end

@interface CarBranchView : UIView

@property (nonatomic, weak) id<CarBranchViewDelegate> menuDelegate;

- (CGFloat)setCarBranchForData:(ENBranchModel*)branchModel andBranchTitle:(NSString*)title andInitTag:(NSInteger)tag;


@end
