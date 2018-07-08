//
//  BusinessListCell.h
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EnterpriseInfoModel;

@interface BusinessListCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;


- (void)setDataForCell:(EnterpriseInfoModel*)data;

@end
