//  昵称
//  NicknameChangeViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/27.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "NicknameChangeViewController.h"

@interface NicknameChangeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *NicknameChangeTextField;

@end

@implementation NicknameChangeViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = _BiaoTiTitleLabelText;
    
    if ([_BiaoTiTitleLabelText isEqualToString:@"昵称"]) {
        _NicknameChangeTextField.placeholder = @"10个字之内";
    }else if ([_BiaoTiTitleLabelText isEqualToString:@"身份证号"])
    {
        _NicknameChangeTextField.placeholder = @"请输入身份证号";

    }else if ([_BiaoTiTitleLabelText isEqualToString:@"社会信用代码"])
    {
        _NicknameChangeTextField.placeholder = @"请输入信用代码";
    }
    
    _NicknameChangeTextField.delegate = self;
    _NicknameChangeTextField.clearButtonMode = UITextFieldViewModeAlways;
    [_NicknameChangeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
}
#pragma mark 确定按钮
- (IBAction)determineButton {
    NSLog(@"确定");
    if ([_BiaoTiTitleLabelText isEqualToString:@"昵称"]) {
        NSLog(@"昵称确认");
        if (_NicknameChangeTextField.text.length != 0) {
            if (_block != nil) {
                _block(_NicknameChangeTextField.text);
            }
        }
    }else if([_BiaoTiTitleLabelText isEqualToString:@"身份证号"])
    {
        if ([self checkUserID:_NicknameChangeTextField.text]) {
                if (_block != nil) {
                    _block(_NicknameChangeTextField.text);
                }
            }
    }else{
        if ([self isSocialCredit18Number:_NicknameChangeTextField.text]) {
            
            if (_NicknameChangeTextField.text.length != 0) {
                if (_block != nil) {
                    _block(_NicknameChangeTextField.text);
                }
            }
        }
        NSLog(@"信用代码确认");
    }
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

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark 限制输入字数
- (void)textFieldDidChange:(UITextField *)textField
{
    UITextRange *rang = textField.markedTextRange; // 获取非=选中状态文字范围
    if (rang == nil) { // 没有非选中状态文字.就是确定的文字输入
        if (textField == _NicknameChangeTextField &&[_BiaoTiTitleLabelText isEqualToString:@"昵称"]) {
            if (textField.text.length > 10) {
                textField.text = [textField.text substringToIndex:10];
            }
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        [self.view showErrorWithTitle:@"身份证号为18位" autoCloseTime:2];
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        [self.view showInfoWithTitle:@"请输入正确身份证号码" autoCloseTime:2];
        return flag;    //格式错误
        
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                [self.view showInfoWithTitle:@"请输入正确身份证号码" autoCloseTime:2];
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                [self.view showInfoWithTitle:@"请输入正确身份证号码" autoCloseTime:2];
                return NO;
            }
        }
    }
}






- (BOOL)isSocialCredit18Number:(NSString *)socialCreditNum
{
    if(socialCreditNum.length != 18){
        [self.view showInfoWithTitle:@"请输入正确企业信用代码" autoCloseTime:2];
        return NO;
    }
    
    NSString *scN = @"^([0-9ABCDEFGHJKLMNPQRTUWXY]{2})([0-9]{6})([0-9ABCDEFGHJKLMNPQRTUWXY]{9})([0-9Y])$";
    NSPredicate *regextestSCNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", scN];
    if (![regextestSCNum evaluateWithObject:socialCreditNum]) {
        [self.view showInfoWithTitle:@"请输入正确企业信用代码" autoCloseTime:2];
        return NO;
    }
    
    NSArray *ws = @[@1,@3,@9,@27,@19,@26,@16,@17,@20,@29,@25,@13,@8,@24,@10,@30,@28];
    NSDictionary *zmDic = @{@"A":@10,@"B":@11,@"C":@12,@"D":@13,@"E":@14,@"F":@15,@"G":@16,@"H":@17,@"J":@18,@"K":@19,@"L":@20,@"M":@21,@"N":@22,@"P":@23,@"Q":@24,@"R":@25,@"T":@26,@"U":@27,@"W":@28,@"X":@29,@"Y":@30};
    NSMutableArray *codeArr = [NSMutableArray array];
    NSMutableArray *codeArr2 = [NSMutableArray array];
    
    codeArr[0] = [socialCreditNum substringWithRange:NSMakeRange(0,socialCreditNum.length-1)];
    codeArr[1] = [socialCreditNum substringWithRange:NSMakeRange(socialCreditNum.length-1,1)];
    
    int sum = 0;
    
    for (int i = 0; i < [codeArr[0] length]; i++) {
        
        [codeArr2 addObject:[codeArr[0] substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSScanner* scan;
    int val;
    for (int j = 0; j < codeArr2.count; j++) {
        scan = [NSScanner scannerWithString:codeArr2[j]];
        if (![scan scanInt:&val] && ![scan isAtEnd]) {
            codeArr2[j] = zmDic[codeArr2[j]];
        }
    }
    
    
    for (int x = 0; x < codeArr2.count; x++) {
        sum += [ws[x] intValue]*[codeArr2[x] intValue];
    }
    
    
    int c18 = 31 - (sum % 31);
    
    for (NSString *key in zmDic.allKeys) {
        
        if (zmDic[key]==[NSNumber numberWithInt:c18]) {
            if (![codeArr[1] isEqualToString:key]) {
                [self.view showInfoWithTitle:@"请输入正确企业信用代码" autoCloseTime:2];
                return NO;
            }
        }
    }
    
    return YES;
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
