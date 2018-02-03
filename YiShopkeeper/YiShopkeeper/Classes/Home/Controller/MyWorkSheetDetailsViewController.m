//
//  MyWorkSheetDetailsViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/5.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyWorkSheetDetailsViewController.h"
#import "gongdanxiangqingView.h"
#import "SDCycleScrollView.h"
#import "baomingxinxi.h"
#import "gongdanxiangqingView.h"
#import "gongzuoxinxiModel.h"
@interface MyWorkSheetDetailsViewController ()<SDCycleScrollViewDelegate>
{
    UIView *dixianView;
    UIButton *JobInformationButton;
    UIButton *TheRegistrationInformationButton;
    UIView *xuanzhongxiahuaxianView ;
}
/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *banner;
@property (nonatomic,strong) UIScrollView * BJScrollView;
@property (nonatomic,strong) gongdanxiangqingView *gongdanxiangqing;
@property (nonatomic,strong) baomingxinxi * baomingxinxiView;
@property (strong ,nonatomic) gongzuoxinxiModel *gongzuoxinxiModel;
@property (nonatomic,strong)  NSMutableArray *imageArr;
@end

@implementation MyWorkSheetDetailsViewController

-(NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

+ (void)initialize {
    //设置自定义地图样式，会影响所有地图实例
    //注：必须在BMKMapView对象初始化之前调用
    NSString* path = [[NSBundle mainBundle] pathForResource:@"custom_config_清新蓝" ofType:@""];
    [BMKMapView customMapStyle:path];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (UIScrollView *)BJScrollView
{
    if (!_BJScrollView) {
        
        _BJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(dixianView.frame), kScreenWidth, kScreenHeight-64-48)];
        [self.view addSubview:_BJScrollView];
        
        _gongdanxiangqing = [[[NSBundle mainBundle] loadNibNamed:@"gongdanxiangqingView" owner:self options:nil] lastObject];
        [_gongdanxiangqing.gongdanbiaotineirongLabel setText:self.gongzuoxinxiModel.workTotal];
        [_gongdanxiangqing.fabushijianLabel setText:self.gongzuoxinxiModel.issueTm];
        [_gongdanxiangqing.qianLabel setText:[NSString stringWithFormat:@"%.2f",self.gongzuoxinxiModel.pay]];
        [_gongdanxiangqing.gongzuoshijianLabel setText:self.gongzuoxinxiModel.startTm];
        [_gongdanxiangqing.yonggongshichangLabel setText:[NSString stringWithFormat:@"%ld小时",(long)self.gongzuoxinxiModel.woekDuration]];
        [_gongdanxiangqing.gongzhong setText:self.gongzuoxinxiModel.workType];
        [_gongdanxiangqing.xuyaorenshu setText: [NSString stringWithFormat:@"%ld人",(long)self.gongzuoxinxiModel.recruitNum]];
        [_gongdanxiangqing.shengyurenshu setText:[NSString stringWithFormat:@"%ld人",(long)self.gongzuoxinxiModel.lastPeoNum]];
        [_gongdanxiangqing.yibaorenshu setText:[NSString stringWithFormat:@"%ld人",(long)self.gongzuoxinxiModel.appliedPeoNum]];
        [_gongdanxiangqing.gongdanbianhao setText:self.gongzuoxinxiModel.workOrderTab];
        [_gongdanxiangqing.teshuyaoqiu setText:self.gongzuoxinxiModel.workDetail];
        [_gongdanxiangqing.gongzuoxiangxidizhi setText:self.gongzuoxinxiModel.minuteAdd];
        _gongdanxiangqing.model = self.gongzuoxinxiModel;
    
        if (self.gongzuoxinxiModel.zhuangTai == 4 ) {
            _gongdanxiangqing.quxiaogongdan.hidden = YES;
        }else
        {
            if (self.gongzuoxinxiModel.appliedPeoNum == 0)
            {
                _gongdanxiangqing.quxiaogongdan.hidden = NO;
            }else
            {
                _gongdanxiangqing.quxiaogongdan.hidden = YES;
            }
            
        }
        
//        enableCustomMap = NO;
        self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(15, self.gongdanxiangqing.TwoView.mj_h - 312, kScreenWidth-30, 302)];
        _mapView.showsUserLocation = YES;//显示定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        [self.gongdanxiangqing.TwoView addSubview:_mapView];
        
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.longitude = self.gongzuoxinxiModel.x;
        coor.latitude = self.gongzuoxinxiModel.y ;
        annotation.coordinate = coor;
        annotation.title = self.gongzuoxinxiModel.minuteAdd;
        [self.mapView addAnnotation:annotation];
        
        if (_mapView.zoomLevel > 10) {
            _mapView.zoomLevel = 20;
        }else if (_mapView.zoomLevel < 8){
            _mapView.zoomLevel = 8;
        }
        [self.mapView setCenterCoordinate:coor animated:YES];
        self.mapView.gesturesEnabled = NO;
//        CGRect frame = _gongdanxiangqing.frame;
//        frame.origin.y = CGRectGetMaxY(dixianView.frame);
//        _gongdanxiangqing.frame = frame;
        NSLog(@"%@",self.gongzuoxinxiModel);
        for (int i = 0; i<self.gongzuoxinxiModel.workEvnPic.count; i++) {
            NSString *ImageStr = [self.gongzuoxinxiModel.workEvnPic[i]objectForKey:@"workEnvPicAdd"];
            [self.imageArr addObject:ImageStr];
        }
        //设置顶部轮播器
        _banner = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_gongdanxiangqing.gongzuohuanjing.frame)+10, kScreenWidth-30, 180)];
        _banner.delegate = self;
        //设置分页位置
        _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //设置时间间隔
        _banner.autoScrollTimeInterval = 3.0;
        //设置当前分页圆点颜色
        _banner.currentPageDotColor = [UIColor whiteColor];
        //设置其它分页圆点颜色
        _banner.pageDotColor = [UIColor lightGrayColor];
        //设置动画样式
        _banner.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _banner.localizationImageNamesGroup = _imageArr;
        [_gongdanxiangqing.ThreeView addSubview:_banner];
        
        [_BJScrollView addSubview:_gongdanxiangqing];
        _BJScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_gongdanxiangqing.ThreeView.frame));
    }
    return _BJScrollView;
}

