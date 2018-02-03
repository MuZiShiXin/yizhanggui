//
//  CommonAddressViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "CommonAddressViewController.h"
#import "CommonAddressTableViewCell.h"
#import "tianjiahuoxiugaidizhiViewController.h"
#import "CYDZModel.h"
#import "DLBaiduMapViewController.h"
@interface CommonAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSInteger CoutPage;
@property ( nonatomic ,strong) NSMutableArray *ModelDic;
@property (nonatomic, assign) NSInteger pages;
@end

@implementation CommonAddressViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (NSMutableArray *)ModelDic
{
    if (!_ModelDic ) {
        _ModelDic = [NSMutableArray array];
    }
    return _ModelDic;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-45)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor hx_colorWith8BitRed:234 green:239 blue:243];
//        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        _mainTableView.tableFooterView = [UIView new];
        
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
        
    }
    return _mainTableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.ModelDic removeAllObjects];
    [self httpRequest];
}


- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/dizhi/query",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSArray *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        self.pages = 1;
        if (result == 1) {
            for (int i = 0; i < resultDic.count; i++) {
                CYDZModel *mode = [CYDZModel creatRankingTotalModelWith:resultDic[i]];
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
#pragma mark -  logic delegate
-(void)requestDataCompleted{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    [self.mainTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CoutPage = 1;
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"常用地址";
    //1.调整(iOS7以上)表格分隔线边距
    if ([self.mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.mainTableView.separatorInset = UIEdgeInsetsZero;
    }
    //2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
    if ([self.mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.mainTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    
    UIButton *TianJiaDiZhiBtn = [[UIButton alloc]init];
    TianJiaDiZhiBtn.frame = CGRectMake(0, kScreenHeight - 45, kScreenWidth, 45);
    TianJiaDiZhiBtn.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBlueColor];

    [TianJiaDiZhiBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [TianJiaDiZhiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [TianJiaDiZhiBtn addTarget:self action:@selector(TianJiaDiZhi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TianJiaDiZhiBtn];
    
    
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


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitMsg:@"暂无常用地址" ifNecessaryForRowCount:_ModelDic.count];
    return self.ModelDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    static NSString *cellIdentifier = @"cellIdentifier";//设置cell重用标示
    CommonAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //根据标示去找cell，如果有现成的就用现成的
    if (!cell) {
        //没有现成的cell的时候：
        cell = [[CommonAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (self.ModelDic.count != 0 && self.ModelDic != nil) {
        [cell initSubViewsWithIndexPath:indexPath CYDZdic:self.ModelDic[indexPath.row]];
    }
    //    cell.textLabel.text = [_mainTableViewDataArray objectAtIndex:[indexPath row]];
    //给cell设置内容 从之前设置的数据数组中拿数据
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //2.调整(iOS8以上)tableView边距
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    return 173/2;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    NSLog(@"点击了cell");
    if ([self.SelectAddress isEqualToString:@"yes"]) {
        NSString *str = [self.ModelDic[indexPath.row] xiangXiDiZhi];
        if (_block != nil) {
            _block(str,[self.ModelDic[indexPath.row] Y],[self.ModelDic[indexPath.row] X]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
    
    [self httpRequestSC:[self.ModelDic[indexPath.row] diZhiId]];
    [self.ModelDic removeObjectAtIndex:indexPath.row];
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark 添加地址
- (void)TianJiaDiZhi
{
    NSLog(@"添加新地址");
//    tianjiahuoxiugaidizhiViewController *tianjiahuoxiugaidizhiVC = [[tianjiahuoxiugaidizhiViewController alloc]init];
//    tianjiahuoxiugaidizhiVC.TianJiaXiuGai = @"添加地址";
//    tianjiahuoxiugaidizhiVC.ygdz = @"";
//    [self.navigationController pushViewController:tianjiahuoxiugaidizhiVC animated:YES];
    
    
    //关于百度地图的一些事情
    DLBaiduMapViewController *mapVC = [[DLBaiduMapViewController alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];
    
    
    
    
    
}


- (void)httpRequestSC:(NSInteger)diZhiId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/dizhi/delete",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", @(diZhiId),@"diZhiId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        self.pages = 1;
        if (result == 1) {
            [self showRightWithTitle:@"删除地址成功" autoCloseTime:2];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }];
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
