//
//  BranchScrollView.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/21.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BranchScrollView;
@protocol BranchScrollViewDelegate<NSObject>
@optional
- (void)branchViewDidSelectInside:(NSInteger)index;
@end
@interface BranchScrollView : UIScrollView

@property (nonatomic, weak) id<BranchScrollViewDelegate> branchDelegate;

- (CGFloat)setBranchScrollViewForData:(NSArray*)data;


- (void)branchButtonDidSelect:(NSUInteger)index;


@end
