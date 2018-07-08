//
//  ApplyEnterpriseEnterView.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyEnterpriseEnterView : UIView


//企业名称
@property (weak, nonatomic) IBOutlet UITextField *nameField;
//详细地址
@property (weak, nonatomic) IBOutlet UITextField *detailAddressField;
//简介
@property (weak, nonatomic) IBOutlet UITextView *introduceField;

//姓名
@property (weak, nonatomic) IBOutlet UITextField *connectField;
//电话号码
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
//申请
@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *connectLabel;

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;



@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@end
