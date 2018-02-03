//  修改手机号
//  ModifyYourPhoneNumberViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "ModifyYourPhoneNumberViewController.h"

@interface ModifyYourPhoneNumberViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *OldShouJiHao;
@property (strong, nonatomic) IBOutlet UITextField *xinshoujihao;
@property (strong, nonatomic) IBOutlet UITextField *yanzhengma;
@property (strong, nonatomic) IBOutlet UIButton *yanzhengmaButton;

@end

@implementation ModifyYourPhoneNumberViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = @"修改手机号";
    _yanzhengmaButton.clipsToBounds = YES;
    _yanzhengmaButton.layer.cornerRadius = 5;
    _xinshoujihao.delegate = self;
    [_xinshoujihao addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _OldShouJiHao.text = _jiamishoujihao;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}


#pragma mark 获取验证码
- (IBAction)huoquduanxinyanzhengma {
    NSLog(@"获取验证码");
    if ([self valiMobile:_xinshoujihao.text] == 1) {
        NSLog(@"手机号长度只能是11位");
        [self showErrorWithTitle:@"手机号长度只能是11位" autoCloseTime:2];

        return;
    }else if ([self valiMobile:_xinshoujihao.text] == 2)
    {
        NSLog(@"请输入正确的电话号码");
        [self showErrorWithTitle:@"请输入正确的电话号码" autoCloseTime:2];

        return;
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/moble/phoneVerCode",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_xinshoujihao.text,@"phone", nil];
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
                [_yanzhengmaButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [_yanzhengmaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _yanzhengmaButton.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [_yanzhengmaButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [_yanzhengmaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _yanzhengmaButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark 确认修改
- (IBAction)querenxiugai {
    NSLog(@"确认修改");
    if ([self valiMobile:_xinshoujihao.text] == 1) {
        NSLog(@"手机号长度只能是11位");
        [self showErrorWithTitle:@"手机号长度只能是11位" autoCloseTime:2];
        return;
    }else if ([self valiMobile:_xinshoujihao.text] == 2)
    {
        NSLog(@"请输入正确的电话号码");
        [self showErrorWithTitle:@"请输入正确的电话号码" autoCloseTime:2];
        return;
    }else if (_yanzhengma.text.length == 0)
    {
        [self showErrorWithTitle:@"验证码不能为空" autoCloseTime:2];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/zhanghuanquan",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", _xinshoujihao.text,@"phone",_yanzhengma.text,@"phoneVerCode",@(1),@"type", nil];
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj objectForKey:@"result"] integerValue];
        if (result == 1) {
            [self showRightWithTitle:@"修改成功" autoCloseTime:2];
            Global.userName = _xinshoujihao.text;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [self showErrorWithTitle:@"修改失败" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];

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
    if (textField == _xinshoujihao) {
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
