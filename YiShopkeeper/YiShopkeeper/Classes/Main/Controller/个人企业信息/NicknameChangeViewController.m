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
    }else
    {
        if ([self isSocialCredit18Number:_NicknameChangeTextField.text]) {
            
            if (_NicknameChangeTextField.text.length != 0) {
                if (_block != nil) {
                    _block(_NicknameChangeTextField.text);
                }
            }
        }
        else
        {
           [self showInfoWithTitle:@"社会信用代码错误" autoCloseTime:2];
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

- (BOOL)isSocialCredit18Number:(NSString *)socialCreditNum
{
    if(socialCreditNum.length != 18){
        return NO;
    }
    
    NSString *scN = @"^([0-9ABCDEFGHJKLMNPQRTUWXY]{2})([0-9]{6})([0-9ABCDEFGHJKLMNPQRTUWXY]{9})([0-9Y])$";
    NSPredicate *regextestSCNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", scN];
    if (![regextestSCNum evaluateWithObject:socialCreditNum]) {
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
