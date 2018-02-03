//
//  MyWorkSheetDetailsViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/5.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MyWorkSheetDetailsViewController : BaseViewController <BMKMapViewDelegate>
@property (strong, nonatomic) HomeModel *homeModel;
@property (assign, nonatomic) NSInteger recruitInfoId;
@property (strong ,nonatomic) BMKMapView *mapView;

@end
