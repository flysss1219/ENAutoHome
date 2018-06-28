//
//  ENPictureCollectionViewCell.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ENPictureCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *headImageView;

- (void)setImageUrl:(NSString*)url;

@end
