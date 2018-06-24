//
//  PersonHeadView.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;

@property (weak, nonatomic) IBOutlet UILabel *normalLevel;

@property (weak, nonatomic) IBOutlet UILabel *inLabel;

@property (weak, nonatomic) IBOutlet UIView *vipView;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;

@property (weak, nonatomic) IBOutlet UILabel *vipLabel;

//更新用户信息
- (void)updateCurrentUser;


@end
