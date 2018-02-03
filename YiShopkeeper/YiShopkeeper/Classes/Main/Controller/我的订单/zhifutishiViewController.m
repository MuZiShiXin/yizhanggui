//
//  zhifutishiViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/9.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "zhifutishiViewController.h"

@interface zhifutishiViewController ()

@end

@implementation zhifutishiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark 选择微信支付
- (IBAction)xuanzeweixinBtn {
    NSLog(@"微信支付");
    [_xuanzeweixinImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb3"]];
    [_zhifubaoImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb2"]];
}

#pragma mark 选择支付宝支付
- (IBAction)xuanzezhifubaoBtn {
    NSLog(@"支付宝支付");
    [_zhifubaoImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb3"]];
    [_xuanzeweixinImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb2"]];
}

#pragma mark 确认支付
- (IBAction)querenzhifuBtn {
    NSLog(@"确认支付");
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
