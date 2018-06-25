//
//  CarBranchView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/21.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "CarBranchView.h"
#import "BranchIcon.h"


const CGFloat kBranchGap = 15.0f;

@interface CarBranchView()<BranchIconSelectDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *tagView;

@end

@implementation CarBranchView
{
    CGFloat _kBranchWidth;
    CGFloat _kBranchHeight;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tagView];
        [self addSubview:self.titleLabel];
        _kBranchWidth = frame.size.width;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (CGFloat)setCarBranchForData:(NSArray*)data andBranchTitle:(NSString*)title andInitTag:(NSInteger)tag{
    
    self.titleLabel.text = title;
    CGFloat iconWidth = (_kBranchWidth - kBranchGap*4)/3;
    _kBranchHeight = iconWidth+30.0f;
    CGFloat y = 40.0f;
    for (int i = 0; i<data.count ; i++ ) {
        BranchIcon *icon = [[BranchIcon alloc]initWithFrame:CGRectMake(0, 0, iconWidth, _kBranchHeight) andImage:nil andTitle:data[i]];
        icon.delegate = self;
        icon.tag = tag+i;
        [self addSubview:icon];
        
        int row = i/3;
        int cloum = i%3;
        icon.frame = CGRectMake(kBranchGap+(iconWidth+kBranchGap)*cloum,y+row*(_kBranchHeight),iconWidth,_kBranchHeight);
    }
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, y+ _kBranchHeight*((data.count+2)/3)-0.5, _kBranchWidth, 0.5)];
//    line.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
//    [self addSubview:line];
    
    return y+_kBranchHeight*((data.count+2)/3);
}

#pragma mark -BranchIconSelectDelegate
- (void)branchIconDidSelect:(NSInteger)index andMenuId:(NSString *)menuId{
    if (_menuDelegate && [_menuDelegate respondsToSelector:@selector(carBranchViewDidSelect:andMenuId:)]) {
        [_menuDelegate carBranchViewDidSelect:index andMenuId:menuId];
    }
    
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [GlobalFactoryViews createLabelWithFrame:CGRectMake(30,10,120, 15) text:NSLocalizedString(@"TabBarHomeBranch", nil) labelFont:[UIFont systemFontOfSize:13] textColor:ViceTitleColor textAligenment:0];
    }
    return _titleLabel;
}

- (UIView*)tagView{

    if (!_tagView) {
        _tagView = [[UIView alloc]initWithFrame:CGRectMake(17,10,3,13)];
        _tagView.backgroundColor = ThemeColor;
    }
    return _tagView;
}

    


@end
