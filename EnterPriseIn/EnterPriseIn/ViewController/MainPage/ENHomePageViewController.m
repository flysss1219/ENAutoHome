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
#import "TSMarqueeView.h"
#import "LanguageLocalizableHelper.h"
#import <AFNetworking.h>
#import "ENHttp.h"
#import "AdInfo.h"
#import "ENBranchModel.h"
#import "NewsItem.h"

const CGFloat kBannerHeight = 200;

@interface ENHomePageViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UISearchBarDelegate,UITextFieldDelegate,TSMarqueeViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic, strong) MainBranchView *mainBranchView;

@property (nonatomic, strong) BusinessTableView *businessTableView;

@property (nonatomic, strong) UIView *marqueeNewsView;

@property (nonatomic, strong) TSMarqueeView *marqueeView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) UIButton  *languageButton;

@end

@implementation ENHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = LocalizableHelperGetStringWithKeyFromTable(@"AppName", nil);
    [self readyView];
    [self requestData];

}

- (void)readyView{
    
    [self addRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:self.languageButton]];
    
    
    
    self.view.backgroundColor = [UIColor colorWithHex:0xf4f4f4];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.bannerView];
    [self.mainScrollView addSubview:self.mainBranchView];
    [self.mainScrollView addSubview:self.searchBar];
    
    [self.mainScrollView addSubview:self.marqueeNewsView];
    [self.marqueeNewsView addSubview:self.marqueeView];
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

    [self.marqueeNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mainBranchView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
        make.height.mas_equalTo(50);
    }];
    
    [self.businessTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.marqueeNewsView.mas_bottom);
        make.left.equalTo(ws.mainScrollView.mas_left);
        make.width.mas_equalTo(KDeviceWidth);
    }];
    
}

- (void)requestData{
    
   
   __block  CGFloat  branchHeight;
    
    [ENHttp getENHomePageDataCompleteBlock:^(BOOL ok, NSString *message, NSArray *ads, NSArray *branchs, NSArray *hotNews) {
        if (ok) {
            NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *news = [NSMutableArray arrayWithCapacity:0];
            
            for (AdInfo *ad in ads) {
                [images addObject:ad.adContentUrl];
            }
            for (NewsItem *item in hotNews) {
                [news addObject:item.newsTitle];
            }
            self.bannerView.imageURLStringsGroup = images;
            
            branchHeight = [self.mainBranchView setHomePageMainBranchForData:branchs];
            
            [self.mainBranchView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(branchHeight);
            }];
            
            self.marqueeView.textDataArr = news;
            [self.marqueeView startScrollBottomToTopWithNoSpace];
            
            self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth,kBannerHeight+branchHeight+self.businessTableView.height+90);
            [self.view layoutIfNeeded];
        }
        
    }];
    
    [ENHttp getHomePageCoorporationListCompleteBlock:^(BOOL ok, NSString *message, NSArray *coorporationList) {
        if (ok) {
            [self.businessTableView setBusinessInfo:coorporationList haveSectionHeader:YES];

            [self.businessTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(coorporationList.count*100.0f+40);
            }];
            self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth,kBannerHeight+branchHeight+self.businessTableView.height+90);
            [self.view layoutIfNeeded];
        }
        
    }];
    
   
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
}

#pragma mark -- UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
}

- (void)changeAppLanguage:(UIButton*)sender{
    
    if ([LanguageLocalizableHelper shareInstance].currentLanguage == Language_zh_Hans) {
        [[LanguageLocalizableHelper shareInstance] changeLanguage:Language_en];
        [self makeToast:LocalizableHelperGetStringWithKeyFromTable(@"LanguageChangeSuccess", nil) duration:1.5];
    }else{
        [[LanguageLocalizableHelper shareInstance] changeLanguage:Language_zh_Hans];
        [self makeToast:LocalizableHelperGetStringWithKeyFromTable(@"LanguageChangeSuccess", nil) duration:1.5];
    }
    
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

- (UIView*)marqueeNewsView{
    if (!_marqueeNewsView) {
        _marqueeNewsView = [[UIView alloc]initWithFrame:CGRectZero];
        _marqueeNewsView.backgroundColor = ThemebgViewColor;
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 40)];
        bgImageView.image = [UIImage imageNamed:@"newsbg"];
        bgImageView.userInteractionEnabled = YES;
        [_marqueeNewsView addSubview:bgImageView];
        
        UIImageView *newsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12,50,15)];
        newsImageView.image = [UIImage imageNamed:@"news"];
        [_marqueeNewsView addSubview:newsImageView];
        
        
    }
    return _marqueeNewsView;
}

- (TSMarqueeView*)marqueeView{
    if (!_marqueeView) {
        _marqueeView = [[TSMarqueeView alloc]initWithFrame:CGRectMake(65, 10, KDeviceWidth-65, 20)];
        _marqueeView.delegate            = self;
        _marqueeView.textStayTime        = 2;
        _marqueeView.scrollAnimationTime = 1;
        _marqueeView.backgroundColor     = [UIColor clearColor];
        _marqueeView.textColor           = MainTitleColor;
        _marqueeView.textFont            = [UIFont systemFontOfSize:14.f];
        _marqueeView.touchEnable         = YES;
    }
    return _marqueeView;
}


- (UITextField*)searchField{
    if (!_searchField) {
        UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        titleTextField.layer.cornerRadius = 2.0f;//14.0f;
        titleTextField.placeholder = LocalizableHelperGetStringWithKeyFromTable(@"SearchKey", nil);
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

#pragma mark get/set
- (UIButton *)languageButton{
    if(!_languageButton){
        _languageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _languageButton.frame = CGRectMake(0, 0, 44, 44);
        
        if ([LanguageLocalizableHelper shareInstance].currentLanguage == Language_zh_Hans) {
            [_languageButton setImage:[UIImage imageNamed:@"chinese"] forState:UIControlStateNormal];
        }else{
            [_languageButton setImage:[UIImage imageNamed:@"A"] forState:UIControlStateNormal];
        }
        
        _languageButton.adjustsImageWhenHighlighted = NO;
        [_languageButton addTarget:self action:@selector(changeAppLanguage:) forControlEvents:UIControlEventTouchUpInside];
        if (IOS_VERSION >= 11) {
            _languageButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
            [_languageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0,0,-5)];
        }
    }
    return _languageButton;
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
