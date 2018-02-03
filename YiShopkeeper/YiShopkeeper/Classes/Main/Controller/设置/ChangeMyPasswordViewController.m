//  修改密码
//  ChangeMyPasswordViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "ChangeMyPasswordViewController.h"

@interface ChangeMyPasswordViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *qingshurumima;
@property (strong, nonatomic) IBOutlet UITextField *qingshuryanzhengma;
@property (strong, nonatomic) IBOutlet UIButton *huoquyanzhengmaButton;
@property (strong, nonatomic) IBOutlet UILabel *shoujihaoLabel;



@end

@implementation ChangeMyPasswordViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = @"修改密码";
    _huoquyanzhengmaButton.clipsToBounds = YES;
    _huoquyanzhengmaButton.layer.cornerRadius = 5;
    _qingshurumima.delegate = self;
    
    NSString *qiansanwei = [Global.userName substringToIndex:3];
    NSString *housiwei = [Global.userName substringFromIndex:7];
    self.shoujihaoLabel.text = [NSString stringWithFormat:@"%@****%@",qiansanwei,housiwei];
    
    [self.qingshurumima setSecureTextEntry:YES];
    [_qingshurumima addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _shoujihaoLabel.text = _jiamishoujihao;
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
    if (textField == _qingshurumima) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}


#pragma mark 确认修改
- (IBAction)querenxiugai {
    NSLog(@"确认修改");
    if (_qingshurumima.text.length == 0) {
        NSLog(@"请输入密码");
        [self showErrorWithTitle:@"请输入密码" autoCloseTime:2];
        return;
    }else if (_qingshurumima.text.length > 20)
    {
        NSLog(@"密码不得超过20位");
        [self showErrorWithTitle:@"密码不得超过20位" autoCloseTime:2];
        return;
    }else if (_qingshurumima.text.length < 6)
    {
        NSLog(@"密码不得少于6位");
        [self showErrorWithTitle:@"密码不得少于6位" autoCloseTime:2];
        return;
    }else if (_qingshuryanzhengma.text.length == 0)
    {
        [self showErrorWithTitle:@"验证码不能为空" autoCloseTime:2];
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/zhanghuanquan",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", _qingshurumima.text,@"password",_qingshuryanzhengma.text,@"phoneVerCode",@(2),@"type",Global.userName,@"phone",nil];
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj objectForKey:@"result"] integerValue];
        if (result == 1) {
            [self showRightWithTitle:@"修改成功" autoCloseTime:2];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self showErrorWithTitle:@"修改失败" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
}
#pragma mark 获取验证码
- (IBAction)huoquduanxinyanzhengma {
    NSLog(@"获取验证码");
    if (_qingshurumima.text.length == 0) {
        NSLog(@"请输入密码");
        [self showErrorWithTitle:@"请输入密码" autoCloseTime:2];
        return;
    }else if (_qingshurumima.text.length > 20)
    {
        NSLog(@"密码不得超过20位");
        [self showErrorWithTitle:@"密码不得超过20位" autoCloseTime:2];
        return;
    }else if (_qingshurumima.text.length < 6)
    {
        NSLog(@"密码不得少于6位");
        [self showErrorWithTitle:@"密码不得少于6位" autoCloseTime:2];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/moble/phoneVerCode",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_qingshurumima.text,@"phone", nil];
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
                [_huoquyanzhengmaButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [_huoquyanzhengmaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _huoquyanzhengmaButton.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [_huoquyanzhengmaButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [_huoquyanzhengmaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _huoquyanzhengmaButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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
