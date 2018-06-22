//
//  EmptyView.h
//  BeruiHouse
//
//  Created by app on 15/12/21.
//  Copyright © 2015年 wangyueyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmptyView;
@protocol EmptyViewDelegate <NSObject>

@optional

- (void)uniVersalBtnClickForEmptyView:(EmptyView *)emptyView;

- (void)tappedWithEmptyView:(EmptyView *)emptyView;

@end

@interface EmptyView : UIView

- (void)getImageName:(NSString *)imageName tipsName:(NSString *)tipsName needBtn:(BOOL)needBtn btnName:(NSString *)btnName isPicNews:(BOOL)isPicNews;

@property (nonatomic,weak) id<EmptyViewDelegate>emptyViewDelegate;

@end
