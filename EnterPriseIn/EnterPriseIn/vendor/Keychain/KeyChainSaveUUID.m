//
//  KeyChainSave.m
//  AH2House
//
//  Created by Ting on 14-7-22.
//  Copyright (c) 2014年 星空传媒控股. All rights reserved.
//

#import "KeyChainSaveUUID.h"

@implementation KeyChainSaveUUID

+ (instancetype )sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

-(NSString *)UUID {
    if (_UUID.length == 0) {
        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"deviceIdentifier" accessGroup:nil];
        _UUID = [wrapper objectForKey:(id)kSecAttrAccount];
        if ([_UUID isEqualToString:@""]) {
            [wrapper setObject:[self generateUUID] forKey:(id)kSecAttrAccount];
            NSLog(@"set uniqueIdentifier.");
        }
        _UUID = [wrapper objectForKey:(id)kSecAttrAccount];
    }
    return _UUID;
}

- (void)clean {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"deviceIdentifier" accessGroup:nil];
    [wrapper setObject:@"" forKey:(id)kSecAttrAccount];
    _UUID = 0;
}

- (NSString *)generateUUID {
    CFUUIDRef puuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return [[result stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

@end
