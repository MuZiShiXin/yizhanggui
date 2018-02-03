//
//  WoDeGongDanViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "WoDeGongDanViewController.h"

#import "SegmentTapView.h"
#import "FlipTableView.h"

#import "ONESViewController.h"
#import "TWOSViewController.h"
#import "THREESViewController.h"
#import "FOURSViewController.h"
@interface WoDeGongDanViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;

@end

@implementation WoDeGongDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titelLabel.text =@"我的工单";
    [self initSegment];
    [self initFlipTableView];
}

-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40) withDataArray:[NSArray arrayWithObjects:@"全部",@"进行中",@"已完工",@"已取消", nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}

-(void)initFlipTableView{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    ONESViewController *OnesVC = [[ONESViewController alloc]init];
    OnesVC.Navi = self.navigationController;
    TWOSViewController *TwosVC = [[TWOSViewController alloc]init];
    TwosVC.Navi = self.navigationController;
    THREESViewController *ThreesVC = [[THREESViewController alloc]init];
    ThreesVC.Navi = self.navigationController;
    FOURSViewController *FoursVC = [[FOURSViewController alloc]init];
    FoursVC.Navi = self.navigationController;
    [self.controllsArray addObject:OnesVC];
    [self.controllsArray addObject:TwosVC];
    [self.controllsArray addObject:ThreesVC];
    [self.controllsArray addObject:FoursVC];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, self.view.frame.size.height - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.flipView selectIndex:index];
    
}
-(void)scrollChangeToIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.segment selectIndex:index];
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
