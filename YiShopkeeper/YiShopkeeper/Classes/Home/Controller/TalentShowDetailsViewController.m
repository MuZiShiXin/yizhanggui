//
//  TalentShowDetailsViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "TalentShowDetailsViewController.h"
#import "SDCycleScrollView.h"
#import "MyWorkSheetDetailsViewController.h"
#import "DaRenModel.h"
#import "TipAlertView.h"
#import "DingDanGuiJiSViewController.h"
@interface TalentShowDetailsViewController ()<SDCycleScrollViewDelegate,UIGestureRecognizerDelegate>
{
    NSArray *_imageArr; // 轮播图片数组
    UIButton *yichuButton;
    UIButton *qudingButton;
    BOOL enableCustomMap;
    
}
@property (nonatomic ,strong)TipAlertView *alert;

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *banner;
@property (strong ,nonatomic) DaRenModel *daRenModel;

@end

@implementation TalentShowDetailsViewController
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.BJScrollView.hidden = YES;
    [self httpRequest];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    [BMKMapView enableCustomMapStyle:enableCustomMap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [BMKMapView enableCustomMapStyle:NO];//关闭个性化地图
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;

}
- (void)dealloc {
    NSLog(@"111111111111111111111111111111111111111");
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/daren",kPRTURL];
    NSDictionary *parameters;
    if (self.dingdanId != 0) {
       parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.dingdanId),@"dingDanId", nil];
    }else
    {
      parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.homeModel.dingDanId),@"dingDanId", nil];
    }
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        _daRenModel = [DaRenModel creatRankingTotalModelWith:resultDic];
        if (result == 1) {
            [self setValueSDic:_daRenModel];
            self.BJScrollView.hidden= NO;
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"达人详情";
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    //添加普通地图/个性化地图切换开关
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"normal", @"custom"]];
    [segment setSelectedSegmentIndex:0];
    [segment addTarget:self action:@selector(changeMapAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segment];
    enableCustomMap = NO;
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(15, _gongzuodidianView.mj_h - 312, kScreenWidth-30, 302)];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    [self.gongzuodidianView addSubview:_mapView];
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 45.762404;
    coor.longitude = 126.651743;
    annotation.coordinate = coor;
    annotation.title = _daRenModel.gongZuoDiZhi;
    [self.mapView addAnnotation:annotation];
    
    if (_mapView.zoomLevel > 10) {
        _mapView.zoomLevel = 20;
    }else if (_mapView.zoomLevel < 8){
        _mapView.zoomLevel = 8;
    }
    [self.mapView setCenterCoordinate:coor animated:YES];
//    self.mapView.gesturesEnabled = NO;
    [self addCustomGestures];//添加自定义的手势
    
}




