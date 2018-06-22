//
//  BusinessListCell.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/22.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BusinessListCell.h"
#import <UIImageView+WebCache.h>

@implementation BusinessListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataForCell:(id)data{
    
    self.titleLabel.text = @"苏州园林拙政园";
    self.tagLabel.text = @"100点击率";
    self.addressLabel.text = @"苏州市-观前街-松涛路";
    
}
@end
