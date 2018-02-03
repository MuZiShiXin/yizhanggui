// 我的
//  MainViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MainViewController.h"
#import "MyCollectionViewController.h"
#import "FeedbackViewController.h"
#import "MyWalletViewController.h"
#import "EnterpriseInformationViewController.h"
#import "PersonalInformationEditorViewController.h"
#import "SettingViewController.h"
#import "MyOrderViewController.h"
#import "MyEvaluationViewController.h"
#import "WoDeGongDanViewController.h"
#import "UserInfoQueryModel.h"
#import "ChatListViewController.h"
#import <RongIMKit/RCConversationViewController.h>
#import <UShareUI/UShareUI.h>

@interface MainViewController ()
{
    UIButton *headImageButton;
}
@property (nonatomic , strong) UserInfoQueryModel *UserInfoModel;
@end

@implementation MainViewController

- (BOOL)isHideBackButton
{
    return YES;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequest];
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/query/userInfo",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        if (result == 1) {
            self.UserInfoModel = [UserInfoQueryModel creatRankingTotalModelWith:resultDic];
            //            [headImageButton.imageView sd_setImageWithURL:[NSURL URLWithString:self.UserInfoModel.headPicAdd]];
            [headImageButton setBackgroundImageWithURL:[NSURL URLWithString:self.UserInfoModel.headPicAdd] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.NVBJImageView.alpha = 0;
    self.titelLabel.text = @"我的";
    self.titelLabel.textColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
    // Do any additional setup after loading the view.
    
    //第一块
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,212)];
    UIImageView *headimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 212)];
    headimageView.image = [UIImage imageNamed:@"zgd_wd_bg"];
    [firstView addSubview:headimageView];
    firstView.backgroundColor = [UIColor whiteColor];
    headimageView.userInteractionEnabled = YES;
    [self.view addSubview:firstView];
    
    headImageButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 100)/2, 72, 100, 100)];
//    [headImageButton setImage:[UIImage imageNamed:@"yg_wd_nr_tp1"] forState:UIControlStateNormal];
    [headImageButton addTarget:self action:@selector(secondBtn:)
              forControlEvents:UIControlEventTouchUpInside];
    headImageButton.layer.cornerRadius = headImageButton.frame.size.width / 2;
    //将多余的部分切掉
    headImageButton.layer.masksToBounds = YES;
    [headImageButton setBackgroundImageWithURL:[NSURL URLWithString:self.UserInfoModel.headPicAdd] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    headImageButton.tag = 333;
    [headimageView addSubview:headImageButton];
    
    [self.view sendSubviewToBack:firstView];
    
    
    
    UIScrollView *bjScrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstView.frame), kScreenWidth, kScreenHeight - 212)];
    bjScrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
    
    
    
    //第二块
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 7.5, kScreenWidth, 148.5)];
    secondView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:secondView];
    
    NSArray *mineArray1 = @[@"个人资料",@"设置",@"钱包"];
    NSArray *pictureArray1 = @[@"yg_wd_nr_tb1",@"yg_wd_nr_tb2",@"yg_wd_nr_tb3"];
    for (int i = 0; i < mineArray1.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*49.5, kScreenWidth, 49.5)];
        button.tag = i + 300;
        [button addTarget:self action:@selector(secondBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, (button.mj_h - 25)/2, 25, 25)];
        iconImageView.image = [UIImage imageNamed:pictureArray1[i]];
        [button addSubview:iconImageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+15.5, 12.5, 100, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.tag = 1 + 100;
        label.text = mineArray1[i];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
        [button addSubview:label];
        
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(button.mj_w - 22 - 6.5, (button.mj_h-22)/2, 22, 22)];
        rightImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
        [button addSubview:rightImage];
        [secondView addSubview:button];
        
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(15, i*(49.5) , kScreenWidth-15, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [secondView addSubview:threadView];
        }
    }
    
    
    
    //第三块
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame)+7.5, kScreenWidth, 198)];
    thirdView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:thirdView];
    
    NSArray *mineArray2 = @[@"我的工单",@"我的订单",@"我的收藏",@"我的评价"];
    NSArray *pictureArray2 = @[@"yg_wd_nr_tb4",@"yg_wd_nr_tb5",@"yg_wd_nr_tb6",@"yg_wd_nr_tb7"];
    for (int i = 0; i < mineArray2.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*49.5, kScreenWidth, 49.5)];
        button.tag = i + 400;
        [button addTarget:self action:@selector(thirdBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, (button.mj_h - 25)/2, 25, 25)];
        iconImageView.image = [UIImage imageNamed:pictureArray2[i]];
        [button addSubview:iconImageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+15.5, 12.5, 100, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.tag = 1 + 100;
        label.text = mineArray2[i];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
        [button addSubview:label];
        
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(button.mj_w - 22 - 6.5, (button.mj_h-22)/2, 22, 22)];
        rightImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
        [button addSubview:rightImage];
        [thirdView addSubview:button];
        
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(15, i*(49.5) , kScreenWidth-15, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [thirdView addSubview:threadView];
        }
    }
    
    
    //第四块
    UIView *fourthView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(thirdView.frame)+7.5, kScreenWidth, 148.5)];
    fourthView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:fourthView];
    
    NSArray *mineArray3 = @[@"分享",@"意见反馈",@"联系客服"];
    NSArray *pictureArray3 = @[@"yg_wd_nr_tb8",@"yg_wd_nr_tb9",@"yg_wd_nr_tb10"];
    for (int i = 0; i < mineArray3.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*49.5, kScreenWidth, 49.5)];
        button.tag = i + 500;
        [button addTarget:self action:@selector(fourthBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, (button.mj_h - 25)/2, 25, 25)];
        iconImageView.image = [UIImage imageNamed:pictureArray3[i]];
        [button addSubview:iconImageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+15.5, 12.5, 100, 25)];
        label.font = [UIFont systemFontOfSize:16];
        label.tag = 1 + 100;
        label.text = mineArray3[i];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
        [button addSubview:label];
        
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(button.mj_w - 22 - 6.5, (button.mj_h-22)/2, 22, 22)];
        rightImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
        [button addSubview:rightImage];
        [fourthView addSubview:button];
        
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(15, i*(49.5) , kScreenWidth-15, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [fourthView addSubview:threadView];
        }
    }
    
    bjScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(fourthView.frame)+44+49.5);
    [self.view addSubview:bjScrollView];
}


