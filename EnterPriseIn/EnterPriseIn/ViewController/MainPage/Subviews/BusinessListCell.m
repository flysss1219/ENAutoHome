//
//  BusinessListCell.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BusinessListCell.h"
#import <UIImageView+WebCache.h>
#import "EnterpriseInfoModel.h"

@implementation BusinessListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataForCell:(EnterpriseInfoModel*)data{
    
    self.titleLabel.text = data.company_title;
    self.tagLabel.text = [NSString stringWithFormat:@"%@点击率",data.company_hits];
    self.addressLabel.text = data.company_address;
    if (data.is_vip) {
        self.levelImageView.hidden = NO;
    }else{
        self.levelImageView.hidden = YES;
    }
}
@end
