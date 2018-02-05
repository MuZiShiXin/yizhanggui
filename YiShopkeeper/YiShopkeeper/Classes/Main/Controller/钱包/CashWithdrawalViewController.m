//  提现
//  CashWithdrawalViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/25.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "CashWithdrawalViewController.h"

@interface CashWithdrawalViewController ()
{
    UIImageView *PaymentOptionsImageView;
    UIImageView *payImageView;
    UITextField *amountTextField;
    UITextField *payTextField;
}
@end

@implementation CashWithdrawalViewController
- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLabel.text = @"提现";
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef2f5"];
    // Do any additional setup after loading the view.
    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(15, 79, kScreenWidth-30, 44)];
    firstView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e0e0e0"];
    [self.view addSubview:firstView];
    
    UILabel *WithdrawalAmountLabel = [[UILabel alloc]init];
    WithdrawalAmountLabel.frame = CGRectMake(20, (firstView.mj_h-17)/2, 100, 17);
    WithdrawalAmountLabel.font = [UIFont systemFontOfSize:17];
    WithdrawalAmountLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"464646"];
    WithdrawalAmountLabel.text =@"提现金额";
    WithdrawalAmountLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat width = [UILabel getWidthWithTitle:WithdrawalAmountLabel.text font:WithdrawalAmountLabel.font];
    
    WithdrawalAmountLabel.frame = CGRectMake(20, (firstView.mj_h-17)/2, width, 17);
    [firstView addSubview:WithdrawalAmountLabel];
    
    UILabel *promptingLabel = [[UILabel alloc]init];
    promptingLabel.frame = CGRectMake(CGRectGetMaxX(WithdrawalAmountLabel.frame)+29/2, (firstView.mj_h-15)/2, firstView.mj_w-WithdrawalAmountLabel.mj_w -40-29, 15);
    promptingLabel.font = [UIFont systemFontOfSize:15];
    promptingLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    promptingLabel.text = @"24小时内到账";
    promptingLabel.textAlignment = NSTextAlignmentLeft;
    [firstView addSubview:promptingLabel];
    
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(firstView.frame), kScreenWidth-30, 283)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];

    
    amountTextField = [[UITextField alloc]initWithFrame:CGRectMake(16, 27.5, secondView.mj_w-32, 25)];
    amountTextField.placeholder = @"请填写提现金额";
    amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [secondView addSubview:amountTextField];
    
    UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(amountTextField.frame)+5, secondView.mj_w-40, 1)];
    threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
    [secondView addSubview:threadView];
    
    
    UILabel *PayTreasureLabel  = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(threadView.frame)+20, secondView.mj_w-32, 25)];
    PayTreasureLabel.text = @"填写支付宝帐号";
    PayTreasureLabel.textAlignment = NSTextAlignmentLeft;
    PayTreasureLabel.font = [UIFont systemFontOfSize:17];
    [secondView addSubview:PayTreasureLabel];
    
    payTextField = [[UITextField alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(PayTreasureLabel.frame)+10, secondView.mj_w-32, 25)];
    payTextField.placeholder = @"请输入支付宝帐号";
    [secondView addSubview:payTextField];
    
    UIView *threadView1 = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(payTextField.frame)+5, secondView.mj_w-40, 1)];
    threadView1.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
    [secondView addSubview:threadView1];
    
    UIButton *WithdrawalButton = [[UIButton alloc]initWithFrame:CGRectMake(20, secondView.mj_h-87.5, secondView.mj_w - 40, 44)];
    WithdrawalButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    WithdrawalButton.clipsToBounds = YES;
    WithdrawalButton.layer.cornerRadius = 5;
    WithdrawalButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [WithdrawalButton setTitle:@"确认提现" forState:UIControlStateNormal];
    [WithdrawalButton addTarget:self action:@selector(Withdrawal:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:WithdrawalButton];
    
    UILabel *CanCarryLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, secondView.mj_h-35, secondView.mj_w-40, 25)];
    CanCarryLabel.text = [NSString stringWithFormat:@"可提现%.2f元",self.resultDic];
    CanCarryLabel.font = [UIFont systemFontOfSize:13];
    CanCarryLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    CanCarryLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:CanCarryLabel];

}


#pragma mark  支付方式


#pragma mark  确认提现
-(void)Withdrawal:(UIButton *)sender
{
    sender.enabled = NO;
    if ([amountTextField.text doubleValue] > self.resultDic) {
        amountTextField.text = [NSString stringWithFormat:@"%.2f",self.resultDic];
    }
    if (amountTextField.text.length == 0) {
        [self showErrorWithTitle:@"提现金额不得为空" autoCloseTime:2];
    }else if (payTextField.text.length == 0)
    {
        [self showErrorWithTitle:@"支付宝帐号不得为空" autoCloseTime:2];
    }else if (amountTextField.text.length != 0 && payTextField.text != 0)
    {
        NSLog(@"确认提现");
        [self httpRequest];
    }
    sender.enabled = YES;
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/ExtractingAmount/AlipayAccount",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", amountTextField.text,@"ExtractingAmount",payTextField.text,@"AlipayAccount",[NSString stringWithFormat:@"%.2f",self.resultDic],@"ExtraAccountBalance", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            [self showRightWithTitle:@"提交成功余额将在24小时内到账" autoCloseTime:2];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self showErrorWithTitle:@"提现失败" autoCloseTime:2];
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

