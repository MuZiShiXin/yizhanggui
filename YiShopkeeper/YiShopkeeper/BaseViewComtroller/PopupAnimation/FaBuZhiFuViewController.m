//
//  FaBuZhiFuViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "FaBuZhiFuViewController.h"
#import "APOrderInfo.h"
#import "WXApi.h"
#import "HomeViewController.h"
@interface FaBuZhiFuViewController ()
@property (nonatomic ,strong) NSString *zhifuTy;
@end

@implementation FaBuZhiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zhifuTy = @"weixin";
    // Do any additional setup after loading the view from its nib.
    self.titelLabel.text = @"支付";
    [self listenNotifications];
    
    NSString *dateString = [NSString stringWithFormat:@"%@:01",[self.parameters objectForKey:@"kaiShi"]];
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setTimeZone:[NSTimeZone systemTimeZone]];
    [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *compareDate = [formate dateFromString:dateString];
    
    NSString *dateString1 = [NSString stringWithFormat:@"%@:01",[self.parameters objectForKey:@"jieShu"]];
    NSDateFormatter *formate1=[[NSDateFormatter alloc]init];
    [formate1 setTimeZone:[NSTimeZone systemTimeZone]];
    [formate1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *compareDate1 = [formate1 dateFromString:dateString1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:compareDate toDate:compareDate1 options:0];
    NSInteger xiashicha = dateCom.hour;
    NSInteger tiancha = dateCom.day;
    if (tiancha != 0) {
        tiancha = tiancha*8;
    }
    
    self.gongzuoshichangLabel.text = [NSString stringWithFormat:@"%ld小时",tiancha+xiashicha];
    
    
    self.gongzuobiaotiLabel.text = [self.parameters objectForKey:@"biaoTi"];
//    zongJi
    self.gongzuoshijianLabel.text = [self.parameters objectForKey:@"kaiShi"];
    self.xuyaorenshuLabel.text = [NSString stringWithFormat:@"%@人",[self.parameters objectForKey:@"yongGongRenShu"]];
    self.gongzuodidianLabel.text = [self.parameters objectForKey:@"diZhi"];
    self.gongzhongLabel.text = [self.parameters objectForKey:@"jiNeng"];
    self.gongjihuafeiLabel.text = [NSString stringWithFormat:@"%@元",[self.parameters objectForKey:@"zongJi"]];
    
    
    
    
}


#pragma mark -- 监听通知相关的方法
- (void)listenNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenAlipayResults:) name:@"listenWXpayResults" object:nil];
}


#pragma mark -- 监听到场地信息变化的消息后做的事情
- (void)listenAlipayResults:(NSNotification *)notification
{
    BaseResp *resp =  notification.userInfo[@"resultDic"];
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg;
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            [SVProgressHUD showInfoWithStatus:strMsg];
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            [self httpRequest];
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            [SVProgressHUD showInfoWithStatus:strMsg];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
    
}


