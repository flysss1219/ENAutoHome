//
//  ENPictureCollectionView.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ENPictureCollectionView;

@protocol ENPictureCollectionViewDelegate <NSObject>

- (void)pictureCollectionView:(ENPictureCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface ENPictureCollectionView : UICollectionView

@property (nonatomic,weak) id<ENPictureCollectionViewDelegate> pictureDelegate;

- (void)setPictures:(NSArray*)pictures;


@end
