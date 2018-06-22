//
//  BranchScrollView.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/21.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "BranchScrollView.h"

const CGFloat btnHeight = 50.f;

@implementation BranchScrollView
{
    CGFloat _kWidth;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _kWidth = frame.size.width;
        self.backgroundColor = [UIColor colorWithHex:0xeef1f8];
    }
    return self;
}

- (CGFloat)setBranchScrollViewForData:(NSArray*)data{
    
    
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, btnHeight*idx, _kWidth, btnHeight)];
        label.textColor = SubTitleColor;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBranch:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
        label.backgroundColor = [UIColor colorWithHex:0xeef1f8];
        [self addSubview:label];
        if (idx == 0) {
            label.backgroundColor = [UIColor whiteColor];
            label.textColor = ViceTitleColor;
        }

        NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
        paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
        paraStyle01.headIndent = 0.0f;//行首缩进
        //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
        CGFloat emptylen = label.font.pointSize;
        paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
        paraStyle01.tailIndent = 0.0f;//行尾缩进
        paraStyle01.lineSpacing = 2.0f;//行间距
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:obj attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
        label.attributedText = attrText;
        
    }];
    return data.count*btnHeight;
}

- (void)selectBranch:(UITapGestureRecognizer*)tap{
    
    UILabel *label = (UILabel*)tap.view;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = ViceTitleColor;
    
    for (UILabel *obj in self.subviews) {
        if (obj != label) {
            obj.backgroundColor = [UIColor colorWithHex:0xeef1f8];
            obj.textColor = SubTitleColor;
        }
    }
    
}

@end
