//
//  RegistrationViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/21.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "RegistrationViewController.h"
#import "UILabel+HeightANDWidth.h"
@interface RegistrationViewController ()
{
    UIButton *EnterpriseB; //企业
    UIButton *IndividualB;  //个人
    UIImageView * eAndi;
    UIView *eView;
    UIView *iView;
    
    NSInteger numbering;   //企业1 个人2
    UITextField *userPhone;         //手机号
    UITextField *validationCode;    //验证码
    UIButton    *getVerificationcCode; //登录按钮
    UITextField *enterpriseCipher;  //企业密码
    UITextField *againenterpriseCipher;  //企业密码
    
}
@end
@implementation RegistrationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLabel.text = @"注册";
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    numbering = 1;
    [self initEnterpriseAndIndividual];

}

#pragma mark
- (void)initEnterpriseAndIndividual
{
    EnterpriseB = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth/2, 55)];
    [EnterpriseB setTitle:@"企业" forState:UIControlStateNormal];
    [EnterpriseB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
    [EnterpriseB addTarget:self action:@selector(enterpriseAndindividual:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:EnterpriseB];
    
    eView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(EnterpriseB.frame), EnterpriseB.mj_w, 2)];
    eView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    [self.view addSubview:eView];
    
    iView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(EnterpriseB.frame), EnterpriseB.mj_w, 2)];
    iView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e9e9e9"];
    [self.view addSubview:iView];
    
    IndividualB = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2, 64, kScreenWidth/2, 55)];
    [IndividualB setTitle:@"个人" forState:UIControlStateNormal];
    [IndividualB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"999999"] forState:UIControlStateNormal];
    [IndividualB addTarget:self action:@selector(enterpriseAndindividual:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:IndividualB];
    [self initForgetPasswordView];
    
    eAndi = [[UIImageView alloc]initWithFrame:CGRectMake((EnterpriseB.mj_w - 16)/2,CGRectGetMaxY(eView.frame)-8 , 16, 8)];
    eAndi.image = [UIImage imageNamed:@"yg_zc_tb1"];
    [self.view addSubview:eAndi];
}

- (void)initForgetPasswordView
{
    UILabel *userPhoneL = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(IndividualB.frame), 40,55)];
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
    
    UILabel *cipherL1 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(SegmentationV2.frame), 40,55)];
    cipherL1.text = @"密码";
    cipherL1.textColor = [UIColor blackColor];
    cipherL1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cipherL1];
    
    enterpriseCipher = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, cipherL1.mj_origin.y, 300, 55)];
    enterpriseCipher.placeholder = @"请输入密码";
    enterpriseCipher.delegate = self;
    [enterpriseCipher setSecureTextEntry:YES];
    enterpriseCipher.clearButtonMode = UITextFieldViewModeAlways;
    enterpriseCipher.font = [UIFont systemFontOfSize:15];
    [enterpriseCipher addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:enterpriseCipher];
    
    
    UIView *SegmentationV3 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(enterpriseCipher.frame), kScreenWidth-30, 1)];
    SegmentationV3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV3];
    
    UILabel *cipherL2 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(SegmentationV3.frame), 100,55)];
    cipherL2.text = @"确认密码";
    cipherL2.textColor = [UIColor blackColor];
    cipherL2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cipherL2];
    
    againenterpriseCipher = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, cipherL2.mj_origin.y, 300, 55)];
    againenterpriseCipher.placeholder = @"请再次输入密码";
    againenterpriseCipher.delegate = self;
    [againenterpriseCipher setSecureTextEntry:YES];
    againenterpriseCipher.clearButtonMode = UITextFieldViewModeAlways;
    againenterpriseCipher.font = [UIFont systemFontOfSize:15];
    [againenterpriseCipher addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:againenterpriseCipher];
    
    
    UIView *SegmentationV4 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(againenterpriseCipher.frame), kScreenWidth-30, 1)];
    SegmentationV4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV4];
    
    
    UIButton *NextB = [[UIButton alloc]initWithFrame:CGRectMake(SegmentationV4.frame.origin.x, SegmentationV4.frame.origin.y + SegmentationV4.frame.size.height + 35, SegmentationV4.frame.size.width, 40)];
    NextB.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    NextB.clipsToBounds = YES;
    NextB.layer.cornerRadius = 5;
    NextB.titleLabel.font = [UIFont systemFontOfSize:15];
    [NextB setTitle:@"注 册" forState:UIControlStateNormal];
    [NextB addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NextB];
    
    
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"已有帐号,立即";
    labelTwo.textColor = [UIColor blackColor];
    labelTwo.backgroundColor = [UIColor clearColor];
    labelTwo.font = [UIFont systemFontOfSize:15];
    CGFloat width = [UILabel getWidthWithTitle:labelTwo.text font:labelTwo.font];
    labelTwo.frame = CGRectMake((kScreenWidth-width)/2, CGRectGetMaxY(NextB.frame)+15, width, 15);
    [self.view addSubview:labelTwo];
    
    UIButton *loginB = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelTwo.frame), labelTwo.mj_origin.y, 40, 15)];
    [loginB setTitle:@"登录" forState:UIControlStateNormal];
    [loginB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:(UIControlState)UIControlStateNormal];
    loginB.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginB addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginB];
}

