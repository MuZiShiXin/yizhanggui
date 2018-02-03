//  企业资料
//  EnterpriseInformationViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/27.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "EnterpriseInformationViewController.h"
#import "NicknameChangeViewController.h"
#import "HeadJumpViewController.h"
#import "TJLActionSheet.h"
#import "TJLImagePickerController.h"
#import "PlaceholderTextView.h"
#import "UIViewController+BackButtonHandler.h"

@interface EnterpriseInformationViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (strong, nonatomic) IBOutlet UILabel *NichengLabel;

@property (strong, nonatomic) IBOutlet UILabel *xingyongdaimaLabel;

@property (strong, nonatomic) IBOutlet UIImageView *photoIImageView;

@property (strong, nonatomic) IBOutlet UILabel *qiyejianjie;




@end

@implementation EnterpriseInformationViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"企业资料";
    
    _HeadImageView.layer.cornerRadius = _HeadImageView.frame.size.width / 2;
    //将多余的部分切掉
    _HeadImageView.layer.masksToBounds = YES;
    
    
    PlaceholderTextView *contentContactInformationTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.qiyejianjie.frame)+75, kScreenWidth - 30, 115)];
    contentContactInformationTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f8f8f8"];
    contentContactInformationTextView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    contentContactInformationTextView.placeholder = @"请输入企业简介...";
    contentContactInformationTextView.font = [UIFont systemFontOfSize:15];
    contentContactInformationTextView.maxLength = 200;
    [self.view addSubview:contentContactInformationTextView];
    
    [contentContactInformationTextView didChangeText:^(PlaceholderTextView *textView) {
        NSLog(@"%@",textView.text);
        
    }];
    __weak __typeof(self) weakSelf = self;
    [contentContactInformationTextView setBlock:^(NSString *str) {
        [weakSelf httpRequest:str ChanShu:@"qiYeJianJie"];
    }];
    
    
    
    if (self.model != nil) {
        [_HeadImageView sd_setImageWithURL:[NSURL URLWithString:self.model.headPicAdd] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
        [_NichengLabel setText:_model.nick];
        [_xingyongdaimaLabel setText:_model.socialCredit];
        [_photoIImageView sd_setImageWithURL:[NSURL URLWithString:_model.picAdd]];
        if (![_model.firmIntro isEqualToString:@""]) {
          [contentContactInformationTextView setText:_model.firmIntro];
        }
    } 
}

#pragma mark 头像
- (IBAction)touxiang:(id)sender {
    NSLog(@"头像");
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
//    HeadJumpVC.Images = _HeadImageView.image;
//    __block __typeof(self) weakSelf = self;
//    [HeadJumpVC setBlock:^(UIImage *image)
//     {
//         [weakSelf.HeadImageView setImage:image];
//         NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//         NSString *imagestr = [BaseHttpTool typeForImageData:data];
//         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//         [weakSelf httpRequest:1 headPic:encodedImageStr picName:imagestr];
//
//     }];
//    [self.navigationController pushViewController:HeadJumpVC animated:YES];
    
    
    
    
    __weak typeof(self) weakSelf = self;
    
    TJLActionSheet *sheet = [[TJLActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:2 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [[TJLImagePickerController sharedInstance] showCameraInController:self successBlock:^(UIImage *image) {
                [weakSelf.HeadImageView setImage:image];
                NSData *data = [BaseHttpTool zipNSDataWithImage:image];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:1 headPic:encodedImageStr picName:imagestr];
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:1  successBlock:^(NSArray *imageArray) {
                [weakSelf.HeadImageView setImage:imageArray[0]];
                NSData *data = [BaseHttpTool zipNSDataWithImage:imageArray[0]];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:1 headPic:encodedImageStr picName:imagestr];
            }];
        }
    }];
    [sheet show];
}
#pragma mark 昵称
- (IBAction)nicheng:(id)sender {
    NSLog(@"昵称");
    NicknameChangeViewController *NicknameChangeVC = [[NicknameChangeViewController alloc]init];
    __block __typeof(self) weakSelf = self;
    [NicknameChangeVC setBlock:^(NSString *Str)
     {
         [weakSelf.NichengLabel setText:Str];
         [self httpRequest:Str ChanShu:@"nick"];

     }];
    NicknameChangeVC.BiaoTiTitleLabelText = @"昵称";
    [self.navigationController pushViewController:NicknameChangeVC animated:YES];
}
#pragma mark 信用代码
- (IBAction)xinyongdaima:(id)sender {
    NSLog(@"信用代码");
    NicknameChangeViewController *NicknameChangeVC = [[NicknameChangeViewController alloc]init];
    NicknameChangeVC.BiaoTiTitleLabelText = @"社会信用代码";
    __block __typeof(self) weakSelf = self;
    [NicknameChangeVC setBlock:^(NSString *Str)
     {
         [weakSelf.xingyongdaimaLabel setText:Str];
         [self httpRequest:Str ChanShu:@"xinYongDaiMa"];

     }];
    [self.navigationController pushViewController:NicknameChangeVC animated:YES];
}
#pragma mark 照片
- (IBAction)zhaopian:(id)sender {
    NSLog(@"照片");
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
//    HeadJumpVC.Images = _photoIImageView.image;
//    __block __typeof(self) weakSelf = self;
//    [HeadJumpVC setBlock:^(UIImage *image)
//     {
//         [weakSelf.photoIImageView setImage:image];
//         NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//         NSString *imagestr = [BaseHttpTool typeForImageData:data];
//         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//         [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
//     }];
//    [self.navigationController pushViewController:HeadJumpVC animated:YES];
    
    
    
    __weak typeof(self) weakSelf = self;
    
    TJLActionSheet *sheet = [[TJLActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:2 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [[TJLImagePickerController sharedInstance] showCameraInController:self successBlock:^(UIImage *image) {
                [weakSelf.photoIImageView setImage:image];
                NSData *data = [BaseHttpTool zipNSDataWithImage:image];
                
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:1  successBlock:^(NSArray *imageArray) {
                [weakSelf.photoIImageView setImage:imageArray[0]];
                NSData *data = [BaseHttpTool zipNSDataWithImage:imageArray[0]];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
            }];
        }
    }];
    [sheet show];
    
    
    
    
}




- (void)httpRequest:(NSInteger)Nmb headPic:(NSString *)headPicStr picName:(NSString *)picNameStr
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/picUrl",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId",headPicStr,@"headPic",picNameStr,@"picName",@(Nmb),@"picType", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            [self showRightWithTitle:@"修改成功" autoCloseTime:2];
            NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            [RankingTotalModel creatRankingTotalModelWith:resultDic];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:resultDic forKey:@"params"];
            [userDefaults synchronize];
        }else
        {
            [self showErrorWithTitle:@"修改成功" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}

- (void)httpRequest:(NSString *)ZhiStr ChanShu:(NSString *)chanshu
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/modify",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId",ZhiStr,chanshu, nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        
        if (result == 1) {
            [self showRightWithTitle:@"修改成功" autoCloseTime:2];
//            Global.wanShanXinXi = [[[responseObj valueForKey:@"data"] objectForKey:@"wanShanXinXi"] integerValue];
            
            NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            NSLog(@"%@",resultDic);
            
            [RankingTotalModel creatRankingTotalModelWith:resultDic];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:resultDic forKey:@"params"];
            [userDefaults synchronize];
        }else
        {
            
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
