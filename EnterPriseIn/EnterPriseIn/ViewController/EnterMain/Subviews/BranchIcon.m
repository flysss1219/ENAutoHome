//
//  BranchIcon.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/21.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BranchIcon.h"
#import <UIImageView+WebCache.h>

@interface BranchIcon()

@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UILabel *iconLabel;

@property (nonatomic, strong) UIButton *iconButton;

@end

@implementation BranchIcon
{
    CGFloat _width;
    CGFloat _height;
}
- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString*)imageUrl andTitle:(NSString*)title{
    
    if (self = [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
        [self addSubview:self.iconImage];
        [self addSubview:self.iconLabel];
        [self addSubview:self.iconButton];
        
        self.iconLabel.text = title;
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"mrfl"]];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andImageStr:(NSString*)image title:(NSString*)title{
    
    if (self = [super initWithFrame:frame]) {
        _width = frame.size.width;
        _height = frame.size.height;
        [self addSubview:self.iconImage];
        [self addSubview:self.iconLabel];
        [self addSubview:self.iconButton];
        self.iconImage.frame = CGRectMake(_width/2-15,5, 30, 30);
        self.iconLabel.text = title;
        self.iconImage.image = [UIImage imageNamed:image];
    
    }
    return self;
    
}

- (void)iconDidSelect{
    if (_delegate && [_delegate respondsToSelector:@selector(branchIconDidSelect: andMenuId:)]) {
        [_delegate branchIconDidSelect:self.tag andMenuId:@""];
    }
}

#pragma mark - getter

- (UILabel*)iconLabel{
    if (!_iconLabel) {
        _iconLabel = [GlobalFactoryViews createLabelWithFrame:CGRectMake(0, _height-25, _width, 15) text:nil labelFont:[UIFont systemFontOfSize:12] textColor:ViceTitleColor textAligenment:1];
    }
    return _iconLabel;
}
- (UIImageView*)iconImage{
    if (!_iconImage) {
        _iconImage = [GlobalFactoryViews createImageViewWithFrame:CGRectMake(0, 0, _width, _width)];
        _iconImage.layer.cornerRadius = 2.0f;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}
- (UIButton*)iconButton{
    if (!_iconButton) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.backgroundColor = [UIColor clearColor];
        [_iconButton addTarget:self action:@selector(iconDidSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconButton;
}



@end
