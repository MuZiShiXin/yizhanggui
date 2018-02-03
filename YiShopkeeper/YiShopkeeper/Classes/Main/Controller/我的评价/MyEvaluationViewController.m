//
//  MyEvaluationViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "MyEvaluationTableViewCell.h"
#import "DDPJModel.h"
@interface MyEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isOpen;
}
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSInteger CoutPage;
@property ( nonatomic ,strong) NSMutableArray *ModelDic;
@property (nonatomic, assign) NSInteger pages;



@property (nonatomic, strong)NSIndexPath * selectedIndex;


@end

@implementation MyEvaluationViewController

-(NSMutableArray *)ModelDic
{
    if (!_ModelDic) {
        _ModelDic = [NSMutableArray array];
    }
    return _ModelDic;
}

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

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/dingdan/pingjia",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", @(_CoutPage),@"currentPage",@(1),@"orderType",@(10),@"pageSize", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"list"];
        self.pages = [[[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"pages"] integerValue];
        if (result == 1) {
            for (int i = 0; i < resultDic.count; i++) {
                DDPJModel *mode = [DDPJModel creatRankingTotalModelWith:resultDic[i]];
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


-(void)viewWillAppear:(BOOL)animated
{
    [self httpRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLabel.text = @"我的评价";
    self.CoutPage = 1;
    isOpen = YES;
    // Do any additional setup after loading the view.
//    self.mainTableView.rowHeight = UITableViewAutomaticDimension; // 自适应单元格高度
//    self.mainTableView.estimatedRowHeight = 266; //先估计一个高度
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ModelDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    static NSString *cellIdentifier = @"cellIdentifier";//设置cell重用标示
    MyEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (indexPath.row == _selectedIndex.row && _selectedIndex != nil) {
        //如果是展开
        NSLog(@"new cell");
        if (isOpen == YES) {
            //根据标示去找cell，如果有现成的就用现成的
            if (!cell) {
                //没有现成的cell的时候：
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MyEvaluationTableViewCell" owner:nil options:nil] firstObject];
            }
            cell.duiwodepingjiaView.hidden = NO;
            [cell initSubViewsWithIndexPath:indexPath DDPJdic:self.ModelDic[indexPath.row]];
            //    cell.textLabel.text = [_mainTableViewDataArray objectAtIndex:[indexPath row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给cell设置内容 从之前设置的数据数组中拿数据
            
        }else{
            //收起
            NSLog(@"old cell");
            if (!cell) {
                //没有现成的cell的时候：
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MyEvaluationTableViewCell" owner:nil options:nil] firstObject];
            }
            cell.duiwodepingjiaView.hidden = YES;
            [cell initSubViewsWithIndexPath:indexPath DDPJdic:self.ModelDic[indexPath.row]];
            //    cell.textLabel.text = [_mainTableViewDataArray objectAtIndex:[indexPath row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给cell设置内容 从之前设置的数据数组中拿数据
            
            
        }
        
        //不是自身
    } else {
        if (!cell) {
            //没有现成的cell的时候：
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyEvaluationTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.duiwodepingjiaView.hidden = YES;
        [cell initSubViewsWithIndexPath:indexPath DDPJdic:self.ModelDic[indexPath.row]];
        //    cell.textLabel.text = [_mainTableViewDataArray objectAtIndex:[indexPath row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //给cell设置内容 从之前设置的数据数组中拿数据
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if (indexPath.row == _selectedIndex.row && _selectedIndex != nil ) {
        if (isOpen == YES) {
            
//            CGFloat f = 10;
//
//            if (indexPath.row == 10-1){
//
//                return 153.8+(f - 21);
//            }
//
//            return 155+(f - 21);
            return 287;
        }else{
            return 194;
        }
        
    }
    return 194;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    NSLog(@"点击了cell");
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    //    if (self.selectedIndex != nil && indexPath.row != selectedIndex.row) {
    if (self.selectedIndex != nil && indexPath.row == _selectedIndex.row) {
        //将选中的和所有索引都加进数组中
        //        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
        isOpen = !isOpen;
        
    }else if (self.selectedIndex != nil && indexPath.row != _selectedIndex.row) {
        indexPaths = [NSArray arrayWithObjects:indexPath,_selectedIndex, nil];
        isOpen = YES;
        
    }
    
    //记下选中的索引
    self.selectedIndex = indexPath;
    
    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    
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
