//
//  PingjiaSViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/7.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "PingjiaSViewController.h"
#import "XHStarView.h"
#include "PlaceholderTextView.h"
@interface PingjiaSViewController ()
@property (strong, nonatomic) IBOutlet UILabel *zhunshiLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinengLabel;

@property (strong, nonatomic) IBOutlet UILabel *xiaolvLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhiliangLabel;

@property (strong, nonatomic) IBOutlet UIButton *fabiaopingjiaButton;

@property (strong, nonatomic) IBOutlet UIView *xianView;


@property (nonatomic, strong) XHStarView *starView1;
@property (nonatomic, strong) XHStarView *starView2;
@property (nonatomic, strong) XHStarView *starView3;
@property (nonatomic, strong) XHStarView *starView4;
@property (nonatomic, assign) CGFloat star1;
@property (nonatomic, assign) CGFloat star2;
@property (nonatomic, assign) CGFloat star3;
@property (nonatomic, assign) CGFloat star4;
@property (nonatomic, strong) NSString  *pingjieneirongStr;

@property (strong, nonatomic) IBOutlet UIView *pingjiaSView;


@end

@implementation PingjiaSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    self.titelLabel.text = @"我的评价";
    self.star1 = 20;
    self.star2 = 20;
    self.star3 = 20;
    self.star4 = 20;
    
    
    _fabiaopingjiaButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56e74"] CGColor];
    //设置边框宽度
    _fabiaopingjiaButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _fabiaopingjiaButton.layer.cornerRadius = 4.0f;
    //设置背景颜色
    _fabiaopingjiaButton.layer.masksToBounds = YES;
    
    
    
    self.starView1 = [[XHStarView alloc]initWithFrame:CGRectMake(kScreenWidth-160, 52+64, 160, 30)];
    [self.starView1 alterproperty:^(NSInteger star) {
//        label.text = [NSString stringWithFormat:@"%ld/100",star];
//        self.score = star;
        self.star1 = star;
    }];
    [self.starView1 startStar:20];
    [self.view addSubview:self.starView1];

    
    self.starView2 = [[XHStarView alloc]initWithFrame:CGRectMake(kScreenWidth-160, CGRectGetMaxY(_starView1.frame)+5, 160, 30)];
        [self.starView2 alterproperty:^(NSInteger star) {
    //        label.text = [NSString stringWithFormat:@"%ld/100",star];
    //        self.score = star;
            self.star2 = star;
        }];
    [self.starView2 startStar:20];
    [self.view addSubview:self.starView2];
    
    self.starView3 = [[XHStarView alloc]initWithFrame:CGRectMake(kScreenWidth-160, CGRectGetMaxY(self.starView2.frame)+5, 160, 30)];
        [self.starView3 alterproperty:^(NSInteger star) {
    //        label.text = [NSString stringWithFormat:@"%ld/100",star];
    //        self.score = star;
            self.star3 = star;
        }];
    [self.starView3 startStar:20];
    [self.view addSubview:self.starView3];
    
    
    
    
    self.starView4 = [[XHStarView alloc]initWithFrame:CGRectMake(kScreenWidth-160, CGRectGetMaxY(self.starView3.frame)+5, 160, 30)];
        [self.starView4 alterproperty:^(NSInteger star) {
    //        label.text = [NSString stringWithFormat:@"%ld/100",star];
    //        self.score = star;
            self.star4 = star;
        }];
    [self.starView4 startStar:20];
    [self.view addSubview:self.starView4];
    
    
    PlaceholderTextView *contentContactInformationTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 100)];
    contentContactInformationTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f8f8f8"];
    contentContactInformationTextView.placeholderLabel.font = [UIFont systemFontOfSize:13];
    contentContactInformationTextView.placeholder = @"请输入评价内容，不超过200字";
    contentContactInformationTextView.font = [UIFont systemFontOfSize:13];
    contentContactInformationTextView.maxLength = 200;
    [self.pingjiaSView addSubview:contentContactInformationTextView];
    
    [contentContactInformationTextView didChangeText:^(PlaceholderTextView *textView) {
        self.pingjieneirongStr = textView.text;
        NSLog(@"%@",textView.text);
    }];

}
- (IBAction)fabiaopingjiaSBtn {
    NSLog(@"发表评价");
    [self httpRequest];
    
    
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/Evaluate/evaluateOfIn",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: self.pingjieneirongStr,@"evaluateCon",@(self.dingDanId),@"myOrderId",@(1),@"evaluateType", @(self.star1/20),@"punScore",@(self.star2/20),@"skillScore",@(self.star3/20),@"ratioScore",@(self.star4/20),@"quaScore", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.dingDanId),@"myOrderId",@(8),@"orderState",@(self.gongDanId),@"recruitInfoId", nil];
            
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                if (result == 1) {
                    NSLog(@"成功");
                    [self showRightWithTitle:@"评价成功" autoCloseTime:2];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"TalentShowDetailsViewController" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }else if (result == 2)
                {
                    [self showInfoWithTitle:@"请勿重复提交" autoCloseTime:2];
                }
            } failure:^(NSError * _Nullable error) {
                
            }];
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
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
