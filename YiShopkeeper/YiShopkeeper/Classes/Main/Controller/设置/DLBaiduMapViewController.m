//
//  DLBaiduMapViewController.m
//  回顾
//
//  Created by 周冰烽 on 2018/1/3.
//  Copyright © 2018年 devil. All rights reserved.
//

#import "DLBaiduMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import "DLMapSearchViewController.h"
static NSString * const cellID = @"cellID";
static NSString * const cell2ID = @"cell2ID";
@interface DLBaiduMapViewController ()<BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,weak) BMKMapView *mapView;//地图

@property(nonatomic,strong) BMKLocationService *locService;//定位

@property(nonatomic,weak) UITableView *tableView;

@property(nonatomic,strong) BMKGeoCodeSearch *searcher;//编码

@property(nonatomic,strong) NSArray<BMKPoiInfo *> *dataList;//信息

@property (nonatomic, assign) NSIndexPath *selectIndex;//单选，当前选中的行

@property(nonatomic,strong) NSString *GetAddress;
@property(nonatomic,assign) CGFloat latitudeY;
@property(nonatomic,assign) CGFloat longitudeX;
@end

@implementation DLBaiduMapViewController{
    UIView *_topbgView;
    NSString *_cityName;
    CLLocationCoordinate2D _pt;
    BOOL _isAutoMove;
}

#pragma mark - 监听方法

- (void)clickSearch{
    DLMapSearchViewController *mapSearchVC = [[DLMapSearchViewController alloc]init];
    mapSearchVC.cityName = _cityName;
    [self.navigationController pushViewController:mapSearchVC animated:NO];
    mapSearchVC.chooseAddress = ^(CLLocationCoordinate2D pt) {
        _pt = pt;
    };
}

#pragma mark - BMKGeoCodeSearchDelegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (_isAutoMove == NO) {
            self.dataList = result.poiList;
            _cityName = result.addressDetail.city;
            [self.tableView reloadData];
        }else{
            _isAutoMove = NO;
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    BMKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center = centerCoordinate;
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    self.longitudeX = centerCoordinate.longitude;
    self.latitudeY = centerCoordinate.latitude;
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = region.center;
    BOOL flag = [self.searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag){
        NSLog(@"反geo检索发送成功");
        if (self.dataList.count != 0) {
            self.longitudeX = centerCoordinate.longitude;
            self.latitudeY = centerCoordinate.latitude;
            self.GetAddress = [NSString stringWithFormat:@"%@%@",self.dataList[_selectIndex.row].name,self.dataList[_selectIndex.row].address];
        }
        
    }else{
        NSLog(@"反geo检索发送失败");
    }
}
#pragma mark 右上角选择
- (void)AddAddress:(UIButton *)Btn
{
    Btn.userInteractionEnabled = NO;
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/dizhi/modify",kPRTURL];
    self.GetAddress = [NSString stringWithFormat:@"%@%@",self.dataList[_selectIndex.row].name,self.dataList[_selectIndex.row].address];
    if (self.GetAddress.length != 0 && self.latitudeY !=0 && self.longitudeX !=0){
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId",self.GetAddress,@"diZhi",@(self.latitudeY),@"Y",@(self.longitudeX),@"X",nil];

        [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
            if (result == 1) {
                [self showRightWithTitle:@"添加用工地址成功" autoCloseTime:2];
                
                Btn.userInteractionEnabled = YES;
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
            Btn.userInteractionEnabled = YES;
        }];
    }else
    {
        Btn.userInteractionEnabled = YES;
    }
}














#pragma mark - BMKLocationServiceDelegate

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [self.mapView updateLocationData:userLocation]; //更新地图上的位置
}


#pragma mark - UITableViewDelegate && dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell2ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataList[indexPath.row].name;
    cell.detailTextLabel.text = self.dataList[indexPath.row].address;
    
    if (self.selectIndex == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _isAutoMove = YES;
    NSLog(@"%@",self.dataList);
    [self.mapView setCenterCoordinate:self.dataList[indexPath.row].pt animated:YES];
    
    //之前选中的，取消选择
    UITableViewCell *celled = [tableView cellForRowAtIndexPath:self.selectIndex];
    celled.accessoryType = UITableViewCellAccessoryNone;
    //记录当前选中的位置索引
    self.selectIndex = indexPath;
    //当前选择的打勾
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

#pragma mark - UI

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.mapView viewWillAppear];
    self.selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    self.searcher.delegate = self;
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    if (_pt.longitude == 0) {
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(45.766286, 126.711660) animated:YES];
    }else{
        [self.mapView setCenterCoordinate:_pt animated:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.searcher.delegate = nil;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"百度地图的使用";
    self.titelLabel.text = @"选择位置";
    [self setupSearchView];
    [self setupMapView];
    [self setupTableView];
    //启动LocationService
    [self.locService startUserLocationService];
    
    
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    but.frame =CGRectMake( kScreenWidth-75, 20, 60, 44);
    [but setTitle:@"选择"forState:UIControlStateNormal];
    [but setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(AddAddress:)forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:but];
    

    
}

- (void)setupSearchView {
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.offset(50);
    }];
    _topbgView = topView;
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    [topView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).offset(13);
        make.right.equalTo(topView).offset(-12);
        make.height.mas_equalTo(@32);
    }];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSearch)];
    [gesture setNumberOfTapsRequired:1];
    [searchView addGestureRecognizer:gesture];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请输入关键字";
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    label.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1/1.0];
    [searchView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(searchView);
    }];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"withicon2"]];
    [searchView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(searchView);
        make.right.equalTo(label.mas_left).offset(-12);
    }];
}

- (void)setupMapView{
    BMKMapView *mapView = [[BMKMapView alloc]init];
    [self.view addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_topbgView.mas_bottom);
        make.height.mas_equalTo(@220);
    }];
    self.mapView = mapView;
    
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"gpers_icon"] forState:UIControlStateNormal];
    [mapView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mapView);
    }];
    
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
    self.mapView.zoomLevel = 16;//地图显示的级别
    
    
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 250, kScreenWidth, kScreenHeight - 64 - 250) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


#pragma mark - lazyLoad
- (BMKLocationService *)locService{
    if (_locService == nil) {
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
    return _locService;
}

- (BMKGeoCodeSearch *)searcher{
    if (!_searcher) {
        _searcher =[[BMKGeoCodeSearch alloc]init];
    }
    return _searcher;
}

- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = [NSArray array];
    }
    return _dataList;
}

@end
