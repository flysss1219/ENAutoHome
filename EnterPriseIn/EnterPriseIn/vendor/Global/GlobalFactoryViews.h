//
//  GlobalFactoryViews.h
//  FirstHouse
//
//  Created by iOSDev on 2018/1/15.
//  Copyright © 2018年 Berui. All rights reserved.
//
//  常见控件初始化方法，常用方法

#import <Foundation/Foundation.h>


@interface GlobalFactoryViews : NSObject

#pragma mark - connerRadius
+ (void)LayerCornerRadius:(CALayer*)layer connerRadius:(CGFloat)radius;

+ (void)LayerCornerRadius:(CALayer*)layer connerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;

#pragma mark - UILabel
//不含frame适用于masonry
+ (UILabel*)createLabelWithLabelText:(NSString*)text labelFont:(UIFont*)font textColor:(UIColor*)textColor textAligenment:(NSTextAlignment)textAlignment;
//带frame
+ (UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString*)text labelFont:(UIFont*)font textColor:(UIColor*)textColor textAligenment:(NSTextAlignment)textAlignment;

#pragma mark - UIImageView
+ (UIImageView*)createImageView;

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame;

#pragma mark - UITextField
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame placeHolder:(NSString*)placeholder font:(UIFont*)font textColor:(UIColor*)textColor placeholderColor:(UIColor*)placeholderColor;

#pragma mark - UITextView


#pragma mark - UIButton


#pragma mark - Timer
//创建定时器
+ (dispatch_source_t)GCDcreateTimerWithPeriod:(NSTimeInterval)period timerMianThreadBlock:(void(^)())block;

#pragma mark - CountDown
//创建倒计时
+ (dispatch_source_t)GCDcreateTimerWithCountDown:(NSTimeInterval)countDown period:(NSTimeInterval)period timerMianThreadBlock:(void(^)())block completeBlock:(void(^)())completeblock;

//销毁定时器
+ (void)invaliteTimer:(dispatch_source_t)timer;




@end
