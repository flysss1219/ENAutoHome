//
//  RotateViewController.m
//  CustomTable
//
//  Created by iOSDev on 2018/7/2.
//  Copyright © 2018年 berui.com. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation RotateViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"×" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeBack) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20,20,50,50);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.titleLabel];
    self.titleLabel.text = @"七一建党节快乐！";
    
    self.titleLabel.frame = CGRectMake(15, 20,screen_height-100, 60);
    self.titleLabel.center = CGPointMake(screen_width/2+50, screen_height/2+20);
    self.titleLabel.transform = CGAffineTransformMakeRotation(M_PI/2+M_PI);
    
    
}


- (void)closeBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:50];
        _titleLabel.backgroundColor = [UIColor purpleColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
