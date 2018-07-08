//
//  UserNickNameView.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/3.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "UserNickNameView.h"

@implementation UserNickNameView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    _nickLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"NickName", nil);
    _resetLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"Reset", nil);
    
    
}

@end
