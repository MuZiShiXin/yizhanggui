//  设置
//  SettingViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/27.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "AccountSecurityViewController.h"
#import "CommonAddressViewController.h"
#import "UIViewController+AlertViewAndActionSheet.h"
#import "AppDelegate.h"
#import "RankingTotalModel.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    self.titelLabel.text = @"设置";
}
#pragma mark 账户安全
- (IBAction)zhanghuanquan {
    NSLog(@"账户安全");
    AccountSecurityViewController *AccountSecurityVC = [[AccountSecurityViewController alloc]init];
    [self.navigationController pushViewController:AccountSecurityVC animated:YES];
}
#pragma mark 关于我们
- (IBAction)guanyuwomen {
    NSLog(@"关于我们");
    AboutUsViewController *AboutUsVC = [[AboutUsViewController alloc]init];
    [self.navigationController pushViewController:AboutUsVC animated:YES];
}
#pragma mark 常用地址
- (IBAction)changyongdizhi {
    NSLog(@"常用地址");
    CommonAddressViewController * CommonAddressVC = [[CommonAddressViewController alloc]init];
    [self.navigationController pushViewController:CommonAddressVC animated:YES];
}
#pragma mark 退出当前帐号
- (IBAction)tuichudangqianzhanghao {
    NSLog(@"退出当前帐号");
    [self AlertWithTitle:nil message:@"确定要退出吗？" andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
        NSLog(@"%ld",index);
        if (index == 1) {
//            [userManager logout:nil];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"params"];
            [self.navigationController popViewControllerAnimated:YES];
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [app setUpLoginToMainPage];
        }
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
