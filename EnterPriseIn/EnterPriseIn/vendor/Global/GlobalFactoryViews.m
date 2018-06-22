//
//  GlobalFactoryViews.m
//  FirstHouse
//
//  Created by iOSDev on 2018/1/15.
//  Copyright © 2018年 Berui. All rights reserved.
//

#import "GlobalFactoryViews.h"

@implementation GlobalFactoryViews

#pragma mark - connerRadius
+ (void)LayerCornerRadius:(CALayer*)layer connerRadius:(CGFloat)radius{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
}

+ (void)LayerCornerRadius:(CALayer*)layer connerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor{
    layer.cornerRadius = radius;
    layer.borderWidth = borderWidth;
    layer.borderColor = borderColor.CGColor;
    layer.masksToBounds = YES;
}

#pragma mark - UILabel
+ (UILabel*)createLabelWithLabelText:(NSString*)text labelFont:(UIFont*)font textColor:(UIColor*)textColor textAligenment:(NSTextAlignment)textAlignment{
    
    UILabel * label = [UILabel new];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}

//带frame
+ (UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString*)text labelFont:(UIFont*)font textColor:(UIColor*)textColor textAligenment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}

#pragma mark - UIImageView
+ (UIImageView*)createImageView{
    UIImageView *imageView = [UIImageView new];
    return imageView;
}

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    return imageView;
}

#pragma mark - UITextField
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame placeHolder:(NSString*)placeholder font:(UIFont*)font textColor:(UIColor*)textColor placeholderColor:(UIColor*)placeholderColor{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.font = font;
    textField.textColor = textColor;
    
    return textField;
}

#pragma mark - UITextView


#pragma mark - UIButton


#pragma mark - Timer
//创建定时器
+ (dispatch_source_t)GCDcreateTimerWithPeriod:(NSTimeInterval)period timerMianThreadBlock:(void(^)())block{
    
    static dispatch_source_t _timer;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    // 事件回调
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
    // 开启定时器
    dispatch_resume(_timer);
    return _timer;
}

#pragma mark - CountDown
//创建倒计时
+ (dispatch_source_t)GCDcreateTimerWithCountDown:(NSTimeInterval)countDown period:(NSTimeInterval)period timerMianThreadBlock:(void(^)())block completeBlock:(void(^)())completeblock;{
    
    static dispatch_source_t _timer;
    __block int timeout = countDown; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),period*NSEC_PER_SEC, 0);//执行间隔
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                completeblock();
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    return _timer;
}

//销毁定时器
+ (void)invaliteTimer:(dispatch_source_t)timer{
    dispatch_source_cancel(timer);
}



@end
