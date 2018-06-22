//
//  TTTabBarItem.h
//  BeruiHouse
//
//  Created by Ting on 2017/7/26.
//  Copyright © 2017年 Berui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TTTabBarItemType) {
	TTTabBarItemNormal = 0,
	TTTabBarItemImg,
};

extern NSString *const kLLTabBarItemAttributeTitle;// NSString
extern NSString *const kLLTabBarItemAttributeNormalImageName;// NSString
extern NSString *const kLLTabBarItemAttributeSelectedImageName;// NSString
extern NSString *const kLLTabBarItemAttributeType;// NSNumber, LLTabBarItemType

@interface TTTabBarItem : UIButton

+ (TTTabBarItem *)tabBarItemWithFrame:(CGRect)frame
                                title:(NSString *)title
                      normalImageName:(NSString *)normalImageName
                    selectedImageName:(NSString *)selectedImageName
                       tabBarItemType:(TTTabBarItemType)tabBarItemType;

@property (nonatomic, assign) TTTabBarItemType tabBarItemType;

@end

@interface TTTabBarItemModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, copy) NSString *selectedImageName;
@property (nonatomic, assign) TTTabBarItemType tabBarItemType;

+ (TTTabBarItemModel *)tabBarItemModelWithTitle:(NSString *)title
                                normalImageName:(NSString *)normalImageName
                              selectedImageName:(NSString *)selectedImageName
                                 tabBarItemType:(TTTabBarItemType)tabBarItemType;

@end
