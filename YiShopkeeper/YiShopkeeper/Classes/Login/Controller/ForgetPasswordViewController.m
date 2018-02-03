//
//  ForgetPasswordViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/21.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ModificationPWViewController.h"
@interface ForgetPasswordViewController ()
{
    UITextField *userPhone;         //手机号
    UITextField *validationCode;    //验证码
    UIButton *getVerificationcCode; //登录按钮
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLabel.text = @"忘记密码";
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    // Do any additional setup after loading the view.
    
    [self initForgetPasswordView];
}

- (void)initForgetPasswordView
{
    UIView *SegmentationV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 1)];
    SegmentationV.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e4eaee"];
    [self.view addSubview:SegmentationV];
    
    UILabel *userPhoneL = [[UILabel alloc]initWithFrame:CGRectMake(30, 76, 40,55)];
    userPhoneL.text = @"帐号";
    userPhoneL.textColor = [UIColor blackColor];
    userPhoneL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:userPhoneL];
    
    userPhone = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, userPhoneL.frame.origin.y, 300, 55)];
    userPhone.placeholder =@"请输入手机号码";
    userPhone.keyboardType = UIKeyboardTypeNumberPad;
    userPhone.delegate = self;
    userPhone.font = [UIFont systemFontOfSize:15];
    [userPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userPhone];
    
    UIView *SegmentationV1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(userPhone.frame), kScreenWidth-30, 1)];
    SegmentationV1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV1];
    
    UILabel *cipherL = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(SegmentationV1.frame), 100,55)];
    cipherL.text = @"验证码";
    cipherL.textColor = [UIColor blackColor];
    cipherL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cipherL];
    
    validationCode = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, cipherL.mj_origin.y, 150, 56.5)];
    validationCode.placeholder =@"请输入验证码";
    validationCode.keyboardType = UIKeyboardTypeNumberPad;
    validationCode.delegate = self;
    validationCode.font = [UIFont systemFontOfSize:15];
    [validationCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:validationCode];
    
    
    getVerificationcCode = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-115,CGRectGetMaxY(SegmentationV1.frame)+(validationCode.mj_h - 35)/2, 100, 35)];
    getVerificationcCode.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    [getVerificationcCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerificationcCode.clipsToBounds = YES;
    getVerificationcCode.layer.cornerRadius = 5;
    getVerificationcCode.titleLabel.font = [UIFont systemFontOfSize:15];
    [getVerificationcCode addTarget:self action:@selector(getVerificationcCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerificationcCode];
    
    
    UIView *SegmentationV2 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(validationCode.frame), kScreenWidth-30, 1)];
    SegmentationV2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV2];
    
    UIButton *NextB = [[UIButton alloc]initWithFrame:CGRectMake(SegmentationV2.frame.origin.x, SegmentationV2.frame.origin.y + SegmentationV2.frame.size.height + 35, SegmentationV2.frame.size.width, 40)];
    NextB.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    NextB.clipsToBounds = YES;
    NextB.layer.cornerRadius = 5;
    NextB.titleLabel.font = [UIFont systemFontOfSize:15];
    [NextB setTitle:@"下一步" forState:UIControlStateNormal];
    [NextB addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NextB];
    
}

#pragma mark 下一步
-(void)next
{
    NSLog(@"下一步");
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/mima",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:userPhone.text,@"phone",validationCode.text,@"phoneVerCode", nil];
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj objectForKey:@"result"] intValue];
//        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        
        if (result == 1) {
//            [self showRightWithTitle:@"验证码发送成功" autoCloseTime:2];
            ModificationPWViewController *ModificationPWVC = [[ModificationPWViewController alloc]init];
            ModificationPWVC.phoneNumber = userPhone.text;
            [self.navigationController pushViewController:ModificationPWVC animated:YES];
        }else
        {
            NSLog(@"验证码发送失败");
            [self showErrorWithTitle:@"请填写正确验证码" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
    
}

#pragma mark 获取验证码
- (void)getVerificationcCode
{
    if ([self valiMobile:userPhone.text] == 1) {
        NSLog(@"手机号长度只能是11位");
        [self showErrorWithTitle:@"手机号长度只能是11位" autoCloseTime:2];

        return;
    }else if ([self valiMobile:userPhone.text] == 2)
    {
        NSLog(@"请输入正确的电话号码");
        [self showErrorWithTitle:@"请输入正确的电话号码" autoCloseTime:2];

        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/moble/phoneVerCode",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:userPhone.text,@"phone", nil];
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        if ([responseObj objectForKey:@"result"]) {
            NSLog(@"验证码发送成功");
            [self showRightWithTitle:@"验证码发送成功" autoCloseTime:2];
        }else
        {
            NSLog(@"验证码发送失败");
            [self showErrorWithTitle:@"验证码发送失败" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];

    __block NSInteger time = 59; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [getVerificationcCode setTitle:@"重新发送" forState:UIControlStateNormal];
                [getVerificationcCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                getVerificationcCode.userInteractionEnabled = YES;
            });

        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [getVerificationcCode setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [getVerificationcCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                getVerificationcCode.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark TextField代理方法
//限制输入字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == userPhone) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}



#pragma mark 手机号正则表达式
- (NSInteger)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return 1;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(175)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return 0;
        }else{
            return 2;
        }
    }
    return 0;
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
