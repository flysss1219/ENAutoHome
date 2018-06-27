//
//  ApplyEnterpriseEnterView.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ApplyEnterpriseEnterView.h"

@implementation ApplyEnterpriseEnterView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    _applyButton.layer.cornerRadius = 5.0f;
    _applyButton.layer.masksToBounds = YES;
//    _applyButton.backgroundColor = ThemeColor;
    _introduceField.layer.cornerRadius = 5.0f;
    _introduceField.layer.borderColor = [UIColor colorWithHex:0xe5e5e5].CGColor;
    _introduceField.layer.borderWidth = 0.5f;
    _introduceField.layer.masksToBounds = YES;
    
}



- (IBAction)selectEnterpriseAddress:(id)sender {
    
    
}
- (IBAction)commitEnterApply:(id)sender {
    
    
    
}


@end
