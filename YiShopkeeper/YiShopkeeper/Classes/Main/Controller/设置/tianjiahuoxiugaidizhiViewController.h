//
//  tianjiahuoxiugaidizhiViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/11.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import<BaiduMapAPI_Map/BMKMapView.h>

#import<BaiduMapAPI_Location/BMKLocationService.h>

#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>

#import<BaiduMapAPI_Map/BMKMapComponent.h>

#import<BaiduMapAPI_Search/BMKPoiSearchType.h>

#import "CYDZModel.h"
@interface tianjiahuoxiugaidizhiViewController : BaseViewController<BMKMapViewDelegate , BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
//    BMKMapView *_mapView;  //地图
//
//    BMKLocationService *_locService;  //定位
//
//    BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
    BMKLocationService * _locService;

}



@property (nonatomic,strong) UIView * locationView;
@property (nonatomic,strong) UIImageView * locImageView;
@property (nonatomic,strong) UIView * messageView;
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UIButton * sureButton;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) CLLocationCoordinate2D location2D;
@property (strong, nonatomic) BMKMapView *mapView;
@property (nonatomic, strong)BMKGeoCodeSearch* searchAddress;
@property (nonatomic,strong)BMKUserLocation *userLocation; //定位功能




@property (strong, nonatomic)NSString *TianJiaXiuGai;

@property (strong, nonatomic) IBOutlet UIButton *tianjiaxiugaiButton;

@property (strong, nonatomic) IBOutlet UIView *DiZhiView;

@property (strong, nonatomic) IBOutlet UILabel *yonggongdizhi;
@property (strong, nonatomic) NSString *ygdz;
@property (strong, nonatomic) CYDZModel *Model;
@end
