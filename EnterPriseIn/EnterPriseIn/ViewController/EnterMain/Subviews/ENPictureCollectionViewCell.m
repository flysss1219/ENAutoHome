//
//  ENPictureCollectionViewCell.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENPictureCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ENPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         [self.contentView addSubview:self.headImageView];
    }
    return self;
}

- (void)setImageUrl:(NSString*)url{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:url]];
}

#pragma mark -  getter
- (UIImageView*)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}
@end
