//
//  FuJinQiuZhiDeRenViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "FuJinQiuZhiDeRenViewController.h"
#import "AllXinXiTableViewCell.h"
#import "PeopleNearbyTableViewCell.h"

#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "PeopleNearbyModel.h"

@interface FuJinQiuZhiDeRenViewController ()
<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate>
{
    UIView * dixianView;
}
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) BMKLocationService *locService;
@property ( nonatomic ,strong) NSMutableArray *ModelDic;

@end

@implementation FuJinQiuZhiDeRenViewController

- (NSMutableArray *)ModelDic
{
    if (!_ModelDic ) {
        _ModelDic = [NSMutableArray array];
    }
    return _ModelDic;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
//    [self httpRequest];
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/BaiDuMap/nearbyPeople",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(_locService.userLocation.location.coordinate.longitude),@"yCoord",@(_locService.userLocation.location.coordinate.latitude),@"xCoord", nil];
    
//    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(45.76621800),@"xCoord",@(126.71148300),@"yCoord", nil];
    
    
    NSLog(@"%@",parameters);
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            NSArray *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            for (int i = 0; i < resultDic.count; i++) {
                PeopleNearbyModel *mode = [PeopleNearbyModel creatRankingTotalModelWith:resultDic[i]];
                [self.ModelDic addObject:mode];
            }
            [self.mainTableView reloadData];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation

{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self httpRequest];
    [self.locService stopUserLocationService];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dixianView.frame), kScreenWidth, kScreenHeight-64)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"附近求职的人";
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(15, 80, 13, 13)];
    imageView.image = [UIImage imageNamed:@"yg_sygdbmdd_nr_tb1"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"需要%ld人  已报",self.recruitNum];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    CGFloat width = [UILabel getWidthWithTitle:label.text font:label.font];
    label.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+6.5, 80, width, 13);
    [self.view addSubview:label];
    
    UILabel *RegistrationNumberLabel = [[UILabel alloc]init];
    RegistrationNumberLabel.textColor = [UIColor redColor];
    RegistrationNumberLabel.font = [UIFont systemFontOfSize:13];
    RegistrationNumberLabel.text = [NSString stringWithFormat:@"%ld人",self.appliedPeoNum];
    CGFloat width1 = [UILabel getWidthWithTitle:RegistrationNumberLabel.text font:RegistrationNumberLabel.font];
    RegistrationNumberLabel.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, 80, width1, 13);
    [self.view addSubview:RegistrationNumberLabel];

    UILabel *remainingAndacceptance = [[UILabel alloc]init];
    remainingAndacceptance.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    remainingAndacceptance.font = [UIFont systemFontOfSize:13];
    remainingAndacceptance.text = @"剩余";
    CGFloat width2 = [UILabel getWidthWithTitle:remainingAndacceptance.text font:remainingAndacceptance.font];
    remainingAndacceptance.frame = CGRectMake(CGRectGetMaxX(RegistrationNumberLabel.frame)+10, 80, width2, 13);
    [self.view addSubview:remainingAndacceptance];
        
    UILabel *RenNumberLabel = [[UILabel alloc]init];
    RenNumberLabel.textColor = [UIColor redColor];
    RenNumberLabel.font = [UIFont systemFontOfSize:13];
    RenNumberLabel.text = [NSString stringWithFormat:@"%ld人",self.lastPeoNum];
    CGFloat width3 = [UILabel getWidthWithTitle:RenNumberLabel.text font:RenNumberLabel.font];
    RenNumberLabel.frame = CGRectMake(CGRectGetMaxX(remainingAndacceptance.frame)+5, 80, width3, 13);
    [self.view addSubview:RenNumberLabel];
    
    dixianView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(RenNumberLabel.frame)+16, kScreenWidth, 5)];
    dixianView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef2f5"];
    [self.view addSubview:dixianView];
    [self mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:_ModelDic.count];
    return self.ModelDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    static NSString *cellIdentifier = @"cellIdentifiers";//设置cell重用标示
//    AllXinXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    //根据标示去找cell，如果有现成的就用现成的
//    if (!cell) {
//        //没有现成的cell的时候：
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"AllXinXiTableViewCell" owner:nil options:nil] firstObject];
//    }
//    [cell initSubViewsWithIndexPath:indexPath baomingxinxiModel:self.ModelDic[indexPath.row] nav:self.Navi];
    
    PeopleNearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PeopleNearbyTableViewCell" owner:nil options:nil] firstObject];
    }
    if (self.ModelDic.count != 0) {
        [cell initSubViewsWithIndexPath:indexPath baomingxinxiModel:self.ModelDic[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //给cell设置内容 从之前设置的数据数组中拿数据
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return 146;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    NSLog(@"点击了cell");
    
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
