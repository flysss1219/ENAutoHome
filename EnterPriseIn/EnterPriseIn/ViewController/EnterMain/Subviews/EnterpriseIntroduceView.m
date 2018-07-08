//
//  EnterpriseIntroduceView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/29.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "EnterpriseIntroduceView.h"


@interface EnterpriseIntroduceView()

@property (nonatomic, strong) YYLabel *textContentLabel;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UIView   *tagView;

@property (nonatomic, strong) UIView   *gapView;


@end


@implementation EnterpriseIntroduceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.gapView];
        [self addSubview:self.tagView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textContentLabel];
        
    }
    return self;
}


- (CGFloat)setEnterpriseIntroduce:(NSString*)introduce{
 
    
//    self.textContentLabel.text = introduce;
    self.textContentLabel.text = @"他曾带头赤脚站在冰中修筑淤地坝，他曾带领干部两天接待逾700位来访群众，当场拍板、限期解决近200件问题。他说，“心中没有群众，就不配再做共产党员”。他禁止亲朋好友打他的旗号办任何事，自己考察调研常常住普通房、吃家常菜。他说，“党内不允许有不受纪律约束的特殊党员”。他亲上火线主导改革，砸开了一个个以前不敢想、不敢碰、不敢啃的“硬骨头”。他说，改革开放“是党和人民事业大踏步赶上时代的重要法宝”。他就是习近平，一名有44年党龄的共产党员。“七一”党的生日之际，让我们重温习近平入党以来的一言一行，向这位不忘初心的共产党员学习致敬";
    
    CGFloat viewHeight;
    viewHeight = [GlobalFunction ts_textHeight:self.textContentLabel.text textFont:[UIFont systemFontOfSize:15] textMaxWidth:KDeviceWidth-20];
    self.textContentLabel.frame = CGRectMake(10, 50, KDeviceWidth-20, viewHeight);
    return viewHeight+50.f;
}

- (YYLabel*)textContentLabel{
    if (!_textContentLabel) {
        _textContentLabel = [[YYLabel alloc]initWithFrame:CGRectMake(10, 50, KDeviceWidth-20, 0)];
        _textContentLabel.numberOfLines = 0;
        _textContentLabel.font = [UIFont systemFontOfSize:15];
        _textContentLabel.textColor = ViceTitleColor;
        _textContentLabel.displaysAsynchronously = YES;
    }
    return _textContentLabel;
}


- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [GlobalFactoryViews createLabelWithFrame:CGRectMake(30,25,120, 15) text:LocalizableHelperGetStringWithKeyFromTable(@"HomePageTableHeader", nil) labelFont:[UIFont systemFontOfSize:13] textColor:ViceTitleColor textAligenment:0];
    }
    return _titleLabel;
}

- (UIView*)tagView{
    
    if (!_tagView) {
        _tagView = [[UIView alloc]initWithFrame:CGRectMake(17,26,3,13)];
        _tagView.backgroundColor = ThemeColor;
    }
    return _tagView;
}
- (UIView*)gapView{
    
    if (!_gapView) {
        _gapView = [[UIView alloc]initWithFrame:CGRectMake(0,0,KDeviceWidth,10)];
        _gapView.backgroundColor = ThemebgViewColor;
    }
    return _gapView;
}

@end
