//
//  ENHomePageViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHomePageViewController.h"
#import "SDCycleScrollView.h"
#import "BusinessTableView.h"
#import "MainBranchView.h"
#import <Masonry.h>

const CGFloat kBannerHeight = 200;

@interface ENHomePageViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic, strong) MainBranchView *mainBranchView;

@property (nonatomic, strong) BusinessTableView *businessTableView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITextField *searchField;

@end

@implementation ENHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"AppName", nil);
    
    [self readyView];
    [self requestData];

}

- (void)readyView{
    
    self.view.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.bannerView];
    [self.mainScrollView addSubview:self.mainBranchView];
    [self.mainScrollView addSubview:self.searchBar];
//    [self.mainScrollView addSubview:self.searchField];
    [self.mainScrollView addSubview:self.businessTableView];
    
    WS(ws);
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mainScrollView.mas_top);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(kBannerHeight);
    }];
    
    [self.mainBranchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.bannerView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.bannerView.mas_bottom).with.offset(-16);
        make.left.equalTo(ws.mainScrollView.mas_left).with.offset(15);
        make.width.mas_equalTo(KDeviceWidth-30);
        make.height.mas_equalTo(40);
    }];

    [self.businessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mainBranchView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
    }];
    
}

- (void)requestData{
    
    NSArray *images = @[@"http://img.berui.com/hefei/news/simg/2018/04/12/1523501837_945664.jpg",
                        @"http://img.berui.com/hefei/news/simg/2018/04/12/1523502931_923026.jpg",
                        @"http://img.berui.com/hefei/news/simg/2018/04/11/1523425875_218733.jpg"
                        ];
    self.bannerView.imageURLStringsGroup = images;
    
    CGFloat branchHeight = [self.mainBranchView setHomePageMainBranchForData:@[@"奥迪",@"宝马",@"奔驰",@"阿斯顿马丁",@"劳斯莱斯",@"别克",@"雪佛兰",@"雷克萨斯"]];
    [self.mainBranchView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(branchHeight);
    }];
    
    [self.businessTableView setBusinessInfo:nil haveSectionHeader:YES];
    [self.businessTableView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.height.mas_equalTo(5*100+40);
    }];
    
    
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth,kBannerHeight+branchHeight+self.businessTableView.height+40);
    
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}

#pragma mark -- UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
}

#pragma mark - getter
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth, KDeviceHeight-49-64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.scrollEnabled = YES;
    }
    return _mainScrollView;
}

- (SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,KDeviceWidth,kBannerHeight) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _bannerView.pageControlDotSize = CGSizeMake(8, 2);
        _bannerView.clipsToBounds = YES;
        _bannerView.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
        _bannerView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        _bannerView.pageDotColor = [UIColor lightGrayColor]; // 自定义分页控件小圆标颜色
        _bannerView.autoScrollTimeInterval = 5;
        _bannerView.autoScroll = YES;
        _bannerView.showPageControl = YES;
        _bannerView.pageControlBottomOffset = 20.0f;
        
    }
    return _bannerView;
}



- (MainBranchView*)mainBranchView{
    if (!_mainBranchView) {
        _mainBranchView = [[MainBranchView alloc]initWithFrame:CGRectMake(0, kBannerHeight, KDeviceWidth, 120)];
    }
    return _mainBranchView;
}

- (BusinessTableView*)businessTableView{
    if (!_businessTableView) {
        _businessTableView = [[BusinessTableView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth,500) style:UITableViewStylePlain];
        
    }
    return _businessTableView;
}

- (UITextField*)searchField{
    if (!_searchField) {
        UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        titleTextField.layer.cornerRadius = 2.0f;//14.0f;
        titleTextField.placeholder = @"搜索";
        titleTextField.delegate = self;
        titleTextField.font = [UIFont systemFontOfSize:13.0f];
        titleTextField.backgroundColor = [UIColor colorWithHex:0xffffff];
        titleTextField.textAlignment = NSTextAlignmentCenter;
        // "通过KVC修改占位文字的颜色"
        [titleTextField setValue:SubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        UIImageView *searchImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav_icon_search"]];
        searchImageView.frame = CGRectMake(10,0, 16.0f, 16.0f);
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 16)];
        [leftView addSubview:searchImageView];
        titleTextField.leftView = leftView;
        titleTextField.leftViewMode = UITextFieldViewModeAlways;
        
        titleTextField.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        titleTextField.rightViewMode = UITextFieldViewModeAlways;
        _searchField = titleTextField;
    }
    return _searchField;
}

- (UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15,20, KDeviceWidth-30,40)];
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
        _searchBar.placeholder = @"搜索";
        _searchBar.userInteractionEnabled = YES;
        _searchBar.delegate = self;
        _searchBar.enablesReturnKeyAutomatically = NO;
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
//        [searchField setValue:SubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        searchField.textColor = MainTitleColor;
        [_searchBar setBackgroundImage:[[UIImage alloc] init]];
        [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:ThemeColor];
        [self setSearchBarTextBackgroundColorWithSubViews:_searchBar.subviews];
        //加阴影
        _searchBar.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
        _searchBar.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _searchBar.layer.shadowOpacity = 0.2;//阴影透明度，默认0
        _searchBar.layer.shadowRadius = 2;//阴影半径，默认
    }
    return _searchBar;
}

- (void)setSearchBarTextBackgroundColorWithSubViews:(NSArray *)subviews{
    if(subviews.count>0){
        for (UIView *view in subviews) {
            NSArray *childSubviews = view.subviews;
            [self setSearchBarTextBackgroundColorWithSubViews:childSubviews];
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")] || [view isKindOfClass:[UITextField class]]) {
                view.backgroundColor = [UIColor whiteColor];
                break;
            }
        }
    }
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
