//  意见反馈
//  FeedbackViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/25.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "FeedbackViewController.h"
#import "PlaceholderTextView.h"
#import "HeadJumpViewController.h"
#import "TJLActionSheet.h"
#import "TJLImagePickerController.h"
#import "XWScanImage.h"
@interface FeedbackViewController ()
{
//    UIButton *choosePictureButton;
    UIView *secondView;
}
@property (nonatomic ,strong)PlaceholderTextView *contentContactInformationTextView;
@property (nonatomic ,strong)UIButton    *choosePictureButton;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView1;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView2;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView3;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn1;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn2;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn3;
@property (nonatomic ,strong)NSMutableArray *ImageAry;
@property (nonatomic ,strong)NSMutableArray *dicAry;
@property (nonatomic ,strong)NSString *textStr;
@end



@implementation FeedbackViewController

- (NSMutableArray *)ImageAry
{
    if (!_ImageAry) {
        _ImageAry = [NSMutableArray array];
    }
    return _ImageAry;
}

-(NSMutableArray *)dicAry
{
    if (!_dicAry) {
        _dicAry = [NSMutableArray array];
    }
    return _dicAry;
}

- (UIButton *)choosePictureButton
{
    if (!_choosePictureButton) {
        //选择图片
        self.choosePictureButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [_choosePictureButton setImage:[UIImage imageNamed:@"yg_wdyj_nr_tb2"] forState:UIControlStateNormal];
        [_choosePictureButton addTarget:self action:@selector(choosePicture) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:_choosePictureButton];
    }
    return _choosePictureButton;
}

- (UIImageView *)SkillsPicturesImageView
{
    if (!_SkillsPicturesImageView) {
        _SkillsPicturesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [secondView addSubview:_SkillsPicturesImageView];
        
        self.SkillsPicturesBtn = [[UIButton alloc]initWithFrame:CGRectMake(79+10, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn.tag = 1020;
        [_SkillsPicturesBtn setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:_SkillsPicturesBtn];
        
        
        //为UIImageView1添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [_SkillsPicturesImageView addGestureRecognizer:tapGestureRecognizer];
        //让UIImageView和它的父类开启用户交互属性
        [_SkillsPicturesImageView setUserInteractionEnabled:YES];
    }
    return _SkillsPicturesImageView;
}



- (UIImageView *)SkillsPicturesImageView1
{
    if (!_SkillsPicturesImageView1) {
        _SkillsPicturesImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20 + 79 + 10 , CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [secondView addSubview:_SkillsPicturesImageView1];
        
        self.SkillsPicturesBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(79*2+20, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn1.tag = 1021;
        [_SkillsPicturesBtn1 setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn1 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:_SkillsPicturesBtn1];
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [_SkillsPicturesImageView1 addGestureRecognizer:tapGestureRecognizer];
        //让UIImageView和它的父类开启用户交互属性
        [_SkillsPicturesImageView1 setUserInteractionEnabled:YES];
    }
    return _SkillsPicturesImageView1;
}


- (UIImageView *)SkillsPicturesImageView2
{
    if (!_SkillsPicturesImageView2) {
        _SkillsPicturesImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(20 + 79 * 2 + 20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [secondView addSubview:_SkillsPicturesImageView2];
        
        self.SkillsPicturesBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(20+79*3+10, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn2.tag = 1022;
        [_SkillsPicturesBtn2 setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn2 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:_SkillsPicturesBtn2];
        
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [_SkillsPicturesImageView2 addGestureRecognizer:tapGestureRecognizer];
        //让UIImageView和它的父类开启用户交互属性
        [_SkillsPicturesImageView2 setUserInteractionEnabled:YES];
    }
    return _SkillsPicturesImageView2;
}



- (UIImageView *)SkillsPicturesImageView3
{
    if (!_SkillsPicturesImageView3) {
        _SkillsPicturesImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(20 + 79 * 3 + 30, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [secondView addSubview:_SkillsPicturesImageView3];
        
        self.SkillsPicturesBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(79*4+40, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn3.tag = 1023;
        [_SkillsPicturesBtn3 setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn3 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:_SkillsPicturesBtn3];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [_SkillsPicturesImageView3 addGestureRecognizer:tapGestureRecognizer];
        //让UIImageView和它的父类开启用户交互属性
        [_SkillsPicturesImageView3 setUserInteractionEnabled:YES];
    }
    return _SkillsPicturesImageView3;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = @"意见反馈";
    // Do any additional setup after loading the view.
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 158)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UIImageView * headimageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-90)/2, 20.5, 90, 90)];
    headimageView.image = [UIImage imageNamed:@"yg_wo_yjfk"];
    [headView addSubview:headimageView];
    
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headimageView.frame)+13.5, kScreenWidth, 12)];
    Label.text =@"快 / 稳 / 准 / 诚 / 实 / 信";
    Label.textAlignment = NSTextAlignmentCenter;
    Label.font = [UIFont systemFontOfSize:12];
    [headView addSubview:Label];


    //第2块
    secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), kScreenWidth, 212)];
    secondView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f8f8f8"];
    [self.view addSubview:secondView];
    
    self.contentContactInformationTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15, 17, kScreenWidth - 30, 94)];
    self.contentContactInformationTextView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f8f8f8"];
    self.contentContactInformationTextView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    self.contentContactInformationTextView.placeholder = @"输入内容及联系方式...";
    self.contentContactInformationTextView.font = [UIFont systemFontOfSize:15];
    self.contentContactInformationTextView.maxLength = 200;
    [secondView addSubview:_contentContactInformationTextView];
    
    __weak typeof(self)weakself = self;
    [self.contentContactInformationTextView didChangeText:^(PlaceholderTextView *textView) {
        NSLog(@"%@",textView.text);
        weakself.textStr = textView.text;
    }];
    
    
    
    [self choosePictureButton];

    //选择图片
