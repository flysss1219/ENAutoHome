//
//  UserAccountInfoView.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserAccountInfoView;
@protocol UserAccountInfoViewDelegate<NSObject>

@optional

- (void)userInfoViewEditUserAccount;

- (void)userInfoViewEditUserAddress;

@end

@interface UserAccountInfoView : UIView

@property (nonatomic, weak) id<UserAccountInfoViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UILabel *userAccount;


@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountReplay;
@property (weak, nonatomic) IBOutlet UILabel *addressReplay;

- (void)updateUserInfo;

@end
