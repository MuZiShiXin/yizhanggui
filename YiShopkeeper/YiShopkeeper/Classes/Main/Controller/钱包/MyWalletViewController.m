//  钱包
//  MyWalletViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/25.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyWalletViewController.h"
#import "CashWithdrawalViewController.h"
#import "DetailViewController.h"
@interface MyWalletViewController ()
{
    UILabel *TheAccountBalanceLabel;

}
@property (nonatomic ,assign) NSInteger resultDic;

@end

@implementation MyWalletViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequest];
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/balance",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global. userInfoId),@"userInfoId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        _resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] doubleValue];
        if (result == 1) {
            
            [self initViewS:_resultDic];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}
- (void)initViewS:(double)Yue
{
    UIView *firstview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 337/2)];
    firstview.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    [self.view addSubview:firstview];
    
    UILabel * TheAccountBalance = [[UILabel alloc]initWithFrame:CGRectMake(17, 56/2, kScreenWidth-2*17, 14)];
    TheAccountBalance.font = [UIFont systemFontOfSize:14];
    TheAccountBalance.textColor = [UIColor hx_colorWithHexRGBAString:@"c9e0f1"];
    TheAccountBalance.text = @"账户余额  (元)";
    TheAccountBalance.textAlignment = NSTextAlignmentLeft;
    [firstview addSubview:TheAccountBalance];
    
    TheAccountBalanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, CGRectGetMaxY(TheAccountBalance.frame)+39, kScreenWidth-2*17, 60)];
    [TheAccountBalanceLabel setText: [NSString stringWithFormat:@"%.2f",Yue]];
    TheAccountBalanceLabel.font = [UIFont systemFontOfSize:60];
    TheAccountBalanceLabel.textColor = [UIColor whiteColor];
    [firstview addSubview:TheAccountBalanceLabel];
    
    
    
    
    
    //第二块
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstview.frame), kScreenWidth, 88)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    
    NSArray *mineArray1 = @[@"提现",@"明细"];
    NSArray *pictureArray1 = @[@"yg_wd_qb_nr_tb1",@"yg_wd_qb_nr_tb2"];
    for (int i = 0; i < mineArray1.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*44, kScreenWidth, 44)];
        button.tag = i + 600;
        [button addTarget:self action:@selector(secondBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, (button.mj_h - 25)/2, 25, 25)];
        iconImageView.image = [UIImage imageNamed:pictureArray1[i]];
        [button addSubview:iconImageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+14.5, (44-25)/2, 100, 25)];
        label.font = [UIFont systemFontOfSize:15];
        label.tag = 1 + 100;
        label.text = mineArray1[i];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
        [button addSubview:label];
        
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(button.mj_w - 22 - 6.5, (button.mj_h-22)/2, 22, 22)];
        rightImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
        [button addSubview:rightImage];
        [secondView addSubview:button];
        
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(0, i*(44) , kScreenWidth, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [secondView addSubview:threadView];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = @"钱包";
    // Do any additional setup after loading the view.

}


#pragma mark 提现 明细
- (void)secondBtn:(UIButton *)btn
{
    if (btn.tag == 600) {
        NSLog(@"提现");
        CashWithdrawalViewController * CashWithdrawalVC = [[CashWithdrawalViewController alloc]init];
        CashWithdrawalVC.resultDic = _resultDic;

        [self.navigationController pushViewController:CashWithdrawalVC animated:YES];
    }else
    {
        NSLog(@"明细");
        DetailViewController *DetailVC = [[DetailViewController alloc]init];
        [self.navigationController pushViewController:DetailVC animated:YES];
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
