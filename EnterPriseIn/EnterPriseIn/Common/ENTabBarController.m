//
//  ENTabBarController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENTabBarController.h"
#import "AppDelegate.h"
#import "AFNetworkReachabilityManager.h"
#import "TTTabBarItem.h"
#import <Masonry.h>
#import "RTRootNavigationController.h"

#import "ENNewsMainViewController.h"
#import "ENHomePageViewController.h"
#import "ENEnterViewController.h"
#import "ENEnterpriseViewController.h"
#import "ENPersonViewController.h"


#define  imageBtnWidth 70
#define  imageBtnDistance (ScreenSize.width - imageBtnWidth * 3)/4

@interface ENTabBarController ()<UINavigationControllerDelegate>
@property (strong,nonatomic) UIView *tabbarView;
@property (assign,nonatomic) NSInteger currentSelectedIndex;
@property (strong,nonatomic) NSMutableArray *tabBarItems;

@property (strong,nonatomic) RTRootNavigationController *mainNavController;
@property (strong,nonatomic) RTRootNavigationController *newsNavController;
@property (strong,nonatomic) RTRootNavigationController *enterPriseNavController;
@property (strong,nonatomic) RTRootNavigationController *enterNavController;
@property (strong,nonatomic) RTRootNavigationController *personalNavController;


@end

@implementation ENTabBarController

//自动生成setter getter方法
@synthesize tabBarDelegate = _tabBarDelegate;

- (instancetype)init{
    self = [super init];
    if(self){
        self.delegate = self;
        [[UITabBar appearance] setShadowImage:[UIImage new]];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tabBar.backgroundImage = [PureColorToImage imageWithColor:[UIColor whiteColor] andWidth:10.0f andHeight:10.0f];
    self.tabBar.clipsToBounds = NO;
    [self.tabBar addSubview:self.tabbarView];
    

    [self layOutViewControllers];
    
}

- (void)layOutViewControllers{
    
//    WS(ws);
    [self.tabbarView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *arrays = [NSMutableArray new];
    
    [arrays addObject:self.mainNavController];
    [arrays addObject:self.enterNavController];
    [arrays addObject:self.newsNavController];
    [arrays addObject:self.enterPriseNavController];
    [arrays addObject:self.personalNavController];
    
    self.viewControllers = [arrays copy];
    
    CGFloat itemWidth = KDeviceWidth/5;
    
    CGFloat tabBarHeight = CGRectGetHeight(self.tabBar.bounds);
    float tag = 0;
    
    self.tabBarItems = [NSMutableArray new];
    
    TTTabBarItem *tabBarItem1 = [TTTabBarItem tabBarItemWithFrame:CGRectMake(tag*itemWidth, 0, itemWidth, tabBarHeight) title:LocalizableHelperGetStringWithKeyFromTable(@"TabBarHomePageName", nil) normalImageName:@"sy" selectedImageName:@"sy_sel" tabBarItemType:TTTabBarItemNormal];
    [tabBarItem1 addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItems addObject:tabBarItem1];
    [self.tabbarView addSubview:tabBarItem1];
    tabBarItem1.tag = tag;
    tag += 1;
    
    
    TTTabBarItem *tabBarItem2 = [TTTabBarItem tabBarItemWithFrame:CGRectMake(tag*itemWidth, 0, itemWidth, tabBarHeight) title:LocalizableHelperGetStringWithKeyFromTable(@"TabBarHomeBranch", nil) normalImageName:@"fl" selectedImageName:@"fl_sel" tabBarItemType:TTTabBarItemNormal];
    [tabBarItem2 addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItems addObject:tabBarItem2];
    [self.tabbarView addSubview:tabBarItem2];
    tabBarItem2.tag = tag;
    tag += 1;
    
    TTTabBarItem *tabBarItem3 = [TTTabBarItem tabBarItemWithFrame:CGRectMake(tag*itemWidth, 0, itemWidth, tabBarHeight) title:LocalizableHelperGetStringWithKeyFromTable(@"TabBarHomeNews", nil) normalImageName:@"zx" selectedImageName:@"zx_sel" tabBarItemType:TTTabBarItemNormal];
    [tabBarItem3 addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItems addObject:tabBarItem3];
    [self.tabbarView addSubview:tabBarItem3];
    tabBarItem3.tag = tag;
    tag += 1;
    
    
    TTTabBarItem *tabBarItem4 = [TTTabBarItem tabBarItemWithFrame:CGRectMake(tag*itemWidth, 0, itemWidth, tabBarHeight) title:LocalizableHelperGetStringWithKeyFromTable(@"TabBarHomeEnter", nil) normalImageName:@"rz" selectedImageName:@"rz_sel" tabBarItemType:TTTabBarItemNormal];
    [tabBarItem4 addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBarItems addObject:tabBarItem4];
    [self.tabbarView addSubview:tabBarItem4];
    tabBarItem4.tag = tag;
    tag += 1;
    
    TTTabBarItem *tabBarItem5 = [TTTabBarItem tabBarItemWithFrame:CGRectMake(tag*itemWidth, 0, itemWidth, tabBarHeight) title:LocalizableHelperGetStringWithKeyFromTable(@"TabBarHomePerson", nil) normalImageName:@"mine" selectedImageName:@"mine_sel" tabBarItemType:TTTabBarItemNormal];
    [tabBarItem5 addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarItems addObject:tabBarItem5];
    [self.tabbarView addSubview:tabBarItem5];
    tabBarItem5.tag = tag;
    
    _currentSelectedIndex = 0;
//    TTTabBarItem *tabBarItem = [self.tabBarItems objectAtIndex:_currentSelectedIndex];;
//    tabBarItem.selected = YES;
    [self tabBarSelectAtIndex:_currentSelectedIndex];
    [self.tabBar bringSubviewToFront:self.tabbarView];
}


- (void)itemSelected:(TTTabBarItem *)sender {
    [self tabBarSelectAtIndex:sender.tag];
}

#pragma mark -- UINavigationControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.tabBarDelegate performSelector:@selector(tabBarController:didSelectViewController:)];
    }
}

