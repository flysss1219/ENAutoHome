//
//  MainBranchView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "MainBranchView.h"
#import "BranchIcon.h"
#import "ENBranchModel.h"

const CGFloat kMianGap = 15.0f;

@interface MainBranchView()<BranchIconSelectDelegate>

@end

@implementation MainBranchView
{
    CGFloat _kBranchWidth;
    CGFloat _kBranchHeight;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _kBranchWidth = frame.size.width;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (CGFloat)setHomePageMainBranchForData:(NSArray*)data{
    
    CGFloat iconWidth = (_kBranchWidth - kMianGap*5)/4;
    _kBranchHeight = iconWidth+30;
    CGFloat y = 40;
    for (int i = 0; i<data.count; i++ ) {
        
        ENBranchModel *model = [data objectAtIndex:i];
        BranchIcon *icon = [[BranchIcon alloc]initWithFrame:CGRectMake(0, 0, iconWidth, _kBranchHeight) andImage:model.logo andTitle:model.branch_title];
        icon.delegate = self;
        icon.tag = 900+i;
        [self addSubview:icon];

        int row = i/4;
        int cloum = i%4;
        icon.frame = CGRectMake(kMianGap+(iconWidth+kMianGap)*cloum,y+row*(_kBranchHeight),iconWidth,_kBranchHeight);
    }
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, y+ _kBranchHeight*((data.count+3)/4)-0.5, _kBranchWidth, 0.5)];
//    line.backgroundColor = [UIColor colorWithHex:0xe5e5e5];
//    [self addSubview:line];
    
    return  y+_kBranchHeight*((data.count+3)/4);
}

#pragma mark -BranchIconSelectDelegate
- (void)branchIconDidSelect:(NSInteger)index{
    
    
}



@end
