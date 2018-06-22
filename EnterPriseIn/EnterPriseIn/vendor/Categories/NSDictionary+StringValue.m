//
//  NSDictionary+StringValue.m
//  FirstHouse
//
//  Created by zqq on 2018/1/18.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import "NSDictionary+StringValue.h"
#import "NSArray+StringValue.h"

@implementation NSDictionary (StringValue)

- (NSDictionary *)dictionaryWithStringValue{
    NSMutableDictionary *mutableSelf = [self mutableCopy];
    
    [mutableSelf enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            mutableSelf[key] = [obj dictionaryWithStringValue];
        }else if ([obj isKindOfClass:[NSArray class]]) {
            mutableSelf[key] = [obj arrayWithStringValue];
        }else{
            [mutableSelf setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }
        
    }];
    
    return [mutableSelf copy];
}
@end
