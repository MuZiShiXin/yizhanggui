//
//  OrderViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "OrderViewController.h"

#import "SegmentTapView.h"
#import "FlipTableView.h"

#import "TheOneViewController.h"
#import "TheTwoViewController.h"
#import "TheThreeViewController.h"
#import "TheFourViewController.h"

#import "TheRepairOrderSearchViewController.h"

@interface OrderViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;
@property (assign, nonatomic) NSInteger zhuangtia;
@end

@implementation OrderViewController
- (BOOL)isHideBackButton
{
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text =@"我的订单";
    self.zhuangtia = 1;
    [self initSegment];
    [self initFlipTableView];
    [self searchButton];
    
    
}

-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 119, kScreenWidth, 40) withDataArray:[NSArray arrayWithObjects:@"全部",@"进行中",@"已完工",@"已取消", nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}
//搜索
- (void)searchButton
{
    UIView *BJView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    BJView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    [self.view addSubview:BJView];
    UIView *BJView2 = [[UIView alloc]initWithFrame:CGRectMake(15, 8, kScreenWidth - 30, 39)];
    BJView2.backgroundColor = [UIColor whiteColor];
    [BJView addSubview:BJView2];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 30 - 110) /2, 12.5, 12, 12)];
    [imageview setImage:[UIImage imageNamed:@"yg_sy_dhl_tb2"]];
    [BJView2 addSubview:imageview];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+5, 12.5, 150, 12)];
    label.text = @"请输入工单名称";
    label.font = [UIFont systemFontOfSize:13.0];
    label.textColor = [UIColor grayColor];
    [BJView2 addSubview:label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    //    button.backgroundColor  =[UIColor redColor];
    [button addTarget:self action:@selector(TheSystemCalls) forControlEvents:UIControlEventTouchUpInside];
    [BJView2 addSubview:button];
}

-(void)initFlipTableView{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    TheOneViewController *OneVC = [[TheOneViewController alloc]init];
    OneVC.gaodu = @"1";
    OneVC.Navi = self.navigationController;
    
    TheTwoViewController *TwoVC = [[TheTwoViewController alloc]init];
    TwoVC.gaodu = @"1";
    TwoVC.Navi = self.navigationController;
    
    TheThreeViewController *ThreeVC = [[TheThreeViewController alloc]init];
    ThreeVC.gaodu = @"1";
    ThreeVC.Navi = self.navigationController;
    
    TheFourViewController *FourVC = [[TheFourViewController alloc]init];
    FourVC.gaodu = @"1";
    FourVC.Navi = self.navigationController;

    [self.controllsArray addObject:OneVC];
    [self.controllsArray addObject:TwoVC];
    [self.controllsArray addObject:ThreeVC];
    [self.controllsArray addObject:FourVC];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 163, kScreenWidth, self.view.frame.size.height - 163) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    self.zhuangtia = index + 1;
    [self.flipView selectIndex:index];
    
}
-(void)scrollChangeToIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.segment selectIndex:index];
}

#pragma mark 搜索按钮
- (void)TheSystemCalls
{
    TheRepairOrderSearchViewController * TheRepairOrderSearchVC = [[TheRepairOrderSearchViewController alloc]init];
    TheRepairOrderSearchVC.dindanzhuantai = self.zhuangtia;
    [self.navigationController pushViewController:TheRepairOrderSearchVC animated:YES];
}


@end
