//
//  BusinessTableView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BusinessTableView.h"
#import "BusinessListCell.h"
#import "EnterpriseInfoModel.h"

@interface BusinessTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray  *data;

@property (nonatomic, assign) BOOL     haveHeader;

@property (nonatomic, strong) UIView   *headerView;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UIView   *tagView;

@end

@implementation BusinessTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = 100.0f;
        [self registerNib:[UINib nibWithNibName:@"BusinessListCell" bundle:nil] forCellReuseIdentifier:@"BusinessListCell"];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
    }
    return self;
}

- (void)setBusinessInfo:(NSArray*)data haveSectionHeader:(BOOL)haveHeader{
    self.data = data;
    if (haveHeader) {
        [self.headerView addSubview:self.tagView];
        [self.headerView addSubview:self.titleLabel];
        self.tableHeaderView = self.headerView;
    }
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessListCell"];
    if (cell == nil) {
         cell = [[BusinessListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BusinessListCell"];
    }
    EnterpriseInfoModel *model = [self.data objectAtIndex:indexPath.row];
    [cell setDataForCell:model];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_businessDelegate && [_businessDelegate respondsToSelector:@selector(businessTableView:didSelectRowAtIndexPath:)]) {
        [_businessDelegate businessTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (UIView*)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 40)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {

        _titleLabel = [GlobalFactoryViews createLabelWithFrame:CGRectMake(30,15,120, 15) text:LocalizableHelperGetStringWithKeyFromTable(@"HomePageTableHeader", nil) labelFont:[UIFont systemFontOfSize:13] textColor:ViceTitleColor textAligenment:0];
    }
    return _titleLabel;
}

- (UIView*)tagView{
    
    if (!_tagView) {
        _tagView = [[UIView alloc]initWithFrame:CGRectMake(17,16,3,13)];
        _tagView.backgroundColor = ThemeColor;
    }
    return _tagView;
}


@end