- (void)setValueSDic:(DaRenModel *)dic
{
    
    [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:dic.touXiang] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_biaotiLabel setText:dic.niCheng];
    
    if ([dic.xingBie isEqualToString:@"男"]) {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }else
    {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }
    
    [_gonglingLabel setText:[NSString stringWithFormat:@"%ld年",(long)dic.gongLing]];
    
    
    UIView *view
    = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-45, kScreenWidth, 45)];
    [self.view addSubview:view];
    
    yichuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 45)];
    yichuButton.backgroundColor = [UIColor whiteColor];
    
    if (dic.dingDanZhuangTai == 2 || dic.dingDanZhuangTai == 13) {
        [yichuButton setTitle:@"未到达" forState:UIControlStateNormal];

    }else if(dic.dingDanZhuangTai == 1 )
    {
        [yichuButton setTitle:@"移除" forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 4)
    {
        [yichuButton setTitle:@"订单轨迹" forState:UIControlStateNormal];

    }
    
    
    [yichuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yichuButton addTarget:self action:@selector(yichuBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:yichuButton];
    
    UIView *xianView = [[UIView alloc]initWithFrame:CGRectMake(0, yichuButton.mj_origin.y, yichuButton.mj_w, 1)];
    xianView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e9e9e9"];
    [yichuButton addSubview:xianView];
    
    
    qudingButton = [[UIButton alloc]initWithFrame:CGRectMake(yichuButton.mj_w, 0, kScreenWidth/2, 45)];
    qudingButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    [qudingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
   
    if (dic.dingDanZhuangTai == 2 || dic.dingDanZhuangTai == 13) {
         [qudingButton setTitle:@"确认到达" forState:UIControlStateNormal];
        
    }else if(dic.dingDanZhuangTai == 1 )
    {
        [qudingButton setTitle:@"确定" forState:UIControlStateNormal];
        
    }else if (dic.dingDanZhuangTai == 4)
    {
        [qudingButton setTitle:@"验收" forState:UIControlStateNormal];
        
    }
    
    [qudingButton addTarget:self action:@selector(qudingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:qudingButton];
    [self WorkDetailsButton];
    
    _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _shoucangButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _shoucangButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _shoucangButton.layer.masksToBounds = YES;
    
    if (dic.shouCang == 1) {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    }else
    {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    
    
//    _imageArr = @[@"yg_sy_grxq_nr_tp3",@"yg_sy_grxq_nr_tp3",@"yg_sy_grxq_nr_tp3",@"yg_sy_grxq_nr_tp3"];
    
    //设置顶部轮播器
    _banner = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_jinengLabel.frame)+10, kScreenWidth-30, 180)];
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
    _banner.localizationImageNamesGroup = dic.tuPianList;
    [_jinengView addSubview:_banner];
    
    if (dic.gongZhongs.count >= 1 && dic.gongZhongs.count > 0) {
        _zhiweiLabel1.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
        //设置边框宽度
        _zhiweiLabel1.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel1.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel1.layer.masksToBounds = YES;
        _zhiweiLabel1.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel1.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
        [_zhiweiLabel1 setText:dic.gongZhongs[0]];
        _zhiweiLabel1.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth1 = [UILabel getWidthWithTitle:_zhiweiLabel1.text font:_zhiweiLabel1.font];
        self.zhiweiLabel1.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+11, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth1+10, 15);
        _labelwidth1.constant = labellingwidth1+10;

    }else
    {
        [_zhiweiLabel1 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count >= 2 && dic.gongZhongs.count > 1) {
        _zhiweiLabel2.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _zhiweiLabel2.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel2.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel2.layer.masksToBounds = YES;
        _zhiweiLabel2.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel2.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_zhiweiLabel2 setText:dic.gongZhongs[1]];
        _zhiweiLabel2.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth2 = [UILabel getWidthWithTitle:_zhiweiLabel2.text font:_zhiweiLabel2.font];
        self.zhiweiLabel2.frame = CGRectMake(CGRectGetMaxX(_zhiweiLabel1.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth2+10, 15);
        _labelwidth2.constant = labellingwidth2+10;

    }else
    {
        [_zhiweiLabel2 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count >= 3 && dic.gongZhongs.count > 2) {
        _zhiweiLabel3.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _zhiweiLabel3.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel3.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel3.layer.masksToBounds = YES;
        _zhiweiLabel3.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel3.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_zhiweiLabel3 setText:dic.gongZhongs[2]];
        _zhiweiLabel3.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth3 = [UILabel getWidthWithTitle:_zhiweiLabel3.text font:_zhiweiLabel3.font];
        self.zhiweiLabel3.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth3+10, 15);
        _labelwidth3.constant = labellingwidth3+10;

    }else
    {
        [_zhiweiLabel3 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count >= 4 && dic.gongZhongs.count > 3) {
        _zhiweiLabel4.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
        //设置边框宽度
        _zhiweiLabel4.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel4.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel4.layer.masksToBounds = YES;
        _zhiweiLabel4.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel4.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
        [_zhiweiLabel4 setText:dic.gongZhongs[3]];
        _zhiweiLabel4.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth4 = [UILabel getWidthWithTitle:_zhiweiLabel4.text font:_zhiweiLabel4.font];
        self.zhiweiLabel4.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth4+10, 15);
        _labelwidth4.constant = labellingwidth4+10;

    }else
    {
        [_zhiweiLabel4 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count <= 5 && dic.gongZhongs.count > 4) {
        _zhiweiLabel5.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _zhiweiLabel5.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel5.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel5.layer.masksToBounds = YES;
        _zhiweiLabel5.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel5.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_zhiweiLabel5 setText:dic.gongZhongs[4]];
        _zhiweiLabel5.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth5 = [UILabel getWidthWithTitle:_zhiweiLabel5.text font:_zhiweiLabel5.font];
        self.zhiweiLabel5.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth5+10, 15);
        _labelwidth5.constant = labellingwidth5+10;
    }else
    {
        [_zhiweiLabel5 removeFromSuperview];
    }
    
    [_darengongzuoxiangqingsLabel setText:dic.neiRong];
    
    [_gongzuodidianLabel setText:dic.gongZuoDiZhi];
    
    
    
}




