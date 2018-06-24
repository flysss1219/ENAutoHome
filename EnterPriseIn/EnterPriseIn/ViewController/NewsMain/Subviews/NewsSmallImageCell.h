//
//  NewsSmallImageCell.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsItem;

@interface NewsSmallImageCell : UITableViewCell

@property (nonatomic,copy) NSString *keyword;
@property (nonatomic,weak) NewsItem *newsItem;


@end
