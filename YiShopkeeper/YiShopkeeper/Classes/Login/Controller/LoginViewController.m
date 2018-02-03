//
//  LoginViewController.m
//  decorateaSmallTwo
//
//  Created by  apple on 2017/9/14.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "LoginViewController.h"
//#import "BaseTabBarController.h"
//#import "BaseNavigationController.h"
#import "RegistrationViewController.h" //注册
#import "ForgetPasswordViewController.h"//忘记密码
#import "AppDelegate.h"
#import "RankingTotalModel.h"

@interface LoginViewController ()
{
    UITextField *userPhone;         //手机号
    UITextField *cipherTF;          //密码
    UIButton *getVerificationcCode; //登录按钮
}
@property (strong ,nonatomic)RankingTotalModel *model;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}

- (void)initView
{
    UIImageView *headingsIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    headingsIV.image = [UIImage imageNamed:@"yg_dl_tp1"];
    headingsIV.userInteractionEnabled = YES;
    [self.view addSubview:headingsIV];

    UILabel *headingsL = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, 50)];
    headingsL.text = @"98易工";
    headingsL.font = [UIFont systemFontOfSize:50];
    headingsL.textColor = [UIColor whiteColor];
    headingsL.textAlignment = NSTextAlignmentCenter;

    [headingsIV addSubview:headingsL];
    
    UILabel *describeL = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headingsL.frame)+15, kScreenWidth, 15)];
    describeL.text = @"急速面试  当天填写简历当天面试";
    describeL.textAlignment = NSTextAlignmentCenter;
    describeL.textColor = [UIColor whiteColor];
    [headingsIV addSubview:describeL];
    
    UIButton *LoginBL = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headingsIV.frame)-34, 120, 15)];
    [LoginBL setTitle:@"登录" forState:UIControlStateNormal];
    [LoginBL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LoginBL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [headingsIV addSubview:LoginBL];
    
    UIButton *RegistrationBL = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-120, CGRectGetMaxY(headingsIV.frame)-34, 120, 15)];
    [RegistrationBL setTitle:@"注册" forState:UIControlStateNormal];
    [RegistrationBL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegistrationBL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [RegistrationBL addTarget:self action:@selector(registration) forControlEvents:UIControlEventTouchUpInside];
    [headingsIV addSubview:RegistrationBL];
    
    UILabel *userPhoneL = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(headingsIV.frame), 40,55)];
    userPhoneL.text = @"帐号";
    userPhoneL.textColor = [UIColor blackColor];
    userPhoneL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:userPhoneL];
    
    userPhone = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, userPhoneL.frame.origin.y, kScreenWidth-(CGRectGetMaxX(userPhoneL.frame)+50+15), 55)];
    userPhone.placeholder =@"请输入手机号码";
    userPhone.keyboardType = UIKeyboardTypeNumberPad;
    userPhone.delegate = self;
    userPhone.clearButtonMode = UITextFieldViewModeAlways;
    userPhone.font = [UIFont systemFontOfSize:15];
    userPhone.clearButtonMode = UITextFieldViewModeAlways;
    [userPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userPhone];
    
    
    UIView *SegmentationV = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(userPhone.frame), kScreenWidth-30, 1)];
    SegmentationV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV];
    
    
    UILabel *cipherL = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(SegmentationV.frame), 40,55)];
    cipherL.text = @"密码";
    cipherL.textColor = [UIColor blackColor];
    cipherL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:cipherL];

    cipherTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userPhoneL.frame)+50, cipherL.mj_origin.y, kScreenWidth-(CGRectGetMaxX(userPhoneL.frame)+50+15), 55)];
    cipherTF.placeholder =@"请输入密码";
    cipherTF.delegate = self;
    cipherTF.font = [UIFont systemFontOfSize:15];
    [cipherTF setSecureTextEntry:YES];
    cipherTF.clearButtonMode = UITextFieldViewModeAlways;
    [cipherTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:cipherTF];

    UIView *SegmentationV1 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(cipherTF.frame), kScreenWidth-30, 1)];
    SegmentationV1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:SegmentationV1];

    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(SegmentationV1.frame.origin.x, SegmentationV1.frame.origin.y + SegmentationV1.frame.size.height + 35, SegmentationV1.frame.size.width, 40)];
    login.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    login.clipsToBounds = YES;
    login.layer.cornerRadius = 5;
    login.titleLabel.font = [UIFont systemFontOfSize:15];
    [login setTitle:@"立即登录" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    
    UIButton *ForgetPasswordB = [[UIButton alloc]initWithFrame:CGRectMake(SegmentationV1.frame.origin.x, CGRectGetMaxY(login.frame)+20, SegmentationV1.frame.size.width, 40)];
    [ForgetPasswordB setTitle:@"忘记密码" forState:UIControlStateNormal];
    [ForgetPasswordB setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
    ForgetPasswordB.titleLabel.font = [UIFont systemFontOfSize:15];
    [ForgetPasswordB addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:ForgetPasswordB];
    
}

#pragma mark 登录
-(void)login
{
    NSLog(@"登录");
    if (userPhone.text.length == 0) {
        [self showErrorWithTitle:@"手机号不能为空" autoCloseTime:2];

    }else if ([self valiMobile:userPhone.text] == 1) {
        NSLog(@"手机号长度只能是11位");
        [self showErrorWithTitle:@"手机号长度只能是11位" autoCloseTime:2];
        return;
    }else if ([self valiMobile:userPhone.text] == 2)
    {
        NSLog(@"请输入正确的电话号码");
        [self showErrorWithTitle:@"请输入正确的电话号码" autoCloseTime:2];
        
        return;
    }
    if (cipherTF.text.length < 6) {
        [self showErrorWithTitle:@"密码不得少于6位" autoCloseTime:2];
        return;
    }else if (cipherTF.text.length == 0)
    {
        [self showErrorWithTitle:@"密码不得为空" autoCloseTime:2];
        return;
    }
    [SVProgressHUD showWithStatus:@"登录中,请稍候..."];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *urlStr = [NSString stringWithFormat:@"%@/moble/login",kPRTURL];
//    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *deviceUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"registrationID"];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:userPhone.text,@"loginName",cipherTF.text,@"password",deviceUUID,@"jgSign", nil];
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {

        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
       

        if (result == 1) {
            [SVProgressHUD dismiss];
            NSLog(@"登录成功");
//            [self.dengl]
            NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            [RankingTotalModel creatRankingTotalModelWith:resultDic];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:resultDic forKey:@"params"];
            [userDefaults synchronize];
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [app setUpTabControllerToMainPage];
            
        }else
        {
            [self showErrorWithTitle:[responseObj valueForKey:@"message"] autoCloseTime:2];
            [SVProgressHUD dismiss];
            NSLog(@"登录失败");
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        [SVProgressHUD dismiss];

    }];
    
}
#pragma mark 忘记密码
-(void)forgetPassword
{
    NSLog(@"%@", self.navigationController);
    NSLog(@"忘记密码");
    ForgetPasswordViewController *ForgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:ForgetPasswordVC animated:YES];
}
-(void)registration
{
    NSLog(@"注册");
    RegistrationViewController *RegistrationVC = [[RegistrationViewController alloc]init];
    [RegistrationVC setBlock:^(NSString *zhanghao, NSString *mima) {
        [userPhone setText:zhanghao];
        [cipherTF setText:mima];
    }];
    [self.navigationController pushViewController:RegistrationVC animated:YES];
}

//#pragma mark 获取验证码
//- (void)getVerificationcCode
//{
//    if ([self valiMobile:userPhone.text] == 1) {
//        NSLog(@"手机号长度只能是11位");
//        return;
//    }else if ([self valiMobile:userPhone.text] == 2)
//    {
//        NSLog(@"请输入正确的电话号码");
//        return;
//    }
//
//    __block NSInteger time = 59; //倒计时时间
//
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//
//    dispatch_source_set_event_handler(_timer, ^{
//        if(time <= 0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置按钮的样式
//                [getVerificationcCode setTitle:@"重新发送" forState:UIControlStateNormal];
//                [getVerificationcCode setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                getVerificationcCode.userInteractionEnabled = YES;
//            });
//
//        }else{
//            int seconds = time % 60;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置按钮显示读秒效果
//                [getVerificationcCode setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
//                [getVerificationcCode setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                getVerificationcCode.userInteractionEnabled = NO;
//            });
//            time--;
//        }
//    });
//    dispatch_resume(_timer);
//}

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

- (void)dealloc
{
    NSLog(@"登录dealloc");
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
