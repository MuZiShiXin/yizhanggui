//
//  TheRepairOrderSearchViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/29.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "TheRepairOrderSearchViewController.h"
#import "MyOrderTableViewCell.h"
#import "BasicDisplayTableViewCell.h"
#import "TalentShowDetailsViewController.h"
#import "DaRenXiangQingViewController.h"
@interface TheRepairOrderSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
//@property (nonatomic, strong) UITableView *chaxunTableView;
@property (nonatomic, strong) UITableView *shouyeTabel;
@property (nonatomic ,strong) NSMutableArray *ModelDic;
@property (nonatomic ,strong) NSString *str;
@property (nonatomic, assign) NSInteger CoutPage;
@property (nonatomic, assign) NSInteger pages;

@end

@implementation TheRepairOrderSearchViewController

- (NSMutableArray *)ModelDic
{
    if (!_ModelDic ) {
        _ModelDic = [NSMutableArray array];
    }
    return _ModelDic;
}

//- (UITableView *)chaxunTableView{
//    if (!_chaxunTableView) {
//        _chaxunTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
//        _chaxunTableView.delegate = self;
//        _chaxunTableView.dataSource = self;
//        _chaxunTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.view addSubview:_chaxunTableView];
//    }
//    return _chaxunTableView;
//}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        
        
        _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _mainTableView;
}


- (UITableView *)shouyeTabel{
    if (!_shouyeTabel) {
        _shouyeTabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        _shouyeTabel.delegate = self;
        _shouyeTabel.dataSource = self;
        _shouyeTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_shouyeTabel];
    }
    return _shouyeTabel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建输入框
    self.CoutPage = 1;
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(50,27, kScreenWidth - 100, 30)];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.font = [UIFont systemFontOfSize:15];
    searchTextField.layer.borderWidth = 1;
    searchTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    searchTextField.backgroundColor = [UIColor colorWithRed:239 /255.0 green:239/255.0 blue:244/255.0 alpha:0.5];
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30, 15)];
    leftImage.contentMode = UIViewContentModeScaleAspectFit;
    leftImage.image = [UIImage imageNamed:@"Search"];
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.leftView = leftImage;
    searchTextField.layer.cornerRadius = 5;
    searchTextField.placeholder = @"搜索工作名称";
    searchTextField.delegate = self;
    [searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.navigationView addSubview:searchTextField];
    
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
    return self.ModelDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    //设置cell重用标示
    static NSString *cellIdentifier = @"cellIdentifier";
    static NSString *cellIdentifierss = @"cellIdentifierss";

    if (tableView == _mainTableView) {
        MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            //根据标示去找cell，如果有现成的就用现成的
        if (!cell) {
                //没有现成的cell的时候：
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyOrderTableViewCell" owner:nil options:nil] firstObject];
        }
        [cell initSubViewsWithIndexPath:indexPath dataDic:self.ModelDic[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给cell设置内容 从之前设置的数据数组中拿数据
        return cell;

    }else
    {
        BasicDisplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierss];
        //根据标示去找cell，如果有现成的就用现成的
        if (!cell) {
            //没有现成的cell的时候：
            cell = [[BasicDisplayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierss];
        }
        [cell initSubViewsWithIndexPath:indexPath Model:self.ModelDic[indexPath.row]];
        //给cell设置内容 从之前设置的数据数组中拿数据
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (tableView == _mainTableView && ![_distinguish isEqualToString:@"首页"]) {
       return 266;
    }else
    {
        return 212;
    }
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    if (tableView == _mainTableView) {
        NSLog(@"点击了mainTableView  cell");
    }else
    {
        NSLog(@"点击了chaxunTableView  cell");
//        [_chaxunTableView removeFromSuperview];
        if (![_distinguish isEqualToString:@"首页"]) {
            [self mainTableView];
        }else
        {
            __weak __typeof(self) weakSelf = self;
            
            HomeModel *INdexpathDlc = _ModelDic[indexPath.row];
            if (INdexpathDlc.dingDanZhuangTai == 2) {
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
        
    }
    
}
#pragma mark 收索监听
- (void)textFieldDidChange:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length != 0 && textField.text != nil) {
        _str = textField.text;
        [self httpRequest];
    }
     return YES;
}

- (void)httpRequest
{
    if ([_distinguish isEqualToString:@"首页"]) {
        NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shouye",kPRTURL];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",Global.userInfoId] ,@"userInfoId",@(1),@"pageNum",@(10),@"pageSize",_str,@"gongZuoMingCheng", nil];
        
        [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
//            NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"rows"];
            self.pages = [[[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"pages"]integerValue];
            if (result == 1) {
                NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"]objectForKeyWithNullDetection:@"list"];
                for (int i = 0; i < resultDic.count; i++) {
                    HomeModel *mode = [HomeModel creatRankingTotalModelWith:resultDic[i]];
                    [self.ModelDic addObject:mode];
                }
                [self.shouyeTabel reloadData];
            }else if(result == 2)
            {
                [self.view showErrorWithTitle:@"未匹配到相应内容" autoCloseTime:2];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
            [self.ModelDic removeAllObjects];
            [BaseErrorView errorViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) superView:self.view withBlock:^{
                [self httpRequest];
            }];
        }];
    }else
    {
        NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/dingdan",kPRTURL];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"zhangGuiId",@(self.dindanzhuantai),@"zhuangTai", nil];
        
        [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
            NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"list"];
            self.pages = [[[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"pages"]integerValue];
            if (result == 1) {
                for (int i = 0; i < resultDic.count; i++) {
                    dingdanModel *mode = [dingdanModel creatRankingTotalModelWith:resultDic[i]];
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
            [self.ModelDic removeAllObjects];
            [BaseErrorView errorViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) superView:self.view withBlock:^{
                [self httpRequest];
            }];
        }];
    }
   
}

#pragma mark -  logic delegate
-(void)requestDataCompleted{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    [self.mainTableView reloadData];
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
