//
//  ENPictureCollectionView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/27.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENPictureCollectionView.h"
#import "ENPictureCollectionViewCell.h"

@interface ENPictureCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *pictures;

@end

@implementation ENPictureCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    UICollectionViewFlowLayout * custonLayout = [[UICollectionViewFlowLayout alloc]init];
    custonLayout.itemSize = CGSizeMake(125, 80);
    custonLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    custonLayout.minimumLineSpacing = 10;
    custonLayout.minimumInteritemSpacing = 10;
    custonLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if (self = [super initWithFrame:frame collectionViewLayout:custonLayout]) {
        self.dataSource = self;
        self.delegate = self;
        self.decelerationRate = 10;
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[ENPictureCollectionViewCell class] forCellWithReuseIdentifier:@"ENPictureCollectionViewCell"];
    }
    return self;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;//self.pictures.count;
}
//返回每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ENPictureCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"ENPictureCollectionViewCell" forIndexPath:indexPath];
    [cell setImageUrl:@"http://img.berui.com/hefei/news/simg/2018/04/12/1523501837_945664.jpg"];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_pictureDelegate respondsToSelector:@selector(pictureCollectionView:didSelectItemAtIndexPath:)]) {
        [_pictureDelegate pictureCollectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return (CGSize){125,80};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}





@end
