//
//  CurrentUser.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/25.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "CurrentUser.h"
#import "KeyChainSaveUUID.h"
#import "TSCacheManager.h"

#define kUserInfoCacheKey  @"kUserInfoCacheKey"

@implementation CurrentUser

+ (CurrentUser *)sharedInstance{
    
    static CurrentUser *user = nil;
    if (user == nil) {
        user = [TSCacheManager getResponseCacheForKey:kUserInfoCacheKey];
        if(!user){
            user = [[CurrentUser alloc] init];
            [user save];
        }
//        [[EMClient sharedClient] addDelegate:user delegateQueue:nil];
    }
    return user;
}

- (id)init{
    self = [super init];
    if (self) {
        self.user_phone         = @"";
        self.user_pw            = @"";
        self.user_name          = @"";
        self.user_id            = @"";
        self.user_address       = @"";
        self.user_head          = @"";
        self.user_email         = @"";
        self.current_language   = ENAppChineseType;
    }
    return self;
}


- (void)loginWithData:(NSDictionary *)dic{
    
    [self registerUserAgent];
    
    //发送广播
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginInNotification object:nil];
    [self save];
}

- (void)loginOut{
    _user_phone = @"";
    _user_pw = @"";
    _user_name = @"";
    _user_id = @"";
    _user_head = @"";
    [self save];
    //发送广播
    [self registerUserAgent];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];
}

- (void)save{
    [TSCacheManager saveResponseCache:self forKey:kUserInfoCacheKey];
}

- (void)registerUserAgent{
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":[self userAgent]}];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userAgent{
//    if (self.tokenKey.length == 0) {
//        self.tokenKey = @"";
//    }
//    NSDictionary *userAgentDic = @{@"Imei":[KeyChainSaveUUID sharedInstance].UUID,@"CompanyName":@"Berui",@"AppName":@"FirstHouse",@"Client":@"iPhone",@"Token":self.tokenKey,@"Version":[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]};
//    NSString * userAgent = [self dicToJsonString:userAgentDic];
//
//    return userAgent;
    return nil;
}

- (NSString *)dicToJsonString:(NSDictionary *)dic {
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
    
}



#pragma mark -  NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.user_email forKey:@"user_email"];
    [aCoder encodeObject:self.user_head forKey:@"user_head"];
    [aCoder encodeObject:self.user_address forKey:@"user_address"];
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.user_pw forKey:@"user_pw"];
    [aCoder encodeObject:self.user_name forKey:@"user_name"];
    [aCoder encodeObject:self.user_phone forKey:@"user_phone"];
    [aCoder encodeInteger:self.current_language forKey:@"current_language"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self.user_email = [aDecoder decodeObjectForKey:@"user_email"];
    self.user_head = [aDecoder decodeObjectForKey:@"user_head"];
    self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
    self.user_address = [aDecoder decodeObjectForKey:@"user_address"];
    self.user_pw = [aDecoder decodeObjectForKey:@"user_pw"];
    self.user_name = [aDecoder decodeObjectForKey:@"user_name"];
    self.user_phone = [aDecoder decodeObjectForKey:@"user_phone"];
    self.current_language = [aDecoder decodeIntegerForKey:@"current_language"];
    
    return self;
}


@end
