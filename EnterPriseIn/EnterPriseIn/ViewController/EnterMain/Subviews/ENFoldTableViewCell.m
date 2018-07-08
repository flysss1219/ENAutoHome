//
//  ENFoldTableViewCell.m
//  CustomTable
//
//  Created by iOSDev on 2018/7/2.
//  Copyright © 2018年 berui.com. All rights reserved.
//

#import "ENFoldTableViewCell.h"

@implementation ENFoldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.titleLabel];
        
        self.tagView.frame = CGRectMake(10,19, 6, 6);
        self.titleLabel.frame = CGRectMake(20,0,80,44);
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}


- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = SubTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView*)tagView{
    if (!_tagView) {
        _tagView = [UIView new];
        _tagView.layer.cornerRadius = 4;
        _tagView.layer.masksToBounds = YES;
        _tagView.backgroundColor = SubTitleColor;
    }
    return _tagView;
}

@end
