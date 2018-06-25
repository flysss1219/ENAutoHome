//
//  NavigationManager.m
//  FirstHouse
//
//  Created by iOSDev on 2017/10/20.
//  Copyright © 2017年 Berui. All rights reserved.
//

#import "NavigationManager.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "JZLocationConverter.h"

@interface NavigationManager()

@property (nonatomic, strong) NSMutableArray *mapsArray;
//转换后坐标
@property (nonatomic, assign) CLLocationCoordinate2D gcj02Location;

@property (nonatomic, assign) CLLocationCoordinate2D originLocaion;

@end

@implementation NavigationManager

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    static NavigationManager * instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[NavigationManager alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _mapsArray = [NSMutableArray new];
    }
    return self;
}

- (void)checkMapsUseful
{
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [self.mapsArray addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.gcj02Location.latitude,self.gcj02Location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [self.mapsArray addObject:baiduMapDic];
    }
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",self.gcj02Location.latitude,self.gcj02Location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [self.mapsArray addObject:gaodeMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",self.gcj02Location.latitude, self.gcj02Location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [self.mapsArray addObject:qqMapDic];
    }
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航",@"nav123456",self.gcj02Location.latitude, self.gcj02Location.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [self.mapsArray addObject:googleMapDic];
    }
    
    
}

- (void)startThirdAppNavigationWithStartPoint:(CLLocationCoordinate2D)startPoint endPoint:(CLLocationCoordinate2D)endPoint inView:(UIViewController*)vc
{
    [self.mapsArray removeAllObjects];
    self.gcj02Location = [JZLocationConverter bd09ToGcj02:endPoint];
    self.originLocaion = endPoint;
    [self checkMapsUseful];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"导航" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < self.mapsArray.count; i++) {
        
        if (i == 0) {
            [alertVC addAction:[UIAlertAction actionWithTitle:[self.mapsArray objectAtIndex:i][@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self appleMapNavi];
            }]];
        }else{
            [alertVC addAction:[UIAlertAction actionWithTitle:[self.mapsArray objectAtIndex:i][@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self otherMap:i];
            }]];
        }
    }
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

///  第三方地图
- (void)otherMap:(NSInteger)index
{
    NSDictionary *dic = self.mapsArray[index];
    NSString *urlString = dic[@"url"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)appleMapNavi
{
    CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:self.originLocaion];
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:gps addressDictionary:nil]];
    NSArray *items = @[currentLoc,toLocation];
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    [MKMapItem openMapsWithItems:items launchOptions:dic];
    
}



@end
