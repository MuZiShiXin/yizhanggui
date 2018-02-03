//
//  ModificationPWViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/22.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "ModificationPWViewController.h"

@interface ModificationPWViewController ()
{
    UITextField *NewsPasswordTF;         //密码
    UITextField *ConfirmPasswordTF;      //确认密码
    UIButton    *getVerificationcCode;   //确定按钮
}
@end

@implementation ModificationPWViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titelLabel.text = @"忘记密码";
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initConfirmPasswordV];
}

- (void)initConfirmPasswordV
{
    UILabel *userPhoneL = [[UILabel alloc]initWithFrame:CGRectMake(30, 76, 40,55)];
    userPhoneL.text = @"密码";
    userPhoneL.textColor = [UIColor blackColor];
    userPhoneL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:userPhoneL];
    
    NewsPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, userPhoneL.frame.origin.y, 300, 55)];
    NewsPasswordTF.placeholder =@"请输入新密码";
    NewsPasswordTF.delegate = self;
    [NewsPasswordTF setSecureTextEntry:YES];
    NewsPasswordTF.clearButtonMode = UITextFieldViewModeAlways;
    NewsPasswordTF.font = [UIFont systemFontOfSize:15];
    [NewsPasswordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:NewsPasswordTF];
    
    UIView *SegmentationV = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(NewsPasswordTF.frame), kScreenWidth-30, 1)];
    SegmentationV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV];
    
    UILabel *cipherL = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(SegmentationV.frame), 70,55)];
    cipherL.text = @"确认密码";
    cipherL.textColor = [UIColor blackColor];
    cipherL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cipherL];
    
    ConfirmPasswordTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, cipherL.mj_origin.y, 300, 55)];
    ConfirmPasswordTF.placeholder =@"请输入确认密码";
    ConfirmPasswordTF.delegate = self;
    [ConfirmPasswordTF setSecureTextEntry:YES];
    ConfirmPasswordTF.clearButtonMode = UITextFieldViewModeAlways;
    ConfirmPasswordTF.font = [UIFont systemFontOfSize:15];
    [ConfirmPasswordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:ConfirmPasswordTF];
    
    UIView *SegmentationV1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(ConfirmPasswordTF.frame), kScreenWidth-30, 1)];
    SegmentationV1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV1];
    
    UIButton *determineB = [[UIButton alloc]initWithFrame:CGRectMake(SegmentationV1.frame.origin.x, SegmentationV1.frame.origin.y + SegmentationV1.frame.size.height + 35, SegmentationV1.frame.size.width, 40)];
    determineB.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    determineB.clipsToBounds = YES;
    determineB.layer.cornerRadius = 5;
    determineB.titleLabel.font = [UIFont systemFontOfSize:15];
    [determineB setTitle:@"立即登录" forState:UIControlStateNormal];
    [determineB addTarget:self action:@selector(determineB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:determineB];
    
}

#pragma mark TextField代理方法
//限制输入字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}
#pragma mark  确认密码
-(void)determineB
{
    NSLog(@"确认");
    
    if (![NewsPasswordTF.text isEqualToString:
         ConfirmPasswordTF.text]) {
        NSLog(@"两侧密码输入错误");
        [self showErrorWithTitle:@"密码输入不一致" autoCloseTime:2];
        return;
    }else if (NewsPasswordTF.text.length == 0)
    {
        [self showErrorWithTitle:@"密码不能为空" autoCloseTime:2];
        return;
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/mima",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneNumber,@"phone",NewsPasswordTF.text,@"phoneVerCode", nil];
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj objectForKey:@"result"] intValue];
        //        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        
        if (result == 1) {
            NSLog(@"更改密码成功");
            [self showRightWithTitle:@"密码更改成功" autoCloseTime:2];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            NSLog(@"更改密码失败");
            [self showErrorWithTitle:@"密码更改失败" autoCloseTime:2];

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
