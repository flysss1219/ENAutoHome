//
//  UIImage+FixOrientation.h
//  Nextdoors
//
//  Created by hfhouse on 15/6/8.
//  Copyright (c) 2015年 hfw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)

- (UIImage *)fixOrientation;

- (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size;

@end
