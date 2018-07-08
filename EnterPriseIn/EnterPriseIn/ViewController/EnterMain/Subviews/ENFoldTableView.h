//
//  ENFoldTableView.h
//  CustomTable
//
//  Created by iOSDev on 2018/7/2.
//  Copyright © 2018年 berui.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ENFoldHeaderModel;


@class ENFoldTableView;
@protocol ENFoldTableViewDelegate<NSObject>

- (void)ENFoldTableViewDidSelect:(NSIndexPath*)indexpath;

- (void)ENFoldTableViewDidSelectHeaderView:(NSInteger)indexpath;

@end

@interface ENFoldTableView : UITableView


@property (nonatomic, weak) id <ENFoldTableViewDelegate> foldDelegate;
- (void)setFoldTableViewHeaderData:(NSArray<ENFoldHeaderModel*>*)headerData;

@end
