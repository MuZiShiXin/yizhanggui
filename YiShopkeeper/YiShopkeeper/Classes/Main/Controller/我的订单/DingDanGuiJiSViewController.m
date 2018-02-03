//
//  DingDanGuiJiSViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "DingDanGuiJiSViewController.h"
#import "MyWorkSheetDetailsViewController.h"
@interface DingDanGuiJiSViewController ()

@end

@implementation DingDanGuiJiSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    self.titelLabel.text = @"订单轨迹";
    
    _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _shoucangButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _shoucangButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _shoucangButton.layer.masksToBounds = YES;
    
    [self WorkDetailsButton];
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
    [self.navigationController pushViewController:MyWorkSheetDetailsVC animated:YES];
    
}


#pragma mark  收藏
- (IBAction)shoucangSButton {
    NSLog(@"收藏");
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
