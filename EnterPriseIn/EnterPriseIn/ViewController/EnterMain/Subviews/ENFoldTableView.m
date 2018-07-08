//
//  ENFoldTableView.m
//  CustomTable
//
//  Created by iOSDev on 2018/7/2.
//  Copyright © 2018年 berui.com. All rights reserved.
//

#import "ENFoldTableView.h"
#import "ENFoldTableViewCell.h"
#import "ENFoldHeaderModel.h"
#import "ENBranchModel.h"

@interface ENFoldTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *headerData;

//@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ENFoldTableView
{
    NSInteger _indexOfSection;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = ThemebgViewColor;
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[ENFoldTableViewCell class] forCellReuseIdentifier:@"ENFoldTableViewCell"];
    }
    return self;
}




- (void)setFoldTableViewHeaderData:(NSArray<ENFoldHeaderModel*>*)headerData {
    
    self.headerData = headerData;
    [self reloadData];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ENFoldHeaderModel *model = [self.headerData objectAtIndex:section];
    if (model.isShowCell) {
        return [model.subModel count];
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.headerData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ENFoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ENFoldTableViewCell"];
    if (!cell) {
        cell = [[ENFoldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ENFoldTableViewCell"];
        
    }
    ENFoldHeaderModel *model = [self.headerData objectAtIndex:indexPath.section];
    ENFoldHeaderModel *subModel = model.subModel[indexPath.row];
    cell.titleLabel.text = subModel.header_title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ENFoldTableViewCell *selecteCell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *cells = tableView.visibleCells;
    for (ENFoldTableViewCell *cell in cells) {
        if (![cell isEqual:selecteCell]) {
            cell.titleLabel.textColor = SubTitleColor;
            cell.tagView.backgroundColor = SubTitleColor;
        }
    }
    selecteCell.titleLabel.textColor = ThemeColor;
    selecteCell.tagView.backgroundColor = ThemeColor;
    
    if (_foldDelegate && [_foldDelegate respondsToSelector:@selector(ENFoldTableViewDidSelect:)]) {
        [_foldDelegate ENFoldTableViewDidSelect:indexPath];
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 200, 20)];
    ENFoldHeaderModel *model = [self.headerData objectAtIndex:section];
    titleLabel.text = model.header_title;
    titleLabel.textColor = MainTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spreadOrFoldCell:)];
    view.tag = 300 + section;
    [view addGestureRecognizer:tap];
    view.backgroundColor = ThemebgViewColor;
    if (model.isSelected) {
        view.backgroundColor = [UIColor whiteColor];
    }
    [view addSubview:titleLabel];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)spreadOrFoldCell:(UITapGestureRecognizer*)tap{
    NSInteger index = tap.view.tag-300;
    ENFoldHeaderModel *model = [self.headerData objectAtIndex:index];
    if (model.isShowCell == NO) {
        model.isShowCell = YES;
    }else{
         model.isShowCell = NO;
    }
    model.isSelected = YES;
    
    [self.headerData enumerateObjectsUsingBlock:^(ENFoldHeaderModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            obj.isSelected = NO;
            obj.isShowCell = NO;
        }
    }];
    
//    [self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    
//    NSRange range = NSMakeRange(0, self.headerData.count);
//    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//    [self reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationFade];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self reloadData];
    }];
    
    if (_foldDelegate && [_foldDelegate respondsToSelector:@selector(ENFoldTableViewDidSelectHeaderView:)]) {
        [_foldDelegate ENFoldTableViewDidSelectHeaderView:index];
    }
}



@end
