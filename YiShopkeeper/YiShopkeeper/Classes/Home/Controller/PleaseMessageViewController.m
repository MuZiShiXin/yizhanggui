//
//  PleaseMessageViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "PleaseMessageViewController.h"
#import "PlaceholderTextView.h"
@interface PleaseMessageViewController ()<UITextViewDelegate>

@end

@implementation PleaseMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"留言";
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    
    PlaceholderTextView *contentContactInformationTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 242.5)];
    contentContactInformationTextView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    contentContactInformationTextView.delegate = self;
    contentContactInformationTextView.placeholder = @"输入内容...";
    contentContactInformationTextView.font = [UIFont systemFontOfSize:15];
    contentContactInformationTextView.maxLength = 200;
    [self.view addSubview:contentContactInformationTextView];
    
    [contentContactInformationTextView didChangeText:^(PlaceholderTextView *textView) {
        NSLog(@"%@",textView.text);
    }];
    
    UIButton *TIJiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight - 45, kScreenWidth, 45)];
    TIJiaoButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBlueColor];
    [TIJiaoButton setTitle:@"提交" forState:UIControlStateNormal];
    [TIJiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    TIJiaoButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [TIJiaoButton addTarget:self action:@selector(TiJiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TIJiaoButton];
    
}
#pragma mark 提交
- (void)TiJiaoBtn
{
    NSLog(@"提交");
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
