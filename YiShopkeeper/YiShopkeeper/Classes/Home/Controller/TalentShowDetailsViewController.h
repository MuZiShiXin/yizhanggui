//
//  TalentShowDetailsViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>


typedef void (^TalentShowDetailsBlock)(NSString *);


@interface TalentShowDetailsViewController : BaseViewController<BMKMapViewDelegate>
//{
//    __weak BMKMapView *_mapView;
//}
@property (strong ,nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) UINavigationController *Navi;
@property (strong, nonatomic) HomeModel *homeModel;
@property (strong, nonatomic) TalentShowDetailsBlock block;
@property (assign, nonatomic) NSInteger dingdanId;
@property (strong, nonatomic) IBOutlet UIScrollView *BJScrollView;

@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;

@property (strong, nonatomic) IBOutlet UILabel *shoucangLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shoucangImageView;
@property (strong, nonatomic) IBOutlet UIButton *shoucangButton;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *xingbieImageVIew;
@property (strong, nonatomic) IBOutlet UILabel *gonglingLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel1;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel2;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel3;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel4;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel5;
@property (strong, nonatomic) IBOutlet UILabel *darengongzuoxiangqingsLabel;

@property (strong, nonatomic) IBOutlet UIView *jinengView;
@property (strong, nonatomic) IBOutlet UILabel *jinengLabel;
@property (strong, nonatomic) IBOutlet UIView *gongzuodidianView;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidianLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth5;


@end
