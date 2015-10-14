//
//  ViewController.m
//  MapNavigation
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 林虎虎. All rights reserved.
//

#import "ViewController.h"
//地图框架
#import <MAMapKit/MAMapKit.h>
//定位框架
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>
//地图
@property (nonatomic,strong)MAMapView *mapview;
//定位
@property (nonatomic,strong)CLLocationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark  地图
    [MAMapServices sharedServices].apiKey = @"31f1d628087db1d5863f6d6bf5461172";
    self.mapview = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    self.mapview.delegate = self;
    [self.view addSubview:_mapview];
    //是否显示底图标注信息
    //self.mapview.showsLabels = YES;
    //设置为卫星图
    self.mapview.mapType = MAMapTypeSatellite;
    //是否允许地图旋转
    self.mapview.rotateEnabled = NO;
    //开启定位开关
   // self.mapview.showsUserLocation = YES;
   // self.mapview.userTrackingMode = MAUserTrackingModeFollow;
    //是否显示交通
    self.mapview.showTraffic = YES;
#pragma mark 定位
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    
    //向设备请求授权
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        //向设备申请程序使用时，使用定位功能
        [self.manager requestWhenInUseAuthorization];
    }
    //开始定位
  //  [self.manager startUpdatingLocation];
    

   

}

#pragma mark  大头针标注
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    //向地标添加
    [self.mapview addAnnotation:pointAnnotation];
    
}
//实现MAMapViewDelegete
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        //设置气泡可以弹出
        annotationView.canShowCallout = YES;
        //设置标注动画显示
        annotationView.animatesDrop = YES;
        //设置标注可以拖动
        annotationView.draggable = YES;
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