//    choosePictureButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(contentContactInformationTextView.frame)+10, 79, 79)];
//    [choosePictureButton setImage:[UIImage imageNamed:@"yg_wdyj_nr_tb2"] forState:UIControlStateNormal];
//    [choosePictureButton addTarget:self action:@selector(choosePicture) forControlEvents:UIControlEventTouchUpInside];
//    [secondView addSubview:choosePictureButton];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame), kScreenWidth, 40)];
    thirdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdView];
    
    UIButton *postedButton = [[UIButton alloc]initWithFrame:CGRectMake(thirdView.mj_w-87.5, (thirdView.mj_h -23)/2, 72.5, 23)];
    [postedButton setTitle:@"发布" forState:UIControlStateNormal];
    [postedButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"f56165"] forState:UIControlStateNormal];
    //设置边框颜色
    postedButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    //设置边框宽度
    postedButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    postedButton.layer.cornerRadius = 2.0f;
    //设置背景颜色
    postedButton.layer.masksToBounds = YES;
    postedButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [postedButton addTarget:self action:@selector(posted) forControlEvents:UIControlEventTouchUpInside];
    [thirdView addSubview:postedButton];
}


-(void)SetImageViewWithImage:(NSMutableArray *)Ary
{
    if (Ary.count == 0) {
        _SkillsPicturesImageView.hidden = YES;
        _SkillsPicturesImageView1.hidden = YES;
        _SkillsPicturesImageView2.hidden = YES;
        _SkillsPicturesImageView3.hidden = YES;
        _SkillsPicturesBtn.hidden = YES;
        _SkillsPicturesBtn1.hidden = YES;
        _SkillsPicturesBtn2.hidden = YES;
        _SkillsPicturesBtn3.hidden = YES;
        _choosePictureButton.hidden = NO;
        self.choosePictureButton.frame = CGRectMake(20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79);
    }else if (Ary.count == 1)
    {
        _SkillsPicturesImageView.hidden = NO;
        _SkillsPicturesImageView1.hidden = YES;
        _SkillsPicturesImageView2.hidden = YES;
        _SkillsPicturesImageView3.hidden = YES;
        _SkillsPicturesBtn.hidden = NO;
        _SkillsPicturesBtn1.hidden = YES;
        _SkillsPicturesBtn2.hidden = YES;
        _SkillsPicturesBtn3.hidden = YES;
        _choosePictureButton.hidden = NO;
        [self.SkillsPicturesImageView setImage:Ary[0]];
        self.choosePictureButton.frame = CGRectMake(20 + 79 + 10, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79);
        
        
    }else if (Ary.count == 2)
    {
        _SkillsPicturesImageView.hidden = NO;
        _SkillsPicturesImageView1.hidden = NO;
        _SkillsPicturesImageView2.hidden = YES;
        _SkillsPicturesImageView3.hidden = YES;
        _SkillsPicturesBtn.hidden = NO;
        _SkillsPicturesBtn1.hidden = NO;
        _SkillsPicturesBtn2.hidden = YES;
        _SkillsPicturesBtn3.hidden = YES;
        _choosePictureButton.hidden = NO;
        [self.SkillsPicturesImageView setImage:Ary[0]];
        [self.SkillsPicturesImageView1 setImage:Ary[1]];
        self.choosePictureButton.frame = CGRectMake(20 + 79*2 + 20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79);
    }else if (Ary.count == 3)
    {
        _SkillsPicturesImageView.hidden = NO;
        _SkillsPicturesImageView1.hidden = NO;
        _SkillsPicturesImageView2.hidden = NO;
        _SkillsPicturesImageView3.hidden = YES;
        _SkillsPicturesBtn.hidden = NO;
        _SkillsPicturesBtn1.hidden = NO;
        _SkillsPicturesBtn2.hidden = NO;
        _SkillsPicturesBtn3.hidden = YES;
        _choosePictureButton.hidden = NO;
        [self.SkillsPicturesImageView setImage:Ary[0]];
        [self.SkillsPicturesImageView1 setImage:Ary[1]];
        [self.SkillsPicturesImageView2 setImage:Ary[2]];
        self.choosePictureButton.frame = CGRectMake(20 + 79*3 + 30, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79);
    }else if (Ary.count == 4)
    {
        _SkillsPicturesImageView.hidden = NO;
        _SkillsPicturesImageView1.hidden = NO;
        _SkillsPicturesImageView2.hidden = NO;
        _SkillsPicturesImageView3.hidden = NO;
        _SkillsPicturesBtn.hidden = NO;
        _SkillsPicturesBtn1.hidden = NO;
        _SkillsPicturesBtn2.hidden = NO;
        _SkillsPicturesBtn3.hidden = NO;
        _choosePictureButton.hidden = YES;
        [self.SkillsPicturesImageView setImage:Ary[0]];
        [self.SkillsPicturesImageView1 setImage:Ary[1]];
        [self.SkillsPicturesImageView2 setImage:Ary[2]];
        [self.SkillsPicturesImageView3 setImage:Ary[3]];
    }
}