#pragma mark 个人资料 设置 钱包
- (void)secondBtn:(UIButton *)btn
{
    if (btn.tag == 300 || btn.tag == 333) {
        NSLog(@"企业资料");
        NSLog(@"%@",Global.userType);
        if ([[NSString stringWithFormat:@"%@",Global.userType]  isEqualToString:@"1"]) {
            EnterpriseInformationViewController * EnterpriseInformationVC = [[EnterpriseInformationViewController alloc]init];
            EnterpriseInformationVC.model = self.UserInfoModel;
            [self.navigationController pushViewController:EnterpriseInformationVC animated:YES];
            Global.userType = @"1";
        }else if ([[NSString stringWithFormat:@"%@",Global.userType] isEqualToString:@"2"])
        {
            PersonalInformationEditorViewController * PersonalInformationEditorVC = [[PersonalInformationEditorViewController alloc]init];
            PersonalInformationEditorVC.model = self.UserInfoModel;
            [self.navigationController pushViewController:PersonalInformationEditorVC animated:YES];
            Global.userType = @"2";

        }
    }else if (btn.tag == 301)
    {
        NSLog(@"设置");
        SettingViewController * SettingVC = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:SettingVC animated:YES];
    }else{
        NSLog(@"钱包");
        MyWalletViewController *MyWalletVC = [[MyWalletViewController alloc]init];
        [self.navigationController pushViewController:MyWalletVC animated:YES];
    }
}

#pragma mark 我的工单 我的订单 我的收藏 我的评价
- (void)thirdBtn:(UIButton *)btn
{
    if(btn.tag == 400) {
        NSLog(@"我的工单");
        WoDeGongDanViewController *WoDeGongDanVC = [[WoDeGongDanViewController alloc]init];
        [self.navigationController pushViewController:WoDeGongDanVC animated:YES];
    }else if (btn.tag == 401)
    {
        NSLog(@"我的订单");
        MyOrderViewController *MyOrderVC = [[MyOrderViewController alloc]init];
        [self.navigationController pushViewController:MyOrderVC animated:YES];
    }else if (btn.tag == 402)
    {
        NSLog(@"我的收藏");
        MyCollectionViewController *MyCollectionVC = [[MyCollectionViewController alloc]init];
        [self.navigationController pushViewController:MyCollectionVC animated:YES];
    }else{
        NSLog(@"我的评价");
        MyEvaluationViewController *MyEvaluationVC = [[MyEvaluationViewController alloc]init];
        [self.navigationController pushViewController:MyEvaluationVC animated:YES];
    }
}

#pragma mark 分享 意见反馈 联系客服
- (void)fourthBtn:(UIButton *)btn
{
    if (btn.tag == 500) {
        NSLog(@"分享");
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sms),@(UMSocialPlatformType_Email)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            if (platformType == UMSocialPlatformType_WechatSession ||platformType == UMSocialPlatformType_WechatTimeLine) {
                [self shareToWeiXin:platformType];
            }else if (platformType == UMSocialPlatformType_Sina)
            {
                
            }else if (platformType == UMSocialPlatformType_Sms)
            {
                
            }else if (platformType == UMSocialPlatformType_Email)
            {
                
            }else if (platformType == UMSocialPlatformType_Qzone)
            {
                
            }else if (platformType == UMSocialPlatformType_QQ)
            {
                
            }else
            {
                
            }
            
        }];
        
        
        
        
    }else if (btn.tag == 501)
    {
        NSLog(@"意见反馈");
        FeedbackViewController *FeedbackVC = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:FeedbackVC animated:YES];
    }else{
        NSLog(@"联系客服");
        NSString*token=@"Cy0jErlwtmgJ8rB3ZO1g7QQo6oi3mCmwtYGl2yIkpUNxCwMQPb8N4ZD36D0QEI0BE4offeXIacurRyug31N0OQ==";
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            NSLog(@"Login successfully with userId: %@.", userId);
            dispatch_async(dispatch_get_main_queue(), ^{
                ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
                [self.navigationController pushViewController:chatListViewController animated:YES];
            });
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"login error status: %ld.", (long)status);
        } tokenIncorrect:^{
            NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
        }];
    }
}

/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
    }else if([@"2" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"2";
        user.name = @"测试2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }
}


- (void)shareToWeiXin:(UMSocialPlatformType) platformType
{
    //网页分享
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象(带了图片)
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"的分享" descr:@"关于明天shang班的通知" thumImage:[UIImage imageNamed:@"WebOfBanner_InvitationCode"]];
    //设置你要分享出去的网页地址
    shareObject.webpageUrl = @"http://www.baidu.com";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error)
     {
         if (error)
         {
             UMSocialLogInfo(@"************Share fail with error %@*********",error);
         }
         else
         {
             if ([data isKindOfClass:[UMSocialShareResponse class]])
             {
                 UMSocialShareResponse *resp = data;
                 //分享结果消息
                 UMSocialLogInfo(@"response message is %@",resp.message);
                 //第三方原始返回的数据
                 UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                 
             }
             else
             {
                 UMSocialLogInfo(@"response data is %@",data);
             }
         }
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
