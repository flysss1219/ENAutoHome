//
//  ENApplyResultView.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/30.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENApplyResultView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reasonHeight;


@end