- (baomingxinxi *)baomingxinxiView
{
    if (!_baomingxinxiView) {
        _baomingxinxiView = [[baomingxinxi alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dixianView.frame), kScreenWidth, kScreenHeight-64-48)GongZuoXinXi:self.gongzuoxinxiModel];
        _baomingxinxiView.Navi = self.navigationController;
        [self.view addSubview:_baomingxinxiView];

    }
    return _baomingxinxiView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_BJScrollView removeFromSuperview];
    _BJScrollView = nil;
    [_baomingxinxiView removeFromSuperview];
    _baomingxinxiView = nil;
    [self httpRequest];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
//    [BMKMapView enableCustomMapStyle:enableCustomMap];
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [JobInformationButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    [TheRegistrationInformationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    xuanzhongxiahuaxianView.frame = CGRectMake((TheRegistrationInformationButton.mj_w-40)/2, CGRectGetMaxY(TheRegistrationInformationButton.frame), 40, 1.5);
    
    [BMKMapView enableCustomMapStyle:NO];//关闭个性化地图
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"工单详情";
    
    
    
    JobInformationButton = [[UIButton alloc]init];
    JobInformationButton.frame = CGRectMake(0, 64, kScreenWidth/2-0.5, 48);
    JobInformationButton.backgroundColor = [UIColor whiteColor];
    [JobInformationButton setTitle:@"工作信息" forState:UIControlStateNormal];
    [JobInformationButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    [JobInformationButton addTarget:self action:@selector(JobInformation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:JobInformationButton];
    
    UIView *fengexianView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(JobInformationButton.frame), 79, 1, 48-30)];
    fengexianView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kXiahuaxianColor];
    [self.view addSubview:fengexianView];
    
    TheRegistrationInformationButton = [[UIButton alloc]init];
    TheRegistrationInformationButton.frame = CGRectMake(kScreenWidth/2+0.5, 64, kScreenWidth/2-0.5, 48);
    TheRegistrationInformationButton.backgroundColor = [UIColor whiteColor];
    if (/* DISABLES CODE */ (YES)) {
      [TheRegistrationInformationButton setTitle:@"报名信息" forState:UIControlStateNormal];
    }else
    {
        [TheRegistrationInformationButton setTitle:@"到达信息" forState:UIControlStateNormal];
    }

    [TheRegistrationInformationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [TheRegistrationInformationButton addTarget:self action:@selector(JobInformation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TheRegistrationInformationButton];
    
    xuanzhongxiahuaxianView = [[UIView alloc]initWithFrame:CGRectMake((TheRegistrationInformationButton.mj_w-40)/2, CGRectGetMaxY(TheRegistrationInformationButton.frame), 40, 1.5)];
    xuanzhongxiahuaxianView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBlueColor];
    [self.view addSubview:xuanzhongxiahuaxianView];
    
    
    dixianView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(TheRegistrationInformationButton.frame)+1.5, kScreenWidth, 1)];
    dixianView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kXiahuaxianColor];
    [self.view addSubview:dixianView];
    
    
    
}


- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/ExpertHomePage/expertHomeDetailInfo",kPRTURL];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.recruitInfoId),@"recruitInfoId", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSLog(@"%@",responseObj);
        if (result == 1) {
            NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            _gongzuoxinxiModel = [gongzuoxinxiModel creatRankingTotalModelWith:resultDic];
            [self BJScrollView];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
}


- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    //在这里计算尺寸
    self.gongdanxiangqing.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_gongdanxiangqing.ThreeView.frame));
    
}

#pragma mark - 轮播器Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"1111点击了图片%ld",(long)index);
}
#pragma mark - 工作信息 报名信息切换
- (void)JobInformation:(UIButton *)btn
{
    if (btn == JobInformationButton) {
        [_baomingxinxiView removeFromSuperview];
        _baomingxinxiView = nil;
        if (_BJScrollView == nil) {
            [self BJScrollView];
        }
        [JobInformationButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
        [TheRegistrationInformationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        xuanzhongxiahuaxianView.frame = CGRectMake((TheRegistrationInformationButton.mj_w-40)/2, CGRectGetMaxY(TheRegistrationInformationButton.frame), 40, 1.5);
    }else
    {
        
        [_BJScrollView removeFromSuperview];
        _BJScrollView = nil;
        if (_baomingxinxiView == nil) {
            [self baomingxinxiView];
        }
        [JobInformationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [TheRegistrationInformationButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
        xuanzhongxiahuaxianView.frame = CGRectMake(TheRegistrationInformationButton.mj_w+(TheRegistrationInformationButton.mj_w-40)/2, CGRectGetMaxY(TheRegistrationInformationButton.frame), 40, 1.5);
    }
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