#pragma mark 选择微信支付
- (IBAction)xuanzeweixinBtn {
    NSLog(@"微信支付");
    self.zhifuTy = @"weixin";
    [_xuanzeweixinImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb3"]];
    [_zhifubaoImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb2"]];
}

#pragma mark 选择支付宝支付
- (IBAction)xuanzezhifubaoBtn {
    NSLog(@"支付宝支付");
    self.zhifuTy = @"zhifubao";
    [_zhifubaoImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb3"]];
    [_xuanzeweixinImageView setImage:[UIImage imageNamed:@"yg_wd_qbtx_nr_tb2"]];
}





#pragma mark 确认支付
- (IBAction)querenzhifuBtn {
    NSLog(@"确认支付");
    if ([self.zhifuTy isEqualToString:@"zhifubao"]) {
        [self httpAliAppPayRequest];
    }else
    {
        if ([WXApi isWXAppInstalled]) {
//            wechatButton.hidden = NO;
            [self httpWeAppPayRequest];
        }else{
           [self.view showErrorWithTitle:@"请先安装微信" autoCloseTime:2];
        }
        
    }
    
}

#pragma mark 发布接口请求
- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/gongdan/fabu",kPRTURL];
    [BaseHttpTool POST:urlStr params:self.parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        
        if (result == 1) {
            [self.view showRightWithTitle:@"发布成功" autoCloseTime:2];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}


#pragma mark 获取支付宝信息接口
- (void)httpAliAppPayRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/AliPay/AliAppPay",kPRTURL];
    NSString *zongJiStr = [NSString stringWithFormat:@"%@",[self.parameters objectForKey:@"zongJi"]];
    NSDictionary *parame = [NSDictionary dictionaryWithObjectsAndKeys:@"信息描述",@"body",@"98易工",@"subject",zongJiStr,@"totalAmount", nil];
    
    
    [BaseHttpTool POSTS:urlStr params:parame success:^(id  _Nullable responseObj) {
//        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSData *data = responseObj;
        NSString *payOrder = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self doAPPay:payOrder];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}


- (void)weChatPayButtonAction
{
        if (![self.UnifiedorderModel.return_msg isEqualToString:@"签名错误"]) {
            PayReq *request = [[PayReq alloc] init];
            /** 商家向财付通申请的商家id */
            request.partnerId = self.UnifiedorderModel.partnerid;
            /** 预支付订单 */
            request.prepayId= self.UnifiedorderModel.prepayid;
            /** 商家根据财付通文档填写的数据和签名 */
            request.package = self.UnifiedorderModel.packages;
            /** 随机串，防重发 */
            request.nonceStr= self.UnifiedorderModel.noncestr;
            /** 时间戳，防重发 */
            request.timeStamp= [self.UnifiedorderModel.timestamp intValue];
            /** 商家根据微信开放平台文档对数据做的签名 */
            request.sign= self.UnifiedorderModel.sign;
            /*! @brief 发送请求到微信，等待微信返回onResp
             *
             * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
             * SendAuthReq、SendMessageToWXReq、PayReq等。
             * @param req 具体的发送请求，在调用函数后，请自己释放。
             * @return 成功返回YES，失败返回NO。
             */
            BOOL bat = [WXApi sendReq: request];
            if (bat) {
                NSLog(@"成功");
            }
//            NSString *str = @"weixin://wxd2e03e6cef41c2c4";
//
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }


}



#pragma mark 获取微信支付信息
- (void)httpWeAppPayRequest
{
    self.querenzhifuButton.userInteractionEnabled = NO;
    NSString *urlStr = [NSString stringWithFormat:@"%@/wxPay",kPRTURL];
    double aNumber = [[self.parameters objectForKey:@"zongJi"] doubleValue];
    NSString *zongJiStr = [NSString stringWithFormat:@"%.0f",aNumber * 100];
    NSDictionary *parame = [NSDictionary dictionaryWithObjectsAndKeys:zongJiStr,@"totalFee", nil];
    
    [BaseHttpTool GET:urlStr params:parame success:^(id  _Nullable responseObj) {
        NSLog(@"%@",responseObj);
        self.UnifiedorderModel = [XZUnifiedorderModel MolelWithUnifiedorder:responseObj];
        [self weChatPayButtonAction];
        self.querenzhifuButton.userInteractionEnabled = NO;
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        self.querenzhifuButton.userInteractionEnabled = YES;
    }];
}



#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
// 选中商品调用支付宝极简支付
//
- (void)doAPPay:(NSString *)payOrderStr
{
    [[AlipaySDK defaultService] payOrder:payOrderStr fromScheme:@"yizhangguizhifubao" callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                        NSLog(@"支付成功");
                        [self httpRequest];
                    }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"8000"])
                    {
                    }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"4000"])
                    {
                        NSLog(@"订单支付失败,请稍后再试");
        
                    }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6001"])
                    {
                        NSLog(@"支付被取消");
        
                    }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6002"])
                    {
                        NSLog(@"网络连接出错,请稍后再试");
        
                    }
                }];
    
//    // 重要说明
//    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
//    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
//    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
//    /*============================================================================*/
//    /*=======================需要填写商户app申请的===================================*/
//    /*============================================================================*/
//    NSString *appID = @"";
//
//    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
//    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
//    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
//    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
//    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
//    NSString *rsa2PrivateKey = @"";
//    NSString *rsaPrivateKey = @"";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//
//    //partner和seller获取失败,提示
//    if ([appID length] == 0 ||
//        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
//    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
//                                                                       message:@"缺少appId或者私钥,请检查参数设置"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action){
//
//                                                       }];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:^{ }];
//        return;
//    }
//
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    APOrderInfo* order = [APOrderInfo new];
//
//    // NOTE: app_id设置
//    order.app_id = appID;
//
//    // NOTE: 支付接口名称
//    order.method = @"alipay.trade.app.pay";
//
//    // NOTE: 参数编码格式
//    order.charset = @"utf-8";
//
//    // NOTE: 当前时间点
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = [formatter stringFromDate:[NSDate date]];
//
//    // NOTE: 支付版本
//    order.version = @"1.0";
//
//    // NOTE: sign_type 根据商户设置的私钥来决定
//    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
//
//    // NOTE: 商品数据
//    order.biz_content = [APBizContent new];
//    order.biz_content.body = @"我是测试数据";
//    order.biz_content.subject = @"1";
//    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.biz_content.timeout_express = @"30m"; //超时时间设置
//    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//
//    //将商品信息拼接成字符串
//    NSString *orderInfo = [order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
//
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    //    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    //    if ((rsa2PrivateKey.length > 1)) {
    //        signedString = [signer signString:orderInfo withRSA2:YES];
    //    } else {
    //        signedString = [signer signString:orderInfo withRSA2:NO];
    //    }
    
    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil) {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//        NSString *appScheme = @"alisdkdemo";
//
//        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
//
//        // NOTE: 调用支付结果开始支付
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
//                NSLog(@"支付成功");
//                [self httpRequest];
//            }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"8000"])
//            {
//            }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"4000"])
//            {
//                NSLog(@"订单支付失败,请稍后再试");
//
//            }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6001"])
//            {
//                NSLog(@"支付被取消");
//
//            }else if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"6002"])
//            {
//                NSLog(@"网络连接出错,请稍后再试");
//
//            }
//        }];
//    }
}



#pragma mark -
#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
