//
//  UIImage+PhotoCategory.m
//  FirstHouse
//
//  Created by iOSDev on 2018/4/25.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import "UIImage+PhotoCategory.h"
#import <objc/runtime.h>

static const void *categorykey = &categorykey;

@implementation UIImage (PhotoCategory)


- (void)setCategory:(NSString *)category{
    objc_setAssociatedObject(self, categorykey, category, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)category{
    return (objc_getAssociatedObject(self, &categorykey));
}

@end
