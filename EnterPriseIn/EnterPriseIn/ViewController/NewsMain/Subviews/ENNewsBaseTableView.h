//
//  ENNewsBaseTableView.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ENNewsBaseTableView;
@class NewsItem;

@protocol ENNewsBaseTableViewDelegate <NSObject>

- (void)newsItemBaseTableView:(ENNewsBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat)newsItemBaseTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)newsItemBaseTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView *)newsItemBaseTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)newsItemBaseTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInNewsItemBaseTableView:(UITableView *)tableView;
- (NSInteger)newsItemBaseTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NewsItem *)objectInIndexPath:(NSIndexPath *)indexPath;

@end


@interface ENNewsBaseTableView : UITableView

@property (nonatomic,weak) id<ENNewsBaseTableViewDelegate> newsItemBaseTableViewDelegate;
@end
