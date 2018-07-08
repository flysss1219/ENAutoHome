//
//  ENHeader.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#ifndef ENHeader_h
#define ENHeader_h

#define KDeviceWidth [UIScreen mainScreen].bounds.size.width

#define KDeviceHeight  [UIScreen mainScreen].bounds.size.height

#define kTabBarHeight  49
#define kNavigationBarHeight  64

#define ScreenSize [UIScreen mainScreen].bounds.size

//主色调
#define ThemeColor          [UIColor colorWithHexString:@"#4a72ff"]
#define ThemeHighColor      [UIColor colorWithHexString:@"#f55656"]

//视图背景色
#define ThemebgViewColor    [UIColor colorWithHexString:@"#eef1f8"]

//正文颜色
#define MainTitleColor      [UIColor colorWithHexString:@"#000000"]
//副文颜色
#define ViceTitleColor      [UIColor colorWithHexString:@"#000000"]
//标题
#define SubTitleColor       [UIColor colorWithHexString:@"#888888"]

//已读文本颜色
#define ReadTitleColor      [UIColor colorWithHexString:@"#999999"]
//标签文字颜色-灰
#define TagTitleColor       [UIColor colorWithHexString:@"#999999"]
//标签边框颜色-红
#define TagBorderRedColor   [UIColor colorWithHexString:@"#F4ABAC"]
//标签边框颜色-灰
#define TagBorderGrayColor  [UIColor colorWithHexString:@"#cccccc"]

//按钮边框颜色-红
#define ButtonBorderRedColor   [UIColor colorWithHexString:@"#ff9ba4"]
//按钮文字颜色-红
#define ButtonTextRedColor  [UIColor colorWithHexString:@"#f54343"]
//按钮背景颜色-红
#define ButtonBgRedColor  [UIColor colorWithHexString:@"#fff5f2"]

//按钮边框颜色-灰
#define ButtonBorderGrayColor   [UIColor colorWithHexString:@"#999999"]
//按钮文字颜色-灰
#define ButtonTextGrayColor  [UIColor colorWithHexString:@"#666666"]
//按钮背景颜色-灰
#define ButtonBgGrayColor  [UIColor colorWithHexString:@"#ffffff"]

//在售-背景颜色
#define SaleBgColor   [UIColor colorWithHexString:@"#faf4ee"]
//在售-文字颜色
#define SaleTextColor  [UIColor colorWithHexString:@"#ff8000"]
//待售-背景颜色
#define WillSaleBgColor  [UIColor colorWithHexString:@"#effaee"]
//待售-文字颜色
#define WillSaleTextColor   [UIColor colorWithHexString:@"#34bb19"]
//售完-背景颜色
#define SaleEndBgColor  [UIColor colorWithHexString:@"#f8f8f8"]
//售完-文字颜色
#define SaleEndTextColor  [UIColor colorWithHexString:@"#999999"]
//热销-背景颜色
#define HotSaleBgColor  [UIColor colorWithHexString:@"#fff5f2"]
//热销-文字颜色
#define HotSaleTextColor  [UIColor colorWithHexString:@"#f54343"]

#define bgViewColor  [UIColor colorWithHexString:@"#f4f4f4"]

//颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#import "UIColor+Hex.h"
#import "PureColorToImage.h"
#import "GlobalFunction.h"
#import "GlobalFactoryViews.h"
#import "SVProgressHUD.h"
#import "RTRootNavigationController.h"
#import "UIView+Size.h"
#import "YYKit.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "CurrentUser.h"
#endif /* ENHeader_h */
