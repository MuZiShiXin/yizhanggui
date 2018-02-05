//  个人资料
//  PersonalInformationEditorViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/27.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "PersonalInformationEditorViewController.h"
#import "NicknameChangeViewController.h"
#import "HeadJumpViewController.h"
#import "PlaceholderTextView.h"
#import "TJLActionSheet.h"
#import "TJLImagePickerController.h"
@interface PersonalInformationEditorViewController ()
{
    UIToolbar *toolbar;
    UIView *BJview;
}

@property (strong, nonatomic) IBOutlet UIImageView *gerentouxiang;
@property (strong, nonatomic) IBOutlet UILabel *nichengLabel;
@property (strong, nonatomic) IBOutlet UILabel *xingbieLabel;
@property (strong, nonatomic) IBOutlet UIImageView *zhaopianImageView;

@property (strong, nonatomic) IBOutlet UILabel *shenfenzhengxinxiLabel;

@property (strong, nonatomic) IBOutlet UIImageView *shenfenzhengImageView;
@property (strong, nonatomic) IBOutlet UILabel *shenfenzhengxiangxiS;
@property (strong, nonatomic) IBOutlet UIView *BJView;

@end

@implementation PersonalInformationEditorViewController

- (BOOL)isHideBackButton
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"个人资料";
    
    _gerentouxiang.layer.cornerRadius = _gerentouxiang.frame.size.width / 2;
    //将多余的部分切掉
    _gerentouxiang.layer.masksToBounds = YES;
    
    
    PlaceholderTextView *contentContactInformationTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.shenfenzhengxiangxiS.frame)+10, kScreenWidth - 30, 115)];
    contentContactInformationTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f8f8f8"];
    contentContactInformationTextView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    contentContactInformationTextView.placeholder = @"请输入技能...";
    contentContactInformationTextView.font = [UIFont systemFontOfSize:15];
    contentContactInformationTextView.maxLength = 200;
    [self.BJView addSubview:contentContactInformationTextView];
    
    [contentContactInformationTextView didChangeText:^(PlaceholderTextView *textView) {
        NSLog(@"%@",textView.text);
        
    }];
    __weak __typeof(self) weakSelf = self;
    [contentContactInformationTextView setBlock:^(NSString *str) {
        [weakSelf httpRequest:str ChanShu:@"jiNeng"];
    }];
    
    if (self.model != nil) {
        [_gerentouxiang sd_setImageWithURL:[NSURL URLWithString:self.model.headPicAdd]placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
        [_nichengLabel setText:self.model.nick];
        [_xingbieLabel setText:self.model.gender];
        [_zhaopianImageView sd_setImageWithURL:[NSURL URLWithString:self.model.picAdd]];
        [_shenfenzhengxinxiLabel setText:self.model.idNum];
        [_shenfenzhengImageView sd_setImageWithURL:[NSURL URLWithString:self.model.idPicAdd]];
        if (![_model.firmIntro isEqualToString:@""]) {
            [contentContactInformationTextView setText:_model.firmIntro];
        }
        
    }
    
    
    
}
#pragma mark 头像
- (IBAction)touxiangxuanze {
    NSLog(@"头像");
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
//    HeadJumpVC.Images = _gerentouxiang.image;
//    __weak __typeof(self) weakSelf = self;
//    [HeadJumpVC setBlock:^(UIImage *image)
//     {
//         [weakSelf.gerentouxiang setImage:image];
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
                [weakSelf.gerentouxiang setImage:image];
                NSData *data = UIImageJPEGRepresentation(image, 1.0f);
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:1 headPic:encodedImageStr picName:imagestr];
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:1  successBlock:^(NSArray *imageArray) {
                [weakSelf.gerentouxiang setImage:imageArray[0]];
                NSData *data = UIImageJPEGRepresentation(imageArray[0], 1.0f);
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:1 headPic:encodedImageStr picName:imagestr];
            }];
        }
    }];
    [sheet show];
    
}
#pragma mark 昵称
- (IBAction)nichengxuanze {
    NSLog(@"昵称");
    NicknameChangeViewController *NicknameChangeVC = [[NicknameChangeViewController alloc]init];
    NicknameChangeVC.BiaoTiTitleLabelText = @"昵称";
    __weak __typeof(self) weakSelf = self;
    [NicknameChangeVC setBlock:^(NSString *Str)
     {
         [weakSelf.nichengLabel setText:Str];
         [self httpRequest:Str ChanShu:@"nick"];

     }];
    [self.navigationController pushViewController:NicknameChangeVC animated:YES];
}
#pragma mark 性别
- (IBAction)xingbiexuanze {
    NSLog(@"性别");
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-136)];
    //样式
    toolbar.barStyle = UIBarStyleBlackTranslucent;//半透明
    //透明度
    toolbar.alpha = 0.5f;
    [self.view addSubview:toolbar];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [toolbar addGestureRecognizer:tapGestureRecognizer];
    
    
    BJview
    = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-136, kScreenWidth, 136)];
    BJview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BJview];
    
    UIButton *quxiaobutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 40, 45)];
    [quxiaobutton setTitle:@"取消" forState:(UIControlStateNormal)];
    [quxiaobutton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"666666"] forState:(UIControlStateNormal)];
    quxiaobutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [quxiaobutton addTarget:self action:@selector(quxiaobutton) forControlEvents:(UIControlEventTouchUpInside)];
    [BJview addSubview:quxiaobutton];
    
    UILabel *biaotiLabel = [[UILabel alloc]initWithFrame:CGRectMake((BJview.mj_w-200)/2, 15, 200, 15)];
    biaotiLabel.text = @"性别选择";
    biaotiLabel.font = [UIFont systemFontOfSize:15];
    biaotiLabel.textColor = [UIColor blackColor];
    biaotiLabel.textAlignment = 1;
    [BJview addSubview:biaotiLabel];
    
    
    UIButton *quedingbutton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-55, 0, 40, 45)];
    [quedingbutton setTitle:@"完成" forState:(UIControlStateNormal)];
    [quedingbutton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:(UIControlStateNormal)];
    quedingbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [quedingbutton addTarget:self action:@selector(quedingbutton) forControlEvents:(UIControlEventTouchUpInside)];
    [BJview addSubview:quedingbutton];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(quedingbutton.frame), kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [BJview addSubview:lineView];
    
    UIButton *nanButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), kScreenWidth, 45)];
    [nanButton setTitle:@"男" forState:UIControlStateNormal];
    nanButton.titleLabel.font = [UIFont systemFontOfSize:15];
    if ([_xingbieLabel.text isEqualToString:@"男"]||[_xingbieLabel.text isEqualToString:@""]) {
        [nanButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:(UIControlStateNormal)];
    }else if ([_xingbieLabel.text isEqualToString:@"女"])
    {
        [nanButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    nanButton.tag = 1200;
    [nanButton addTarget:self action:@selector(nanAndnv:) forControlEvents:UIControlEventTouchUpInside];
    [BJview addSubview:nanButton];

    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nanButton.frame), kScreenWidth, 1)];
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [BJview addSubview:lineView1];
    
    UIButton *nvButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView1.frame), kScreenWidth, 45)];
    [nvButton setTitle:@"女" forState:UIControlStateNormal];
    nvButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nvButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    if ([_xingbieLabel.text isEqualToString:@"女"]) {
        [nvButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:(UIControlStateNormal)];
    }else if ([_xingbieLabel.text isEqualToString:@"男"]||[_xingbieLabel.text isEqualToString:@""])
    {
        [nvButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    nvButton.tag = 1201;
    [nvButton addTarget:self action:@selector(nanAndnv:) forControlEvents:UIControlEventTouchUpInside];
    [BJview addSubview:nvButton];
    
    
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [toolbar removeFromSuperview];
    [BJview removeFromSuperview];
}



#pragma mark 取消
- (void)quxiaobutton
{
    NSLog(@"取消");
    [toolbar removeFromSuperview];
    [BJview removeFromSuperview];
}

#pragma mark 确定
- (void)quedingbutton
{
    NSLog(@"确定");
    [toolbar removeFromSuperview];
    [BJview removeFromSuperview];
    
    if ([_xingbieLabel.text isEqualToString:@""]) {
        _xingbieLabel.text = @"男";
        [self httpRequest:_xingbieLabel.text ChanShu:@"gender"];
    }else
    {
        [self httpRequest:_xingbieLabel.text ChanShu:@"gender"];
    }
}


#pragma mark 男/女
- (void)nanAndnv:(UIButton *)btn
{
    NSLog(@"男/女");
    UIButton * button = (UIButton *)[self.view viewWithTag:1200];
    UIButton * button1 = (UIButton *)[self.view viewWithTag:1201];
    
    if (btn.tag == 1200) {
        [button setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_xingbieLabel setText:@"男"];

    }else
    {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
        [_xingbieLabel setText:@"女"];

    }

}



#pragma mark 照片
- (IBAction)zhaopianxuanze {
    NSLog(@"照片");
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
//    HeadJumpVC.Images = _zhaopianImageView.image;
//    __weak __typeof(self) weakSelf = self;
//    [HeadJumpVC setBlock:^(UIImage *image)
//     {
//         [weakSelf.zhaopianImageView setImage:image];
//         NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//         NSString *imagestr = [BaseHttpTool typeForImageData:data];
//         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//         [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
//     }];
//    [self.navigationController pushViewController:HeadJumpVC animated:YES];
    
    
    
//    self.imageArray = nil;
    
    __weak typeof(self) weakSelf = self;
    
    TJLActionSheet *sheet = [[TJLActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:2 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [[TJLImagePickerController sharedInstance] showCameraInController:self successBlock:^(UIImage *image) {
                [weakSelf.zhaopianImageView setImage:image];
                NSData *data = [BaseHttpTool zipNSDataWithImage:image];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:1  successBlock:^(NSArray *imageArray) {
                [weakSelf.zhaopianImageView setImage:imageArray[0]];
                NSData *data = [BaseHttpTool zipNSDataWithImage:imageArray[0]];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
            }];
        }
    }];
    [sheet show];
    
}
#pragma mark 身份证信息
- (IBAction)shenfenzhengxinxi {
    NSLog(@"身份证信息");
    NicknameChangeViewController *NicknameChangeVC = [[NicknameChangeViewController alloc]init];
    NicknameChangeVC.BiaoTiTitleLabelText = @"身份证号";
    __weak __typeof(self) weakSelf = self;
    [NicknameChangeVC setBlock:^(NSString *Str)
     {
         [weakSelf.shenfenzhengxinxiLabel setText:Str];
         if (Str.length == 18) {
             [weakSelf httpRequest:Str ChanShu:@"idNum"];
         }

     }];
    [self.navigationController pushViewController:NicknameChangeVC animated:YES];
}
#pragma mark 身份证图片
- (IBAction)shenfenzhengxuanze {
    NSLog(@"身份证图片");
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
//    HeadJumpVC.Images = _shenfenzhengImageView.image;
//    __weak __typeof(self) weakSelf = self;
//    [HeadJumpVC setBlock:^(UIImage *image)
//     {
//         [weakSelf.shenfenzhengImageView setImage:image];
//         NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//         NSString *imagestr = [BaseHttpTool typeForImageData:data];
//         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//         [weakSelf httpRequest:3 headPic:encodedImageStr picName:imagestr];
//     }];
//    [self.navigationController pushViewController:HeadJumpVC animated:YES];
    
    __weak typeof(self) weakSelf = self;
    
    TJLActionSheet *sheet = [[TJLActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:2 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [[TJLImagePickerController sharedInstance] showCameraInController:self successBlock:^(UIImage *image) {
                [weakSelf.shenfenzhengImageView setImage:image];
                NSData *data = [BaseHttpTool zipNSDataWithImage:image];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:3 headPic:encodedImageStr picName:imagestr];
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:1  successBlock:^(NSArray *imageArray) {
                [weakSelf.shenfenzhengImageView setImage:imageArray[0]];
                NSData *data = [BaseHttpTool zipNSDataWithImage:imageArray[0]];
                NSString *imagestr = [BaseHttpTool typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [weakSelf httpRequest:3 headPic:encodedImageStr picName:imagestr];
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
            NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
            [RankingTotalModel creatRankingTotalModelWith:resultDic];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:resultDic forKey:@"params"];
            [userDefaults synchronize];
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