#pragma mark 企业0 个人1
- (void)enterpriseAndindividual:(UIButton*)btn
{
    [eAndi removeFromSuperview];
    if (btn == EnterpriseB) {
        numbering = 1;
        [EnterpriseB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
        [IndividualB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"999999"] forState:UIControlStateNormal];
        eView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
        iView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e9e9e9"];
        eAndi = [[UIImageView alloc]initWithFrame:CGRectMake((EnterpriseB.mj_w - 16)/2,CGRectGetMaxY(eView.frame)-8 , 16, 8)];
        eAndi.image = [UIImage imageNamed:@"yg_zc_tb1"];
        [self.view addSubview:eAndi];
        
        
    }else
    {
        numbering = 2;
        [EnterpriseB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"999999"] forState:UIControlStateNormal];
        [IndividualB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
        eView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"e9e9e9"];
        iView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
        eAndi = [[UIImageView alloc]initWithFrame:CGRectMake(IndividualB.mj_x + (IndividualB.mj_w - 16)/2,CGRectGetMaxY(eView.frame)-8 , 16, 8)];
        eAndi.image = [UIImage imageNamed:@"yg_zc_tb1"];
        [self.view addSubview:eAndi];
        
    }
}

#pragma mark 注册
-(void)next:(UIButton *)btn
{
    NSLog(@"注册");
    btn.userInteractionEnabled = NO;
    if (enterpriseCipher.text.length == 0) {
        [self.view showInfoWithTitle:@"密码不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if (againenterpriseCipher.text.length == 0)
    {
        [self.view showInfoWithTitle:@"确认密码不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;

        return;
    }else if (enterpriseCipher.text.length < 6)
    {
        [self.view showInfoWithTitle:@"密码不得少于6位" autoCloseTime:2];
        btn.userInteractionEnabled = YES;

        return;
    }else if (againenterpriseCipher.text.length < 6)
    {
        [self.view showInfoWithTitle:@"确认密码不得少于6位" autoCloseTime:2];
        btn.userInteractionEnabled = YES;

        return;
    }
    
    if ([enterpriseCipher.text isEqualToString:againenterpriseCipher.text]) {
        NSString *urlStr = [NSString stringWithFormat:@"%@/user/regist",kPRTURL];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    userPhone.text,@"phone",enterpriseCipher.text,@"password",validationCode.text,@"phoneVerCode",@(numbering),@"userType", nil];
        
        [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj objectForKey:@"result"] integerValue];
            if (result == 1) {
                [self showRightWithTitle:@"注册成功" autoCloseTime:2];
                
                if (_block != nil) {
                    _block(userPhone.text,enterpriseCipher.text);
                }
                btn.userInteractionEnabled = YES;
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                btn.userInteractionEnabled = YES;
                [self showErrorWithTitle:@"注册失败" autoCloseTime:2];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
        }];
    }else
    {
        btn.userInteractionEnabled = YES;
        [self.view showInfoWithTitle:@"密码不一致请重新输入" autoCloseTime:2];
        return;
    }
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
        NSLog(@"%@",responseObj);
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
#pragma mark 登录
- (void)login
{
    NSLog(@"登录");
    [self.navigationController popToRootViewControllerAnimated:YES];
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


@end