//工作详情
- (void)WorkDetailsButton
{
    UIButton *WorkDetailsBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, 30, 100, 22)];
    [WorkDetailsBtn setTitle:@"工作信息" forState:UIControlStateNormal];
    [WorkDetailsBtn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
    WorkDetailsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [WorkDetailsBtn addTarget:self action:@selector(WorkDetailsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WorkDetailsBtn];
}

#pragma mark 工作信息
- (void)WorkDetailsBtn
{
    NSLog(@"工作信息");
    MyWorkSheetDetailsViewController *MyWorkSheetDetailsVC = [[MyWorkSheetDetailsViewController alloc]init];
    if (self.homeModel != nil) {
        MyWorkSheetDetailsVC.recruitInfoId = self.homeModel.gongDanId;
    }else
    {
        MyWorkSheetDetailsVC.recruitInfoId = self.daRenModel.gongDanId;
    }
    [self.navigationController pushViewController:MyWorkSheetDetailsVC animated:YES];

}

#pragma mark - 轮播器Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"1111点击了图片%ld",(long)index);
}

#pragma mark 未到达
- (void)yichuBtn:(UIButton *)onebtn
{
    NSLog(@"未到达");
    
        __weak typeof(self) weakSelf = self;
        self.alert = [[TipAlertView alloc] initWithMessage:[NSString stringWithFormat:@"是否%@", yichuButton.titleLabel.text]
                                                     image:[UIImage imageNamed:@"11"]
                                              buttonTitles:@[@"取消",@"确认"]];
    __weak UIButton *oneBtn = onebtn;
    
        self.alert.AcceptBlock = ^(){
            
            NSInteger orderState = 0;
            if ([oneBtn.titleLabel.text isEqualToString:@"未到达"]) {
                orderState = 12;
            }else if ([oneBtn.titleLabel.text isEqualToString:@"订单轨迹"])
            {
                DingDanGuiJiSViewController *DingDanGuiJiSVC = [[DingDanGuiJiSViewController alloc]init];
                [weakSelf.Navi pushViewController:DingDanGuiJiSVC animated:YES];
                return;
            }else if ([oneBtn.titleLabel.text isEqualToString:@"移除"])
            {
                orderState = 9;
            }
            
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(weakSelf.daRenModel.dingDanId),@"myOrderId",@(orderState),@"orderState",@(weakSelf.daRenModel.gongDanId),@"recruitInfoId", nil];
            
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                if (result == 1) {
                    NSLog(@"成功");
                    [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                }else if (result == 2)
                {
                    [weakSelf showInfoWithTitle:@"请勿重复提交" autoCloseTime:2];
                }
            } failure:^(NSError * _Nullable error) {
                NSLog(@"loginError:%@",error);
                
            }];
        };
        self.alert.RefuseBlock = ^(){
            
            
        };
        [self.alert show];
}
#pragma mark 确认到达
- (void)qudingBtn:(UIButton *)twobtn
{
    NSLog(@"确认到达");
    __weak typeof(self) weakSelf = self;
    self.alert = [[TipAlertView alloc] initWithMessage:[NSString stringWithFormat:@"是否%@",qudingButton.titleLabel.text]
                                                 image:[UIImage imageNamed:@"11"]
                                          buttonTitles:@[@"取消", qudingButton.titleLabel.text]];
    __weak UIButton *twoBtn = twobtn;
    weakSelf.alert.AcceptBlock = ^(){
        
        NSLog(@"确认到达",nil);
        NSInteger orderState = 0;
        if ([twoBtn.titleLabel.text isEqualToString:@"确认到达"]) {
            orderState = 3;
        }else if ([twoBtn.titleLabel.text isEqualToString:@"验收"])
        {
            orderState = 6;
        }else if ([twoBtn.titleLabel.text isEqualToString:@"确定"])
        {
            orderState = 2;
        }
        
        
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(weakSelf.daRenModel.dingDanId),@"myOrderId",@(orderState),@"orderState",@(weakSelf.daRenModel.gongDanId),@"recruitInfoId", nil];
            
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                if (result == 1) {
                    NSLog(@"成功");
                    [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                    weakSelf.homeModel.dingDanZhuangTai = 4;
                    if (weakSelf.block != nil) {
                        weakSelf.block(@"1");
                    }
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"TalentShowDetailsViewController" object:nil];
                }else if (result == 2)
                {
                    [self showInfoWithTitle:@"请勿重复提交" autoCloseTime:2];
                }
            } failure:^(NSError * _Nullable error) {
                NSLog(@"loginError:%@",error);
                
            }];
    };
    weakSelf.alert.RefuseBlock = ^(){
        
        
    };
    [weakSelf.alert show];
}




