//
//  UserAccountInfoView.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "UserAccountInfoView.h"

@implementation UserAccountInfoView





- (IBAction)editUserAccount:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(userInfoViewEditUserAccount)]) {
    
        [_delegate userInfoViewEditUserAccount];
    }
    
    
}

- (IBAction)editUserAddress:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(userInfoViewEditUserAddress)]) {
        
        [_delegate userInfoViewEditUserAddress];
    }
    
}






@end
