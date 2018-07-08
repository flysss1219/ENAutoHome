//
//  ENEnterViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/6/9.
//  Copyright © 2018年 com.shun. All rights reserved.
// 分类

#import "ENEnterViewController.h"
#import "CarBranchView.h"
#import "YYFPSLabel.h"
#import "BranchScrollView.h"
#import "BranchListViewController.h"
#import "ENFoldTableView.h"
#import "ENFoldHeaderModel.h"
#import "ENBranchModel.h"
#import "ENHttp.h"

@interface ENEnterViewController ()<UIScrollViewDelegate,BranchScrollViewDelegate,CarBranchViewDelegate,ENFoldTableViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
//@property (nonatomic, strong) BranchScrollView *branchView;
@property (nonatomic, strong) ENFoldTableView *branchTableView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

//左边主菜单
@property (nonatomic, strong) NSArray *mainMenuList;
//右边分类列表
@property (nonatomic, strong) NSMutableArray *subMenuList;

@end

@implementation ENEnterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyView];
//    [self initData];
    
    [self requestData];
    
}

- (void)readyView{
    self.view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headImageView];
    [self.view addSubview:self.branchTableView];
    
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = KDeviceHeight-64-49 - 20;
    _fpsLabel.left = 20;
    _fpsLabel.alpha = 0;
    [self.view addSubview:_fpsLabel];
}

- (void)requestData{
    
    [ENHttp getEnterpriseBranchListCompleteBlock:^(BOOL ok, NSString *message, NSArray *branchList) {
       
        if (ok) {
//            一二级分类数据
            self.mainMenuList = branchList;
            [self.branchTableView setFoldTableViewHeaderData:branchList];
            
//          取头图规则 默认取一级分类下第一条数据头图
//          选择了二级分类，就去二级分类的图，如果二级分类没有图则去一级分类取
            ENFoldHeaderModel *model = [branchList firstObject];
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.adUrl]];
            
//            三四级分类数据
            [self getAllBranchMenuData:branchList];
            
        }
    }];
    
}


//初始状态加载所有3，4级分类数据
- (void)getAllBranchMenuData:(NSArray*)list{
    
//    获取所有2级分类的子集
    [self.subMenuList removeAllObjects];
    NSMutableArray *allData = [NSMutableArray arrayWithCapacity:0];
    for (ENFoldHeaderModel *model in list) {
        NSArray *subArr = model.subModel;
        if (subArr.count<=0) {
            continue;
        }
        for (ENFoldHeaderModel *sub in subArr) {
            if (sub.sonList.count<= 0) {
                continue;
            }
            for (NSDictionary *obj in sub.sonList) {
                NSArray *children = obj[@"children"];
                if (children.count<=0) {
                    continue;
                }
                [allData addObject:obj];
            }
        }
    }
    
    for (NSDictionary *dict in allData ) {
        ENBranchModel *model = [ENBranchModel setThirdLevelData:dict];
        [self.subMenuList addObject:model];
    }
    [self layoutBranchListView];
}


- (void)layoutBranchListView{
    
    for (UIView *view in self.mainScrollView.subviews) {
        if ([view isEqual:self.headImageView]) {
            continue;
        }
        [view removeFromSuperview];
    }
    
    CGFloat y = 150.f;
    for (int i = 0; i<self.subMenuList.count; i++) {
        
        ENBranchModel *model = [self.subMenuList objectAtIndex:i];
        if (!model) {
            continue;
        }
        
        CarBranchView *branchView = [[CarBranchView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth-100, KDeviceHeight)];
        branchView.menuDelegate = self;
        CGFloat height = [branchView setCarBranchForData:model andBranchTitle:model.branch_title andInitTag:100];
        branchView.frame = CGRectMake(0, y,KDeviceWidth-100, height);
        [self.mainScrollView addSubview:branchView];
        y += height;
    }
    self.mainScrollView.contentSize = CGSizeMake(KDeviceWidth-100, y);
}
- (void)refreshBranchViewData:(ENFoldHeaderModel*)model{
    
    [self.subMenuList removeAllObjects];
    
    NSArray *array = model.sonList;
    NSMutableArray *allData = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *obj in array) {
        NSArray *children = obj[@"children"];
        if (children.count<=0) {
            continue;
        }
        [allData addObject:obj];
    }
    
    for (NSDictionary *dict in allData ) {
        ENBranchModel *model = [ENBranchModel setThirdLevelData:dict];
        [self.subMenuList addObject:model];
    }
    
    [self layoutBranchListView];
    
}

#pragma mark - ENFoldTableViewDelegate
- (void)ENFoldTableViewDidSelect:(NSIndexPath *)indexpath{
    
    NSLog(@"section = %ld;row = %ld",indexpath.section,indexpath.row);
    ENFoldHeaderModel *model = self.mainMenuList[indexpath.section];
    ENFoldHeaderModel *subModel = model.subModel[indexpath.row];
    [self refreshBranchViewData:subModel];
    
}

- (void)ENFoldTableViewDidSelectHeaderView:(NSInteger)indexpath{
    
    [self getAllBranchMenuData:self.mainMenuList];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat contentOffset_Y = scrollView.contentOffset.y;
//    if (scrollView == self.mainScrollView) {
//
//        if (contentOffset_Y >= [_offsetArr[0] floatValue]) {
//            [self.branchView branchButtonDidSelect:0];
//        }else if (contentOffset_Y >= [_offsetArr[1] floatValue]){
//            [self.branchView branchButtonDidSelect:1];
//        }else if (contentOffset_Y >= [_offsetArr[2] floatValue]){
//            [self.branchView branchButtonDidSelect:2];
//        }else if (contentOffset_Y >= [_offsetArr[3] floatValue]){
//            [self.branchView branchButtonDidSelect:3];
//        }else if (contentOffset_Y >= [_offsetArr[4] floatValue]){
//            [self.branchView branchButtonDidSelect:5];
//        }
//    }
    
    
}

#pragma mark - CarBranchViewDelegate
- (void)carBranchViewDidSelect:(NSInteger)index andMenuId:(NSString*)menuId{
    
    BranchListViewController *vc = [[BranchListViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


//#pragma mark - BranchScrollViewDelegate
//- (void)branchViewDidSelectInside:(NSInteger)index{
//
//    CGFloat contentOffset = [_offsetArr[index] floatValue];
//    [self.mainScrollView setContentOffset:CGPointMake(0, contentOffset) animated:YES];
//}

#pragma mark -
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(100,0, KDeviceWidth, KDeviceHeight-49-64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (UIImageView*)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth-100, 150)];
        _headImageView.image = [UIImage imageNamed:@"zxpic"];
    }
    return _headImageView;
}

- (ENFoldTableView*)branchTableView{
    if (!_branchTableView) {
        _branchTableView = [[ENFoldTableView alloc]initWithFrame:CGRectMake(0, 0, 100, KDeviceHeight-64-49) style:UITableViewStyleGrouped];
        _branchTableView.foldDelegate = self;
    }
    return _branchTableView;
}



//- (BranchScrollView*)branchView{
//    if (!_branchView) {
//        _branchView = [[BranchScrollView alloc]initWithFrame:CGRectMake(0,0,100, KDeviceHeight-49-64)];
//        _branchView.showsVerticalScrollIndicator = NO;
//        _branchView.showsHorizontalScrollIndicator = NO;
//        _branchView.delegate = self;
//        _branchView.branchDelegate = self;
//    }
//    return _branchView;
//}

- (NSMutableArray*)subMenuList{
    if (!_subMenuList) {
        _subMenuList = [NSMutableArray arrayWithCapacity:0];
    }
    return _subMenuList;
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
