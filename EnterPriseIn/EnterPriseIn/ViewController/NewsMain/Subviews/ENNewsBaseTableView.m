//
//  ENNewsBaseTableView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENNewsBaseTableView.h"
#import "NewsSmallImageCell.h"
#import "NewsItem.h"
@interface ENNewsBaseTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   NSMutableArray  *dataSourceArray;

@property (nonatomic, copy)     NSString        *keyword;

@end


@implementation ENNewsBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self readView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self readView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self readView];
    }
    return self;
}
- (void)readView {
    
    [self registerNib:[UINib nibWithNibName:@"NewsSmallImageCell" bundle:nil] forCellReuseIdentifier:@"NewsSmallImageCell"];
    self.delegate = self;
    self.dataSource = self;
    
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100; // 设置为一个接近“平均”行高的值
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)reloadTableVieWithDataSourceArray:(NSMutableArray<NewsItem *>*)dataSourceArray withKeyWord:(NSString *)keyword
{
    self.dataSourceArray = dataSourceArray;
    _keyword = keyword;
    [self reloadData];
    [self layoutIfNeeded];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(numberOfSectionsInNewsItemBaseTableView:)]){
        return [self.newsItemBaseTableViewDelegate numberOfSectionsInNewsItemBaseTableView:tableView];
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:numberOfRowsInSection:)]){
        return [self.newsItemBaseTableViewDelegate newsItemBaseTableView:tableView numberOfRowsInSection:section];
    }else {
        return self.dataSourceArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:heightForHeaderInSection:)]){
        return [self.newsItemBaseTableViewDelegate newsItemBaseTableView:tableView heightForHeaderInSection:section];
    }else {
        return 0.1f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:heightForFooterInSection:)]){
        return [self.newsItemBaseTableViewDelegate newsItemBaseTableView:tableView heightForFooterInSection:section];
    }else {
        return 0.1f;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:viewForHeaderInSection:)]){
        return [self.newsItemBaseTableViewDelegate newsItemBaseTableView:tableView viewForHeaderInSection:section];
    }else {
        return [UIView new];
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:viewForFooterInSection:)]){
        return [self.newsItemBaseTableViewDelegate newsItemBaseTableView:tableView viewForFooterInSection:section];
    }else {
        return [UIView new];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsItem *item;
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(objectInIndexPath:)]) {
        item = [self.newsItemBaseTableViewDelegate objectInIndexPath:indexPath];
    }else {
        item = [self.dataSourceArray objectAtIndex:indexPath.row];
    }
    NewsSmallImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsSmallImageCell" forIndexPath:indexPath];
//    cell.keyword = self.keyword;
//    [cell setNewsItem:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsItem *item;
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(objectInIndexPath:)]) {
        item = [self.newsItemBaseTableViewDelegate objectInIndexPath:indexPath];
    }else {
        item = self.dataSourceArray[indexPath.row];
    }
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:didSelectRowAtIndexPath:)]){
        [self.newsItemBaseTableViewDelegate newsItemBaseTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:canEditRowAtIndexPath:)]){
        return [self.newsItemBaseTableViewDelegate newsItemBaseTableView:self canEditRowAtIndexPath:indexPath];
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.newsItemBaseTableViewDelegate && [self.newsItemBaseTableViewDelegate respondsToSelector:@selector(newsItemBaseTableView:commitEditingStyle:forRowAtIndexPath:)]){
        [self.newsItemBaseTableViewDelegate newsItemBaseTableView:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray new];
    }
    return _dataSourceArray;
}

@end
