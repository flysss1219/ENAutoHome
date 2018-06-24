//
//  ENShareAppView.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/24.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENShareAppView.h"
#import "BranchIcon.h"

@interface ENShareAppView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ENShareAppView
{
    NSArray *_imagesArr;
    NSArray *_titlesArr;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

- (void)makeUI{
    
    _imagesArr = @[
                   @"wechat",
                   @"pyq.png",
                   @"qq",
                   @"whatsapp"
                   ];
    _titlesArr = @[
                   NSLocalizedString(@"WechatFriends", nil),
                   NSLocalizedString(@"WechatSpace", nil),
                   NSLocalizedString(@"QQFriends", nil),
                   NSLocalizedString(@"WhatsApp", nil),
                   ];
    
    [self addSubview:self.titleLabel];
    
    CGFloat y = 20;
    CGFloat x = 17.5;
    CGFloat width = (KDeviceWidth-35-20*3)/4;
    CGFloat height = width+40
    for (int i = 0; i< 4; i++) {
//        BranchIcon *icon = [BranchIcon alloc]initWithFrame:CGRectMake(x,y, <#CGFloat width#>, <#CGFloat height#>) andImageStr:<#(NSString *)#> title:<#(NSString *)#>
        
    }
}


- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [GlobalFactoryViews createLabelWithFrame:CGRectMake(17.5,15,KDeviceWidth-35, 15) text:NSLocalizedString(@"ShareApp", nil) labelFont:[UIFont systemFontOfSize:14] textColor:ViceTitleColor textAligenment:0];
    }
    return _titleLabel;
}




@end
