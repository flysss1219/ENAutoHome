//
//  NSDictionary+Additions.h
//  LKT
//
//  Created by Ting on 15/10/14.
//  Copyright © 2015年 Ting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (float)getFloatValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (id)getObjectValueForKey:(NSString *)key defaultValue:(id)defaultValue;

@end
