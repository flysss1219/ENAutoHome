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
    _applyButton.backgroundColor = ThemeColor;
    _introduceField.layer.cornerRadius = 5.0f;
    _introduceField.layer.borderColor = [UIColor colorWithHex:0xe5e5e5].CGColor;
    _introduceField.layer.borderWidth = 0.5f;
    _introduceField.layer.masksToBounds = YES;
    
    _nameLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"EnterpriseName", nil);
    _addressLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"EnterpriseAddress", nil);
    _introduceLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"EnterpriseIntroduce", nil);
    _connectLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"ConnectInfo", nil);
    _fullNameLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"FirstName", nil);
    _telLabel.text = LocalizableHelperGetStringWithKeyFromTable(@"TEL", nil);
    
    _nameField.placeholder = LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);
    _detailAddressField.placeholder = LocalizableHelperGetStringWithKeyFromTable(@"DetailAddress", nil);
    _introduceField.text = LocalizableHelperGetStringWithKeyFromTable(@"MaxWordCount", nil);
    _connectField.placeholder = LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);
    _phoneField.placeholder = LocalizableHelperGetStringWithKeyFromTable(@"PleaseFillin", nil);

    [_applyButton setTitle:LocalizableHelperGetStringWithKeyFromTable(@"ApplyEnter", nil) forState:UIControlStateNormal];
    
}


- (IBAction)commitEnterApply:(id)sender {
    
    
    
}


@end
