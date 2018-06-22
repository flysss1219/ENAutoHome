//
//  NSDictionary+Additions.m
//  LKT
//
//  Created by Ting on 15/10/14.
//  Copyright © 2015年 Ting. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (float)getFloatValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] floatValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] intValue];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
    NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    if (self && [self isKindOfClass:[NSDictionary class]]) {
        if (self.allKeys && [self.allKeys containsObject:key]) {
            return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
            ? defaultValue : [NSString stringWithFormat:@"%@",[self objectForKey:key]];
        }else{
            return defaultValue;
        }
        
    }else{
        return defaultValue;
    }
    
}

- (id)getObjectValueForKey:(NSString *)key defaultValue:(id)defaultValue
{
    if (self && [self isKindOfClass:[NSDictionary class]]) {
        if (self.allKeys && [self.allKeys containsObject:key]) {
            return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
            ? defaultValue : [self objectForKey:key];
        }else{
            return defaultValue;
        }
        
    }else{
        return defaultValue;
    }
    
}


@end
