//
//  NSArray+CheckBeyondArray.m
//  FirstHouse
//
//  Created by zqq on 2018/1/18.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import "NSArray+CheckBeyondArray.h"
#import <objc/runtime.h>

@implementation NSArray (CheckBeyondArray)

//这个方法无论如何都会执行
+ (void)load {
    // 选择器
    SEL safeSel = @selector(safeObjectAtIndex:);
    SEL unsafeSel = @selector(objectAtIndex:);
    
    Class class = NSClassFromString(@"__NSArrayI");
    // 方法
    Method safeMethod = class_getInstanceMethod(class, safeSel);
    Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
    
    // 交换方法
    method_exchangeImplementations(unsafeMethod, safeMethod);
}


- (id)safeObjectAtIndex:(NSUInteger)index {
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1) || !self.count) { // 数组越界
        
        @try {
            return [self safeObjectAtIndex:index];
        }
        @catch (NSException *exception) {
            NSAssert(NO, @"数组越界了"); // 只有开发的时候才会造成程序崩了
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
    }else { // 没有越界
        return [self safeObjectAtIndex:index];
    }
}

@end
