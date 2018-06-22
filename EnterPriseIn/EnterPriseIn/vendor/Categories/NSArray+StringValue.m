//
//  NSArray+StringValue.m
//  FirstHouse
//
//  Created by zqq on 2018/1/18.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import "NSArray+StringValue.h"
#import "NSDictionary+StringValue.h"

@implementation NSArray (StringValue)

- (NSArray *)arrayWithStringValue{
    NSMutableArray *mutableSelf = [self mutableCopy];
    
    for (int i = 0; i < mutableSelf.count; i++) {
        id obj = mutableSelf[i];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            mutableSelf[i] = [obj dictionaryWithStringValue];
        }else if ([obj isKindOfClass:[NSArray class]]) {
            mutableSelf[i] = [obj arrayWithStringValue];
        }
    }
    
    return [mutableSelf copy];
}
@end
