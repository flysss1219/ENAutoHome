//
//  PersonHeadView.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "PersonHeadView.h"

@implementation PersonHeadView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    _vipView.layer.cornerRadius = 2.0f;
    _vipView.layer.masksToBounds = YES;
    _normalLevel.layer.cornerRadius = 2.0f;
    _normalLevel.layer.borderWidth = 0.5f;
    _normalLevel.layer.borderColor = [UIColor whiteColor].CGColor;
    _normalLevel.layer.masksToBounds = YES;
}

//更新用户信息
- (void)updateCurrentUser{
    
    
}

- (IBAction)clickHeadToLogin:(UIButton *)sender {
    
    if (_personDelegate && [_personDelegate respondsToSelector:@selector(personHeadViewDidLogin)]) {
        [_personDelegate personHeadViewDidLogin];
    }

}



@end
