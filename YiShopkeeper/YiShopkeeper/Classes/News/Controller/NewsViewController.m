//
//  NewsViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "NewsViewController.h"
#import "XiaoXiMianDaRaoTableViewCell.h"
#import "QueRentiXingTableViewCell.h"
#import "TiXianZhuangTaiTableViewCell.h"
#import "TongZhiTableViewCell.h"
#import "MasseaModel.h"
#import "UITableView+EmptyData.h"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property ( nonatomic ,strong) NSMutableArray *ModelDic;

@end

@implementation NewsViewController

- (BOOL)isHideBackButton
{
    return YES;
}

- (NSMutableArray *)ModelDic
{
    if (!_ModelDic) {
        _ModelDic = [NSMutableArray array];
    }
    return _ModelDic;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self httpRequest];
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/getMessageZG",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userZgId", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            NSArray *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            for (int i = 0; i < resultDic.count; i++) {
                MasseaModel *mode = [MasseaModel creatRankingTotalModelWith:resultDic[i]];
                [self.ModelDic addObject:mode];
            }
            [self mainTableView];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
}




- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitMsg:@"暂无消息" ifNecessaryForRowCount:_ModelDic.count];

    return self.ModelDic.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"XiaoXiMianDaRaoIdentifier";//设置cell重用标示
        XiaoXiMianDaRaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //根据标示去找cell，如果有现成的就用现成的
        if (!cell) {
            //没有现成的cell的时候：
            cell = [[[NSBundle mainBundle]loadNibNamed:@"XiaoXiMianDaRaoTableViewCell" owner:nil options:nil] firstObject];
        }
        //    [cell initSubViewsWithIndexPath:indexPath dataArray:nil];
        //    cell.textLabel.text = [_mainTableViewDataArray objectAtIndex:[indexPath row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //给cell设置内容 从之前设置的数据数组中拿数据
        return cell;
    }else
    {
        static NSString *cellIdentifier = @"QueRentiXingIdentifier";//设置cell重用标示
        QueRentiXingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //根据标示去找cell，如果有现成的就用现成的
        if (!cell) {
            //没有现成的cell的时候：
            cell = [[[NSBundle mainBundle]loadNibNamed:@"QueRentiXingTableViewCell" owner:nil options:nil] firstObject];
        }
        [cell initSubViewsWithIndexPath:indexPath MasseaModelData:self.ModelDic[indexPath.row - 1]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //给cell设置内容 从之前设置的数据数组中拿数据
        return cell;
        
    }
//    else if (indexPath.row == 3)
//    {
//        static NSString *cellIdentifier = @"TiXianZhuangTaiIdentifier";//设置cell重用标示
//        TiXianZhuangTaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        //根据标示去找cell，如果有现成的就用现成的
//        if (!cell) {
//            //没有现成的cell的时候：
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"TiXianZhuangTaiTableViewCell" owner:nil options:nil] firstObject];
//        }
//        //    [cell initSubViewsWithIndexPath:indexPath dataArray:nil];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        //给cell设置内容 从之前设置的数据数组中拿数据
//        return cell;
//    }else
//    {
//        static NSString *cellIdentifier = @"TongZhiIdentifier";//设置cell重用标示
//        TongZhiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        //根据标示去找cell，如果有现成的就用现成的
//        if (!cell) {
//            //没有现成的cell的时候：
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"TongZhiTableViewCell" owner:nil options:nil] firstObject];
//        }
//        //    [cell initSubViewsWithIndexPath:indexPath dataArray:nil];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        //给cell设置内容 从之前设置的数据数组中拿数据
//        return cell;
//    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == 0) {
        return 45;
    }else
//        if(indexPath.row == 1 || indexPath.row == 2)
    {
        return 126.5;
    }
//    else if (indexPath.row == 3)
//    {
//        return 80.5;
//    }
    return 126.5;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    NSLog(@"点击了cell");
    self.tabBarController.selectedIndex = 0;
    
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
