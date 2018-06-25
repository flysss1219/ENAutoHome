//
//  CurrentUser.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/25.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kUserLoginInNotification @"kUserLoginInNotification"
#define kUserLoginOutNotification @"kUserLoginOutNotification"

@interface CurrentUser : NSObject<NSCoding>

@property (nonatomic,copy) NSString *user_phone;
@property (nonatomic,copy) NSString *user_pw;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *user_head;
@property (nonatomic,copy) NSString *user_email;
@property (nonatomic,copy) NSString *user_address;

+ (CurrentUser *)sharedInstance;

- (void)loginWithData:(NSDictionary *)dic;

- (void)loginOut;

- (void)save;

- (void)registerUserAgent;

- (NSString *)userAgent;



@end