#pragma mark 收藏
- (IBAction)shoucangBtn {
    if ([_shoucangImageView.image isEqual:[UIImage imageNamed:@"yg_sy_nr_tb3"]]) {
        NSLog(@"收藏");
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
        
    }else {
        NSLog(@"取消收藏");
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shoucang",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.daRenModel.zhangGuiId),@"zhangGuiId",@(self.daRenModel.daRenId),@"daRenId", nil];
    __weak typeof(self) weakSelf = self;
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
//        NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"rows"];
        if (result == 1) {
            NSLog(@"收藏成功");
            if (weakSelf.daRenModel.shouCang == 0) {
                weakSelf.homeModel.shouCang = 1;
                [weakSelf showRightWithTitle:@"收藏成功" autoCloseTime:2];
                
            }else
            {
                weakSelf.daRenModel.shouCang = 0;
                [weakSelf showRightWithTitle:@"取消收藏成功" autoCloseTime:2];
                
            }
        }else
        {
            NSLog(@"收藏失败");
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
    
}






- (void)changeMapAction:(UISegmentedControl *)segment {
    /*
     *注：必须在BMKMapView对象初始化之前设置自定义地图样式，设置后会影响所有地图实例
     *设置方法：+ (void)customMapStyle:(NSString*) customMapStyleJsonFilePath;
     */
    enableCustomMap = segment.selectedSegmentIndex == 1;
    //打开/关闭个性化地图
    [BMKMapView enableCustomMapStyle:enableCustomMap];
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    //    [alert show];
    //    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

#pragma mark - 添加自定义的手势（若不自定义手势，不需要下面的代码）

- (void)addCustomGestures {
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.cancelsTouchesInView = NO;
    doubleTap.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:doubleTap];
    
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    /*
     *do something
     */
    NSLog(@"my handleSingleTap");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    NSLog(@"my handleDoubleTap");
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
