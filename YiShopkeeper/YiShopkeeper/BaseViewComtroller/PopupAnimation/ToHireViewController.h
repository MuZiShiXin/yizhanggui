//
//  ToHireViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/23.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import<BaiduMapAPI_Map/BMKMapView.h>

#import<BaiduMapAPI_Location/BMKLocationService.h>

#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>

#import<BaiduMapAPI_Map/BMKMapComponent.h>

#import<BaiduMapAPI_Search/BMKPoiSearchType.h>
#import "gongdansModel.h"

@interface ToHireViewController : BaseViewController <BMKMapViewDelegate , BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKLocationService * _locService;
}

@property (nonatomic,strong) UIView * locationView;
@property (nonatomic,strong) UIImageView * locImageView;
@property (nonatomic,strong) UIView * messageView;
@property (nonatomic,strong) UILabel * addressLabels;
@property (nonatomic,strong) UIButton * sureButton;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,assign) CLLocationCoordinate2D location2D;
@property (strong, nonatomic) BMKMapView *mapView;
@property (nonatomic, strong)BMKGeoCodeSearch* searchAddress;
@property (nonatomic,strong)BMKUserLocation *userLocation; //定位功能
@property (nonatomic,strong) gongdansModel *Model;

@end
