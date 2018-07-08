//
//  UserAccountInfoView.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "UserAccountInfoView.h"

@implementation UserAccountInfoView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
    
    if ([LanguageLocalizableHelper shareInstance].currentLanguage == Language_zh_Hans) {
        _accountLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"AccountNamePhone", nil);
    }else{
        _accountLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"Email", nil);
    }
     _addressTitle.text = LocalizableHelperGetStringWithKeyFromTable(@"Address", nil);
     _accountReplay.text = LocalizableHelperGetStringWithKeyFromTable(@"Reset", nil);
     _addressReplay.text = LocalizableHelperGetStringWithKeyFromTable(@"Reset", nil);
}

- (void)updateUserInfo{
    
    
}

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
