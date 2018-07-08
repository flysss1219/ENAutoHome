//
//  ENAdViewController.m
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/5.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENAdViewController.h"
#import "UIImageView+WebCache.h"
#import "AdInfo.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "TSCacheManager.h"

#define kFlashScreenADKey @"kFlashScreenADKey"

@interface ENAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@property (nonatomic,strong) UILabel    *labelTime;

@property (nonatomic,strong) UIButton   *btnSkip;

@property (nonatomic,strong) AdInfo    *adInfo;


@end

@implementation ENAdViewController {
    dispatch_source_t _timer;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layOutSubview];
     [self loadAdRequest];
    [self showAd];
}

- (void)layOutSubview {
    
    self.adImageView.clipsToBounds = YES;
    self.adImageView.userInteractionEnabled = YES;
    self.adImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.adImageView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionWithShowAd)];
    [_adImageView addGestureRecognizer:tap];
    
}

//显示上一次的公告
- (void)showAd {
    
    //读取缓存广告
//    self.adInfo = [TSCacheManager getResponseCacheForKey:kFlashScreenADKey];
//    NSString *imageUrl = [self.adInfo.adContentUrl firstObject];
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530807181173&di=40b1e86a8af367223ced30f34f867b6e&imgtype=0&src=http%3A%2F%2Fim6.leaderhero.com%2Fwallpaper%2F20140919%2F33d64edb8c.jpg";
    if (imageUrl.length > 0) {
        //显示广告
        [self startCountdown];
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }else {
        //没广告,赶紧走
        [self btnSkipClick];
    }
}

- (void)startCountdown {
    [self.adImageView addSubview:self.btnSkip];
    [self actionWithCountdown];
}

- (void)actionWithShowAd {
    if(_timer){
        dispatch_source_cancel(_timer);
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.skipLoginStatus(self.adInfo);
}

//请求广告,作为下载展示
- (void)loadAdRequest{
    
//    [HTTPRequest getCommentAdWithPageId:@"19" positionId:@"13" newId:@"" completeBlock:^(BOOL ok, NSString *message, NSArray *adArr) {
//        if (ok) {
//            AdInfo *adInfo = [AdInfo new];
//            adInfo = [adArr firstObject];
//            NSString *imageUrl = [adInfo.adContentUrl firstObject];
//            if (imageUrl.length > 0) {
//                //下载图片
//                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//                    if (finished) {
//                        NSLog(@"闪屏图片缓存成功");
//                        [[SDImageCache sharedImageCache] storeImage:image forKey:imageUrl toDisk:YES completion:nil];
//                        //缓存广告
//                        [[VICacheManager sharedInstance]cacheObject:adInfo forKey:KFlashScreenAd];
//                    }
//                }];
//
//            }else{
//                [[VICacheManager sharedInstance] removeCacheForKey:KFlashScreenAd];
//            }
//        }
//    }];
    
}

//隐藏广告
- (void)btnSkipClick{
    if(_timer){
        dispatch_source_cancel(_timer);
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.skipLoginStatus(nil);
}

-(void)actionWithCountdown{
    __block int timeout=3;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self btnSkipClick];
            });
        }else{
            int seconds = timeout % 60;
            NSString  *timeStr = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _labelTime.text = timeStr;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -- getter/setter

-(UIButton *)btnSkip{
    if(!_btnSkip){
        _btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSkip.frame = CGRectMake(self.view.bounds.size.width - 70, 30, 55, 28);
        [_btnSkip setTitle:@"跳过" forState:UIControlStateNormal];
        _btnSkip.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSkip.titleEdgeInsets = UIEdgeInsetsMake(0, - 10, 0, 0);
        _btnSkip.layer.masksToBounds = YES;
        _btnSkip.layer.cornerRadius = 14;
        
        UIImage *imgBtn = [PureColorToImage imageWithColor:[UIColor colorWithWhite:0xffffff alpha:.3f] andWidth:10.0f andHeight:10.0f];
        [_btnSkip setBackgroundImage:imgBtn forState:UIControlStateNormal];
        
        _btnSkip.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_btnSkip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSkip addTarget:self action:@selector(btnSkipClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnSkip setBackgroundColor:[UIColor colorWithHex:0x000000 alpha:0.5]];
        _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 20, 28)];
        _labelTime.font = [UIFont systemFontOfSize:14];
        _labelTime.textColor = [UIColor whiteColor];
        [_btnSkip addSubview:_labelTime];
    }
    return _btnSkip;
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
