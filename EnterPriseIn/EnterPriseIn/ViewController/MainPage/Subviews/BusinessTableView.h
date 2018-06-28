//
//  BusinessTableView.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusinessTableView;

@protocol BusinessTableViewDelegate <NSObject>

- (void)businessTableView:(BusinessTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end


@interface BusinessTableView : UITableView

@property (nonatomic,weak) id<BusinessTableViewDelegate> businessDelegate;

- (void)setBusinessInfo:(NSArray*)data haveSectionHeader:(BOOL)haveHeader;



@end
