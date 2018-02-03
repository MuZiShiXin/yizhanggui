//  注销帐号
//  LogoutAccountNumberViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "LogoutAccountNumberViewController.h"
#import "AppDelegate.h"
@interface LogoutAccountNumberViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *shurumima;
@property (strong, nonatomic) IBOutlet UITextField *yanzhengma;
@property (strong, nonatomic) IBOutlet UIButton *huoquyanzhengma;

@end

@implementation LogoutAccountNumberViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = @"注销帐号";
    _huoquyanzhengma.clipsToBounds = YES;
    _huoquyanzhengma.layer.cornerRadius = 5;
    _shurumima.delegate = self;
    [_shurumima addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}




#pragma mark 点击resign收起键盘
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 点击空白收起键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark TextField代理方法
//限制输入字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _shurumima) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}



#pragma mark 获取验证码
- (IBAction)huoquyanzhengmaBtn {
    NSLog(@"获取验证码");
    if (_shurumima.text.length == 0) {
        NSLog(@"请输入密码");
        [self showErrorWithTitle:@"请输入密码" autoCloseTime:2];

        return;
    }else if (_shurumima.text.length > 20)
    {
        NSLog(@"密码不得超过20位");
        [self showErrorWithTitle:@"密码不得超过20位" autoCloseTime:2];

        return;
    }else if (_shurumima.text.length < 6)
    {
        NSLog(@"密码不得少于6位");
        [self showErrorWithTitle:@"密码不得少于6位" autoCloseTime:2];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/moble/phoneVerCode",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_shurumima.text,@"phone", nil];
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
                [_huoquyanzhengma setTitle:@"重新发送" forState:UIControlStateNormal];
                [_huoquyanzhengma setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _huoquyanzhengma.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [_huoquyanzhengma setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [_huoquyanzhengma setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _huoquyanzhengma.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}


#pragma mark 确认注销
- (IBAction)querenzhuxiao {
    NSLog(@"确认注销");
    NSLog(@"确认修改");
    if (_shurumima.text.length == 0) {
        NSLog(@"请输入密码");
        [self showErrorWithTitle:@"请输入密码" autoCloseTime:2];
        return;
    }else if (_shurumima.text.length > 20)
    {
        NSLog(@"密码不得超过20位");
        [self showErrorWithTitle:@"密码不得超过20位" autoCloseTime:2];
        return;
    }else if (_shurumima.text.length < 6)
    {
        NSLog(@"密码不得少于6位");
        [self showErrorWithTitle:@"密码不得少于6位" autoCloseTime:2];
        return;
    }else if (_yanzhengma.text.length == 0)
    {
        [self showErrorWithTitle:@"验证码不能为空" autoCloseTime:2];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/zhanghuanquan",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", _shurumima.text,@"password",_yanzhengma.text,@"phoneVerCode", @(3),@"type", nil];
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        if ([responseObj objectForKey:@"result"]) {
            [self showRightWithTitle:@"注销成功" autoCloseTime:2];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:@"params"];
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [app setUpLoginToMainPage];
        }else
        {
            NSLog(@"验证码发送失败");
            [self showErrorWithTitle:@"注销失败" autoCloseTime:2];
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
