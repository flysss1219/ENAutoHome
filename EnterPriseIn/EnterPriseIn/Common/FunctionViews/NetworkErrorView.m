//
//  NetworkErrorView.m
//  FirstHouse
//
//  Created by Ting on 2017/8/4.
//  Copyright © 2017年 Berui. All rights reserved.
//

#import "NetworkErrorView.h"

@implementation NetworkErrorView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionWithClick)];
    [self addGestureRecognizer:tap];
    
    self.resolveButton.layer.cornerRadius = 2.0f;
    self.resolveButton.layer.borderColor = [UIColor colorWithHex:0x73777a].CGColor;
    self.resolveButton.layer.borderWidth  = 0.5f;
    self.resolveButton.layer.masksToBounds = YES;
    
    self.resolveButton.hidden = YES;
    
}

- (void)showResolveView{
    
    self.resolveButton.hidden = NO;
    
    
}

- (IBAction)checkResolveMethod:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(checkNetworkErrorResolve)]) {
        [self.delegate checkNetworkErrorResolve];
    }
}

- (void)actionWithClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadWithNetworkErrorView:)]) {
        [self.delegate reloadWithNetworkErrorView:self];
        [SVProgressHUD show];
    }
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [SVProgressHUD dismiss];

}

@end
