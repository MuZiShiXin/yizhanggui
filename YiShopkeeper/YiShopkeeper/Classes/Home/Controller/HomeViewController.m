//
//  HomeViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseViewController.h"
#import "BasicDisplayTableViewCell.h"
#import "TheRepairOrderSearchViewController.h"
#import "YMCitySelect.h"
#import "UIView+ym_extension.h"
#import "TalentShowDetailsViewController.h"
#import "DaRenXiangQingViewController.h"
#import "HomeModel.h"
#import "UITableView+EmptyData.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,YMCitySelectDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSInteger CoutPage;
@property ( nonatomic ,strong) NSMutableArray *ModelDic;
@property (nonatomic, assign) NSInteger pages;

@end

@implementation HomeViewController
{
    UIButton *CityselectionButton;
    UILabel *CityselectionLabel;
    UIImageView *CityselectionImageView;
    
}
- (BOOL)isHideBackButton
{
    return YES;
}

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
    [self.ModelDic removeAllObjects];
    [self httpRequest];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-64)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
    }
    return _mainTableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"易掌柜";
    _CoutPage = 1;
//    [self httpRequest];
    [self searchButton];
    [self CityselectionButton];
}






#pragma mark ————— 下拉刷新 —————
-(void)headerRereshing{
    _CoutPage = 1;
    [self.ModelDic removeAllObjects];
    [self httpRequest];
}

#pragma mark ————— 上拉刷新 —————
-(void)footerRereshing{
    _CoutPage += 1;
    if (_CoutPage <= _pages) {
        [self httpRequest];
    }else
    {
        [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark -  logic delegate
-(void)requestDataCompleted{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    [self.mainTableView reloadData];
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shouye",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId",@(_CoutPage),@"pageNum", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"list"];
        self.pages = [[responseObj objectForKeyWithNullDetection:@"pages"] integerValue];
        if (result == 1) {
            for (int i = 0; i < resultDic.count; i++) {
                HomeModel *mode = [HomeModel creatRankingTotalModelWith:resultDic[i]];
                [self.ModelDic addObject:mode];
            }
        [self mainTableView];
        [self requestDataCompleted];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}



//搜索
- (void)searchButton
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-37, 30, 22, 22)];
        //    button.backgroundColor  =[UIColor redColor];
    [button setImage:[UIImage imageNamed:@"yg_sy_dhl_tb2"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(TheSystemCalls) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)CityselectionButton
{
    CityselectionButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 20,   100, 44)];
    [CityselectionButton addTarget:self action:@selector(cityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CityselectionButton];
    CityselectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 16.5, 100, 11)];
    CityselectionLabel.font = [UIFont systemFontOfSize:11];
    CityselectionLabel.text = @"哈尔滨";
    CGFloat width1 = [UILabel getWidthWithTitle:CityselectionLabel.text font:CityselectionLabel.font];
    CityselectionLabel.frame = CGRectMake(0, 16.5, width1, 11);
    [CityselectionButton addSubview:CityselectionLabel];
    
    CityselectionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(CityselectionLabel.frame)+5, 10, 22, 22)];
    CityselectionImageView.image = [UIImage imageNamed:@"yg_syfbxz_nr_tb1"];
    [CityselectionButton addSubview:CityselectionImageView];
    [self.view addSubview:CityselectionButton];
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:_ModelDic.count];
    return _ModelDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    static NSString *cellIdentifier = @"cellIdentifier";//设置cell重用标示
    BasicDisplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //根据标示去找cell，如果有现成的就用现成的
    if (!cell) {
        //没有现成的cell的时候：
        cell = [[BasicDisplayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.Navi = self.navigationController;
    if (self.ModelDic.count != 0 && self.ModelDic != nil) {
        [cell initSubViewsWithIndexPath:indexPath Model:_ModelDic[indexPath.row]];
    }
    __weak __typeof(self) weakSelf = self;
    [cell setBlock:^(NSIndexPath *indexpath) {
        [self.ModelDic removeObjectAtIndex:[indexpath row]];  //删除_data数组里的数据
        [weakSelf.mainTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [weakSelf.mainTableView reloadData];
    }];
//    cell.textLabel.text = [_mainTableViewDataArray objectAtIndex:[indexPath row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //给cell设置内容 从之前设置的数据数组中拿数据
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.ModelDic.count != 0) {
        NSString *str = [self.ModelDic[indexPath.row] neiRong];
        if (str.length != 0) {
            return 212;
        }else
        {
            return 212-58;
        }
    }else
    {
        return 0;
    }
    
    
}
#pragma mark 搜索按钮
- (void)TheSystemCalls
{
    NSLog(@"搜索");
    TheRepairOrderSearchViewController * TheRepairOrderSearchVC = [[TheRepairOrderSearchViewController alloc]init];
    TheRepairOrderSearchVC.distinguish = @"首页";
    [self.navigationController pushViewController:TheRepairOrderSearchVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    NSLog(@"点击了cell");
    __weak __typeof(self) weakSelf = self;

    HomeModel *INdexpathDlc = _ModelDic[indexPath.row];
    if (INdexpathDlc.dingDanZhuangTai != 1) {
        TalentShowDetailsViewController *TalentShowDetailsVC = [[TalentShowDetailsViewController alloc]init];
        TalentShowDetailsVC.homeModel = INdexpathDlc;
        [TalentShowDetailsVC setBlock:^(NSString *str) {
            [weakSelf headerRereshing];
        }];
        [self.navigationController pushViewController:TalentShowDetailsVC animated:YES];
    }else
    {
        DaRenXiangQingViewController *DaRenXiangQingVC = [[DaRenXiangQingViewController alloc]init];
        DaRenXiangQingVC.homeModel = INdexpathDlc;
        DaRenXiangQingVC.indexPath = indexPath;
        
        [DaRenXiangQingVC setBlock:^(NSIndexPath *indexpath) {
            [self.ModelDic removeObjectAtIndex:[indexpath row]];  //删除_data数组里的数据
            [weakSelf.mainTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [weakSelf.mainTableView reloadData];
        }];
        
        [DaRenXiangQingVC setBlocks:^(NSString *str) {
            [weakSelf headerRereshing];
        }];
        
        [self.navigationController pushViewController:DaRenXiangQingVC animated:YES];
    } 
}

#pragma mark - 城市选择
-(void)cityBtnClick:(UIButton *)btn{
    [self presentViewController:[[YMCitySelect alloc] initWithDelegate:self] animated:YES completion:nil];
}


-(void)ym_ymCitySelectCityName:(NSString *)cityName{
    CityselectionLabel.text = cityName;
    CGFloat width1 = [UILabel getWidthWithTitle:CityselectionLabel.text font:CityselectionLabel.font];
    CityselectionLabel.frame = CGRectMake(0, 16.5, width1, 11);
    CityselectionImageView.frame =  CGRectMake(CGRectGetMaxX(CityselectionLabel.frame)+5, 10, 22, 22);
}
- (void)dealloc
{
//    NSLog(@"首页dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
