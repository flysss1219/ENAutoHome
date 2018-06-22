//
//  EmptyView.m
//  BeruiHouse
//
//  Created by app on 15/12/21.
//  Copyright © 2015年 wangyueyun. All rights reserved.
//

#import "EmptyView.h"
#import <Masonry.h>

@interface EmptyView()

@property(nonatomic,strong) UIImageView *emptyImageView;
@property(nonatomic,strong) UILabel *tipsLable;

@property(nonatomic,strong) UIButton *uniVersalBtn;
@property(nonatomic,assign)float unitHeight;
//  6.5 2 1 13

@end

@implementation EmptyView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.unitHeight = (frame.size.height - 100 - 12 - 36)/23;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.emptyImageView];
        [self addSubview:self.tipsLable];
        [self addSubview:self.uniVersalBtn];
        self.uniVersalBtn.hidden = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyViewTapped)]];

    }
    return self;
}

- (void)emptyViewTapped{
    if ([self.emptyViewDelegate respondsToSelector:@selector(tappedWithEmptyView:)]) {
        [self.emptyViewDelegate tappedWithEmptyView:self];
    }
}

- (void)getImageName:(NSString *)imageName  tipsName:(NSString *)tipsName  needBtn:(BOOL)needBtn btnName:(NSString *)btnName isPicNews:(BOOL)isPicNews{
    self.emptyImageView.image = [UIImage imageNamed:imageName];
    self.tipsLable.text = tipsName;
    [self.uniVersalBtn setTitle:btnName forState:UIControlStateNormal];
    if (needBtn) {
        self.uniVersalBtn.hidden = NO;
    }
    
    //图片详情
    if (isPicNews) {
        self.backgroundColor = [UIColor blackColor];
    }

}

#pragma mark

- (UIImageView *)emptyImageView{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenSize.width/2 - 50, self.unitHeight * 9, 100, 100)];

    }
    return _emptyImageView;
}

- (UILabel *)tipsLable{
    if (!_tipsLable) {
        _tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.emptyImageView.bottom + self.unitHeight * 2, ScreenSize.width, 12)];
        _tipsLable.textAlignment = NSTextAlignmentCenter;
        _tipsLable.font = [UIFont systemFontOfSize:12];
        _tipsLable.textColor = ViceTitleColor;

    }
    return _tipsLable;
}

- (UIButton *)uniVersalBtn{
    if (!_uniVersalBtn) {
        _uniVersalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _uniVersalBtn.frame = CGRectMake(self.width / 2 - 60, self.tipsLable.bottom + self.unitHeight, 120, 36);
        _uniVersalBtn.clipsToBounds = YES;
        _uniVersalBtn.layer.cornerRadius = 4;
        [_uniVersalBtn setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateNormal];
        _uniVersalBtn.backgroundColor = ThemeColor;
        [_uniVersalBtn addTarget:self action:@selector(uniVersalBtnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _uniVersalBtn;
}


- (void)uniVersalBtnClick{
    if ([self.emptyViewDelegate respondsToSelector:@selector(uniVersalBtnClickForEmptyView:)]) {
        [self.emptyViewDelegate uniVersalBtnClickForEmptyView:self];
    }

}


@end