- (void)deleteImage:(UIButton *)Btn
{
    if (Btn.tag == 1020) {
        [self.ImageAry removeObjectAtIndex:0];
        [self SetImageViewWithImage:self.ImageAry];
    }else if (Btn.tag == 1021)
    {
        [self.ImageAry removeObjectAtIndex:1];
        [self SetImageViewWithImage:self.ImageAry];
    }else if (Btn.tag == 1022)
    {
        [self.ImageAry removeObjectAtIndex:2];
        [self SetImageViewWithImage:self.ImageAry];
        
    }else if (Btn.tag == 1023)
    {
        [self.ImageAry removeObjectAtIndex:3];
        [self SetImageViewWithImage:self.ImageAry];
    }
}



#pragma mark 选择图片
- (void)choosePicture
{
    [self.contentContactInformationTextView resignFirstResponder];
    NSLog(@"选择图片");
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
////    HeadJumpVC.Images = _photoIImageView.image;
//    __weak __typeof(self) weakSelf = self;
//    [HeadJumpVC setBlock:^(UIImage *image)
//     {
//         [choosePictureButton.imageView  setImage:image];
//         NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//         NSString *imagestr = [BaseHttpTool typeForImageData:data];
//         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
////         [weakSelf httpRequest:2 headPic:encodedImageStr picName:imagestr];
//     }];
//    [self.navigationController pushViewController:HeadJumpVC animated:YES];
    
    __weak typeof(self) weakSelf = self;
    
    TJLActionSheet *sheet = [[TJLActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:2 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [[TJLImagePickerController sharedInstance] showCameraInController:self successBlock:^(UIImage *image) {
                [weakSelf.ImageAry addObject:image];
                [weakSelf SetImageViewWithImage:weakSelf.ImageAry];
                
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:4-self.ImageAry.count successBlock:^(NSArray *imageArray) {
                [weakSelf.ImageAry addObjectsFromArray:imageArray.mutableCopy];
                [weakSelf SetImageViewWithImage:weakSelf.ImageAry];
                for (int i = 0; i< imageArray.count; i++) {
                    NSData *data = [weakSelf zipNSDataWithImage:imageArray[i]];
                    NSString *imagestr = [FeedbackViewController typeForImageData:data];
                    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    NSDictionary *parameters =
                    [NSDictionary dictionaryWithObjectsAndKeys:encodedImageStr,imagestr,nil];
                    [weakSelf.dicAry addObject:parameters];
                }
            }];
        }
    }];
    [sheet show];
    
}

#pragma mark 发布
- (void)posted
{
    NSLog(@"发布");
    [self.contentContactInformationTextView resignFirstResponder];
    NSString *urlStr = [NSString stringWithFormat:@"%@/Suggestions",kPRTURL];
    
    NSArray *myArray = [self.dicAry copy];
    NSString *text = [RankingTotalModel arrayToJson:myArray];

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId",self.textStr,@"suggestion_content",text,@"suggestion_imgs", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj objectForKey:@"result"] integerValue];
        if (result == 1) {
            [self showRightWithTitle:@"感谢您的反馈" autoCloseTime:2];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}


-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
    
}

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @".jpg";
        case 0x89:
            return @".png";
        case 0x47:
            return @".gif";
        case 0x49:
        case 0x4D:
            return @".tiff";
    }
    return nil;
}



- (NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280) {
        if (width>height) {
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }else{
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }
        //2.高度大于1280
    }else if(height>1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
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