#pragma mark - pubilc methods
- (void)tabBarSelectAtIndex:(NSInteger )index{
    for (TTTabBarItem *item in self.tabBarItems) {
        if (item.tag == index) {
            item.selected = YES;
            item.backgroundColor = [UIColor colorWithHex:0x4a72ff];
        } else {
            item.selected = NO;
            item.backgroundColor = [UIColor whiteColor];
        }
    }
    self.selectedIndex = index;
    _currentSelectedIndex = index;
}
// 是否显示未读消息小红点
- (void)showMessagePointView:(BOOL)showPointView{
    
}

- (void)showTabBarItemWithIndex:(NSInteger )index{
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (UIInterfaceOrientationPortrait==interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getter
- (RTRootNavigationController *)mainNavController {
    if (!_mainNavController) {
        ENHomePageViewController* main = [[ENHomePageViewController alloc] init];
        _mainNavController = [[RTRootNavigationController alloc] initWithRootViewController:main];
        _mainNavController.navigationBar.barTintColor = [UIColor colorWithHex:0xffffff];
        _mainNavController.delegate = self;
    }
    return _mainNavController;
}

- (RTRootNavigationController *)enterNavController {
    if (!_enterNavController) {
        ENEnterViewController *enter = [[ENEnterViewController alloc] init];
        _enterNavController = [[RTRootNavigationController alloc] initWithRootViewController:enter];
        _enterNavController.delegate = self;
        _enterNavController.navigationBar.barTintColor = [UIColor colorWithHex:0xffffff];
    }
    return _enterNavController;
}

- (RTRootNavigationController *)newsNavController {
    if (!_newsNavController) {
        ENNewsMainViewController *news = [[ENNewsMainViewController alloc] init];
        _newsNavController = [[RTRootNavigationController alloc] initWithRootViewController:news];
        _newsNavController.navigationBar.barTintColor = [UIColor colorWithHex:0xffffff];
        _newsNavController.delegate = self;
    }
    return _newsNavController;
}

- (RTRootNavigationController *)enterPriseNavController {
    if (!_enterPriseNavController) {
        ENEnterpriseViewController *enterprise = [[ENEnterpriseViewController alloc]init];
        _enterPriseNavController  = [[RTRootNavigationController alloc] initWithRootViewController:enterprise];
        _enterPriseNavController.navigationBar.barTintColor = [UIColor colorWithHex:0xffffff];
        _enterPriseNavController.delegate = self;
    }
    return _enterPriseNavController;
}

- (RTRootNavigationController *)personalNavController {
    if (!_personalNavController) {
        ENPersonViewController *enterprise = [[ENPersonViewController alloc]init];
        _personalNavController  = [[RTRootNavigationController alloc] initWithRootViewController:enterprise];
        _personalNavController.navigationBar.barTintColor = [UIColor colorWithHex:0xffffff];
        _personalNavController.delegate = self;
    }
    return _personalNavController;
}

- (UIView *)tabbarView {
    if (!_tabbarView) {
        
        _tabbarView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, self.tabBar.bounds);
        _tabbarView.layer.shadowPath = path;
        CGPathCloseSubpath(path);
        CGPathRelease(path);
        
        _tabbarView.layer.shadowColor = [UIColor grayColor].CGColor;
        _tabbarView.layer.shadowOffset = CGSizeMake(0, -3.0);
        _tabbarView.layer.shadowRadius = 1;
        _tabbarView.layer.shadowOpacity = 0.1;
        
        _tabbarView.clipsToBounds = NO;
    }
    
    return _tabbarView;
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
