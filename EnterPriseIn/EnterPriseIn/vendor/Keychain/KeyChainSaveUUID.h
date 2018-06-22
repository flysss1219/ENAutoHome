//
//  KeyChainSave.h
//  AH2House
//
//  Created by Ting on 14-7-22.
//  Copyright (c) 2014年 星空传媒控股. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface KeyChainSaveUUID : NSObject

@property (nonatomic,copy) NSString  *UUID;

+ (instancetype)sharedInstance;

- (void)clean;

@end
