//
//  TTTabBarItem.m
//  BeruiHouse
//
//  Created by Ting on 2017/7/26.
//  Copyright © 2017年 Berui. All rights reserved.
//

#import "TTTabBarItem.h"
#import "UIButton+WebCache.h"
#import <UIKit/UIKit.h>

@implementation TTTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)config {
    self.adjustsImageWhenHighlighted = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.tabBarItemType == TTTabBarItemNormal) {
        
        [self.titleLabel sizeToFit];
        CGSize titleSize = self.titleLabel.frame.size;
        
        CGSize imageSize = [self imageForState:UIControlStateNormal].size;
//        CGSize imageSize = CGSizeMake(20, 20);
        if (imageSize.width != 0 && imageSize.height != 0) {
            CGFloat imageViewCenterY = CGRectGetHeight(self.frame) - 3 - titleSize.height - imageSize.height / 2 - 7;
            self.imageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, imageViewCenterY);
        } else {
            CGPoint imageViewCenter = self.imageView.center;
            imageViewCenter.x = CGRectGetWidth(self.frame) / 2;
            imageViewCenter.y = (CGRectGetHeight(self.frame) - titleSize.height) / 2;
            self.imageView.center = imageViewCenter;
        }
        
        CGPoint labelCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - 3 - titleSize.height / 2);
        self.titleLabel.center = labelCenter;
        
        // 还有一种实现方式是设置 Edge Insets，Xcode 7.0.1 好像有点不开心，在 IB 里面更改一下属性的时候，经常崩溃。。。
        /* 位置还有一点不准确，推荐用上面的代码来设置
         
         [self.titleLabel sizeToFit];
         CGSize titleSize = self.titleLabel.frame.size;
         CGSize imageSize = [self imageForState:UIControlStateNormal].size;
         NSInteger titleTopInset = CGRectGetHeight(self.frame) - 3 - titleSize.height;
         CGFloat titleRightInset = (CGRectGetWidth(self.frame) - titleSize.width) / 2 + titleSize.width;
         [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTopInset, 0, 3, titleRightInset)];
         CGFloat imageViewLeftRightInset = (CGRectGetWidth(self.frame) - imageSize.width) / 2;
         [self setImageEdgeInsets:UIEdgeInsetsMake(CGRectGetHeight(self.frame) - 3 - 5 - titleSize.height - imageSize.height, imageViewLeftRightInset, 3 + 5 + titleSize.height, imageViewLeftRightInset)];
         
         */
    }
}

+ (TTTabBarItem *)tabBarItemWithFrame:(CGRect)frame
                                title:(NSString *)title
                      normalImageName:(NSString *)normalImageName
                    selectedImageName:(NSString *)selectedImageName
                       tabBarItemType:(TTTabBarItemType)tabBarItemType{
    
    TTTabBarItem *item = [[TTTabBarItem alloc] initWithFrame:frame];
    item.tabBarItemType = tabBarItemType;
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:10];
    [item setTitleColor:[UIColor colorWithHex:0x73777a] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

//    item.backgroundColor = ThemeColor;

    
    return item;
    
}

@end

@implementation TTTabBarItemModel

+ (TTTabBarItemModel *)tabBarItemModelWithTitle:(NSString *)title
                                normalImageName:(NSString *)normalImageName
                              selectedImageName:(NSString *)selectedImageName
                                 tabBarItemType:(TTTabBarItemType)tabBarItemType {
    
    TTTabBarItemModel *model = [TTTabBarItemModel new];
    model.title = title;
    model.normalImageName   = normalImageName;
    model.selectedImageName = selectedImageName;
    model.tabBarItemType    = tabBarItemType;
    
    return model;
}

@end


