//  发布工作
//  ToHireViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/23.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "ToHireViewController.h"
#import "PlaceholderTextView.h"
#import "WSDatePickerView.h"
#import "HeadJumpViewController.h"
#import "FaBuZhiFuViewController.h"
#import "RankingTotalModel.h"
#import "CommonAddressViewController.h"
#import "TJLActionSheet.h"
#import "TJLImagePickerController.h"
#import "XWScanImage.h"
#import "WorkTypeSViewController.h"

@interface ToHireViewController ()<UITextFieldDelegate>
{
    
    UITextField * headingsTextField;        //请输入标题
    UILabel *occupationLabel;               //工种
    UITextField * peopleNumberTextField;    //用工人数
    UITextField * payTextField;             //用工薪酬
    UILabel *startTimeLabel;                //开始时间
    UILabel * endTimeLabel;                 //结束时间
    UILabel *handlingChargeLabel;           //手续费
    UILabel *AlwaysRememberToSpendLabel;    //总花费
    UILabel *addressLabel;                  //用工地址
    NSInteger yonggongshijianNub;
    CGFloat shouxufeiNumber;
    NSString *phone;
    UIView *sixthView;
}
@property (nonatomic ,strong)NSMutableArray *dicAry;
@property (nonatomic ,assign)NSInteger ImageCode;
@property (nonatomic ,strong)NSMutableArray *ImageAry;
@property (nonatomic ,strong)UIButton *choosePictureButton;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView1;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView2;
@property (nonatomic ,strong)UIImageView *SkillsPicturesImageView3;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn1;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn2;
@property (nonatomic ,strong)UIButton    *SkillsPicturesBtn3;
@property (nonatomic ,strong)PlaceholderTextView *contentContactInformationTextView;
@property (nonatomic ,assign)CGFloat latitudeY;
@property (nonatomic ,assign)CGFloat longitudeX;
@property (nonatomic ,strong)NSArray *WorkTypeAry;

@end

@implementation ToHireViewController

- (BOOL)isHideBackButton
{
    return NO;
}

-(NSMutableArray *)dicAry
{
    if (!_dicAry) {
        _dicAry = [NSMutableArray array];
    }
    return _dicAry;
}
- (NSMutableArray *)ImageAry
{
    if (!_ImageAry) {
        _ImageAry = [NSMutableArray array];
    }
    return _ImageAry;
}

-(NSArray *)WorkTypeAry
{
    if (!_WorkTypeAry) {
        _WorkTypeAry = [NSArray array];
    }
    return _WorkTypeAry;
}


- (UIButton *)choosePictureButton
{
    if (!_choosePictureButton) {
        //选择图片
        self.choosePictureButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [_choosePictureButton setImage:[UIImage imageNamed:@"yg_wdyj_nr_tb2"] forState:UIControlStateNormal];
        [_choosePictureButton addTarget:self action:@selector(choosePicture) forControlEvents:UIControlEventTouchUpInside];
        [sixthView addSubview:_choosePictureButton];
    }
    return _choosePictureButton;
}

- (UIImageView *)SkillsPicturesImageView
{
    if (!_SkillsPicturesImageView) {
        _SkillsPicturesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_contentContactInformationTextView.frame)+10, 79, 79)];
        [sixthView addSubview:_SkillsPicturesImageView];
        
        self.SkillsPicturesBtn = [[UIButton alloc]initWithFrame:CGRectMake(79+10, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn.tag = 1020;
        [_SkillsPicturesBtn setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [sixthView addSubview:_SkillsPicturesBtn];
        
        
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
        [sixthView addSubview:_SkillsPicturesImageView1];
        
        self.SkillsPicturesBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(79*2+20, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn1.tag = 1021;
        [_SkillsPicturesBtn1 setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn1 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [sixthView addSubview:_SkillsPicturesBtn1];
        
        
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
        [sixthView addSubview:_SkillsPicturesImageView2];
        
        self.SkillsPicturesBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(20+79*3+10, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn2.tag = 1022;
        [_SkillsPicturesBtn2 setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn2 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [sixthView addSubview:_SkillsPicturesBtn2];
        
        
        
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
        [sixthView addSubview:_SkillsPicturesImageView3];
        
        self.SkillsPicturesBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(79*4+40, CGRectGetMaxY(_contentContactInformationTextView.frame), 20, 20)];
        _SkillsPicturesBtn3.tag = 1023;
        [_SkillsPicturesBtn3 setTitle:@"X" forState:UIControlStateNormal];
        [_SkillsPicturesBtn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_SkillsPicturesBtn3 addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [sixthView addSubview:_SkillsPicturesBtn3];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
        [_SkillsPicturesImageView3 addGestureRecognizer:tapGestureRecognizer];
        //让UIImageView和它的父类开启用户交互属性
        [_SkillsPicturesImageView3 setUserInteractionEnabled:YES];
    }
    return _SkillsPicturesImageView3;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/GZ/fenlei/select",kPRTURL];
    [BaseHttpTool GET:urlStr params:nil success:^(id  _Nullable responseObj) {
        self.WorkTypeAry = [responseObj objectForKey:@"data"];
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.NVBJImageView.alpha = 1;
    yonggongshijianNub = 2;
    phone = @"";
    [self httpRequest];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"发布工作";
    UIScrollView *bjScrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    bjScrollView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
    
    //第一块
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,132)];
    firstView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:firstView];
    
    NSArray *array = @[@"用工标题",@"用工技能",@"用工人数"];
    for (int i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*(15 + 30)+ 15, 100, 15)];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 1 + 100;
        label.text = array[i];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"434343"];
        [firstView addSubview:label];
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(10, i*(15+30) , kScreenWidth-20, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [firstView addSubview:threadView];
        }
    }
    //标题
    headingsTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 185, 5, kScreenWidth-(kScreenWidth-170), 35)];
    headingsTextField.placeholder = @"请输入14字以内标题";
    if (self.Model != nil) {
        [headingsTextField setText:self.Model.biaoTi];
    }
    headingsTextField.font = [UIFont systemFontOfSize:15];
    headingsTextField.textAlignment = NSTextAlignmentRight;
    headingsTextField.textColor = [UIColor hx_colorWithHexRGBAString:@"c7c7cd"];
    headingsTextField.delegate = self;
    [headingsTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [firstView addSubview:headingsTextField];
    
    //选择工种
    UIButton *occupationButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth - 115), CGRectGetMaxY(headingsTextField.frame)+5, kScreenWidth-100-25, 44)];
    UIImageView *occupationImage = [[UIImageView alloc]initWithFrame:CGRectMake(occupationButton.mj_w-22, (44-22)/2, 22, 22)];
    occupationImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
    occupationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (44-22)/2, occupationButton.mj_w-22, 22)];
    occupationLabel.textAlignment = NSTextAlignmentRight;
    occupationLabel.text = @"选择工种";
    if (self.Model != nil) {
        [occupationLabel setText: self.Model.jiNeng];
    }
    occupationLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"c7c7cd"];
    occupationLabel.font = [UIFont systemFontOfSize:14];
    [occupationButton addTarget:self action:@selector(occupation) forControlEvents:UIControlEventTouchUpInside];
    [occupationButton addSubview:occupationImage];
    [occupationButton addSubview:occupationLabel];
    [firstView addSubview:occupationButton];
    
    //用工人数
    peopleNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 165, CGRectGetMaxY(occupationButton.frame)+5, kScreenWidth-(kScreenWidth-150), 35)];
    peopleNumberTextField.placeholder = @"输入需求数量";
    peopleNumberTextField.font = [UIFont systemFontOfSize:15];
    peopleNumberTextField.textAlignment = NSTextAlignmentRight;
    peopleNumberTextField.textColor = [UIColor hx_colorWithHexRGBAString:@"c7c7cd"];
    peopleNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    peopleNumberTextField.delegate = self;
    [peopleNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [firstView addSubview:peopleNumberTextField];
    
    //第二块
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstView.frame)+10, kScreenWidth, 132)];
    secondView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:secondView];
    
    NSArray *secondArray = @[@"用工时间",@"开始时间",@"结束时间"];
    for (int i = 0; i < secondArray.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*(15 + 30)+ 15, 100, 15)];
        label.font = [UIFont systemFontOfSize:14];
        label.tag = 1 + 100;
        label.text = secondArray[i];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"434343"];
        [secondView addSubview:label];
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(10, i*(15+30) , kScreenWidth-20, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [secondView addSubview:threadView];
        }
    }
    //用工时间
    NSArray *skyArray = @[@"fbgz_tian",@"fbgz_xiaoshi_hui",@"fbgz_ci_hui"];
    for (int t = 0; t < skyArray.count; t++) {
        UIButton *skyButton = [[UIButton alloc]initWithFrame:CGRectMake(t*(54.5 + 10)+ kScreenWidth - (54.5*3+35), (44-30)/2, 54.5, 30)];
        skyButton.tag = t + 200;
        [skyButton setBackgroundImage:[UIImage imageNamed:skyArray[t]] forState:UIControlStateNormal];
        [skyButton addTarget:self action:@selector(skybutton:) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:skyButton];
    }
    
    //开始时间
    UIButton *startTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth - 115), CGRectGetMaxY(headingsTextField.frame)+5, kScreenWidth-100-25, 44)];
    UIImageView *startTimeImage = [[UIImageView alloc]initWithFrame:CGRectMake(occupationButton.mj_w-22, (44-22)/2, 22, 22)];
    startTimeImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
    startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (44-22)/2, startTimeButton.mj_w-22, 22)];
    startTimeLabel.textAlignment = NSTextAlignmentRight;
    startTimeLabel.text = @"选择开始时间";
    startTimeLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"c7c7cd"];
    startTimeLabel.font = [UIFont systemFontOfSize:14];
    [startTimeButton addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
    [startTimeButton addSubview:startTimeImage];
    [startTimeButton addSubview:startTimeLabel];
    [secondView addSubview:startTimeButton];
    
    
    
    //结束时间
    UIButton *endTimeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth - 115), CGRectGetMaxY(startTimeButton.frame), kScreenWidth-100-25, 44)];
    UIImageView *endTimeImage = [[UIImageView alloc]initWithFrame:CGRectMake(occupationButton.mj_w-22, (44-22)/2, 22, 22)];
    endTimeImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
    endTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (44-22)/2, endTimeButton.mj_w-22, 22)];
    endTimeLabel.textAlignment = NSTextAlignmentRight;
    endTimeLabel.text = @"选择结束时间";
    endTimeLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"c7c7cd"];
    endTimeLabel.font = [UIFont systemFontOfSize:14];
    [endTimeButton addTarget:self action:@selector(endTime) forControlEvents:UIControlEventTouchUpInside];
    [endTimeButton addSubview:endTimeImage];
    [endTimeButton addSubview:endTimeLabel];
    [secondView addSubview:endTimeButton];
    
    //第三块
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(secondView.frame)+10, kScreenWidth, 176)];
    thirdView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:thirdView];
    
    NSArray *thirdArray = @[@"用工薪酬",@"保险费",@"手续费",@"总计花费"];
    for (int i = 0; i < thirdArray.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*(15 + 30)+ 15, 100, 15)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"434343"];
        label.text = thirdArray[i];
        [thirdView addSubview:label];
        if (i != 0) {
            UIView *threadView = [[UIView alloc]initWithFrame:CGRectMake(10, i*(15+30) , kScreenWidth-20, 1)];
            threadView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
            [thirdView addSubview:threadView];
        }
    }
    //用工薪酬
    payTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth - 165, 5, kScreenWidth-(kScreenWidth-150), 35)];
    payTextField.placeholder = @"输入金额 0.00";
    payTextField.keyboardType = UIKeyboardTypeNumberPad;
    payTextField.font = [UIFont systemFontOfSize:15];
    payTextField.textAlignment = NSTextAlignmentRight;
    payTextField.textColor = [UIColor hx_colorWithHexRGBAString:@"c7c7cd"];
    payTextField.delegate = self;
    [payTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [thirdView addSubview:payTextField];
    
    //保险费
    UIButton *insurancePremiumBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth - 115), CGRectGetMaxY(payTextField.frame)+5, kScreenWidth-100-25, 44)];
    UIImageView *insurancePremiumImage = [[UIImageView alloc]initWithFrame:CGRectMake(insurancePremiumBtn.mj_w-22, (44-22)/2, 22, 22)];
    insurancePremiumImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
    UILabel *insurancePremiumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (44-22)/2, insurancePremiumBtn.mj_w-22, 22)];
    insurancePremiumLabel.textAlignment = NSTextAlignmentRight;
    insurancePremiumLabel.text = @"该功能尚未开完全敬请期待";
    insurancePremiumLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
    insurancePremiumLabel.font = [UIFont systemFontOfSize:14];
    [insurancePremiumBtn addTarget:self action:@selector(insurancePremium) forControlEvents:UIControlEventTouchUpInside];
    [insurancePremiumBtn addSubview:insurancePremiumImage];
    [insurancePremiumBtn addSubview:insurancePremiumLabel];
    [thirdView addSubview:insurancePremiumBtn];
    

    //手续费
    UIButton *handlingChargeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth - 115), CGRectGetMaxY(insurancePremiumBtn.frame)+5, kScreenWidth-100-30, 44)];
//    UIImageView *handlingChargeImage = [[UIImageView alloc]initWithFrame:CGRectMake(handlingChargeButton.mj_w-22, (44-22)/2, 22, 22)];
//    handlingChargeImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
    handlingChargeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (44-22)/2, handlingChargeButton.mj_w, 22)];
    handlingChargeLabel.textAlignment = NSTextAlignmentRight;
    handlingChargeLabel.text = @"0.00";
    handlingChargeLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
    handlingChargeLabel.font = [UIFont systemFontOfSize:14];
//    [handlingChargeButton addTarget:self action:@selector(handlingCharge) forControlEvents:UIControlEventTouchUpInside];
//    [handlingChargeButton addSubview:handlingChargeImage];
    [handlingChargeButton addSubview:handlingChargeLabel];
    [thirdView addSubview:handlingChargeButton];

    //总花费
    AlwaysRememberToSpendLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 165, CGRectGetMaxY(handlingChargeButton.frame), kScreenWidth-(kScreenWidth-150), 35)];
    AlwaysRememberToSpendLabel.text = @"0.00";
    AlwaysRememberToSpendLabel.font = [UIFont systemFontOfSize:15];
    AlwaysRememberToSpendLabel.textAlignment = NSTextAlignmentRight;
    AlwaysRememberToSpendLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    [thirdView addSubview:AlwaysRememberToSpendLabel];
    
    UIButton *instructionsButton  = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(thirdView.frame), kScreenWidth-30, 27.5)];
    UIImageView *instructionsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (instructionsButton.mj_h-14)/2, 14, 14)];
    instructionsImageView.image = [UIImage imageNamed:@"yg_syfb_nr_tb2"];
    [instructionsButton addSubview:instructionsImageView];
    UILabel *instructionsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(instructionsImageView.frame)+4, 0, instructionsButton.mj_w - 18, instructionsButton.mj_h)];
    instructionsLabel.font = [UIFont systemFontOfSize:14];
    instructionsLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    instructionsLabel.text = @"手续费扣除说明";
    [instructionsButton addSubview:instructionsLabel];
    [instructionsButton addTarget:self action:@selector(instructionsUpInside) forControlEvents:UIControlEventTouchUpInside];
    [bjScrollView addSubview:instructionsButton];
    
    //第四块
    UIView *fourthView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(instructionsButton.frame), kScreenWidth, 44)];
    fourthView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:fourthView];
    
    UILabel *constructionSiteLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
    constructionSiteLabel.text = @"用工地址";
    constructionSiteLabel.font = [UIFont systemFontOfSize:14];
    constructionSiteLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"434343"];
    [fourthView addSubview:constructionSiteLabel];
    
    //用工地址
    UIButton *addressButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-(kScreenWidth - 115),0, kScreenWidth-100-25, 44)];
    UIImageView *addressImage = [[UIImageView alloc]initWithFrame:CGRectMake(addressButton.mj_w-22, (44-22)/2, 22, 22)];
    addressImage.image = [UIImage imageNamed:@"yg_syfb_nr_tb1"];
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (44-22)/2, addressButton.mj_w-22, 22)];
    addressLabel.textAlignment = NSTextAlignmentRight;
    addressLabel.text = @"请选择工作地点";
    addressLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"282828"];
    addressLabel.font = [UIFont systemFontOfSize:14];
    [addressButton addTarget:self action:@selector(address) forControlEvents:UIControlEventTouchUpInside];
    [addressButton addSubview:addressImage];
    [addressButton addSubview:addressLabel];
    [fourthView addSubview:addressButton];
    
    //第五块
    UIView *fifthView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fourthView.frame)+10, kScreenWidth, 341)];
    fifthView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f5f5f5"];
    [bjScrollView addSubview:fifthView];
    
    UIButton *commonlyUsedAddressButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 6, kScreenWidth-30, 28)];
    commonlyUsedAddressButton.backgroundColor = [UIColor whiteColor];
    commonlyUsedAddressButton.clipsToBounds = YES;
    commonlyUsedAddressButton.layer.cornerRadius = 4;
    commonlyUsedAddressButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [commonlyUsedAddressButton setTitle:@"选择常用地址" forState:UIControlStateNormal];
    [commonlyUsedAddressButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
    [commonlyUsedAddressButton addTarget:self action:@selector(commonlyUsedAddress) forControlEvents:UIControlEventTouchUpInside];
    [fifthView addSubview:commonlyUsedAddressButton];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(15, 40, kScreenWidth-30, 301)];
    _mapView.zoomLevel = 19;//地图显示比例
    _mapView.mapType = BMKMapTypeStandard;//设置地图为空白类型
    [fifthView addSubview:_mapView];
    self.mapView.gesturesEnabled = NO;
    [self initlocationService];
    
    
    
    //第6块
    sixthView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fifthView.frame)+10, kScreenWidth, 212)];
    sixthView.backgroundColor = [UIColor whiteColor];
    [bjScrollView addSubview:sixthView];
    
    self.contentContactInformationTextView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15, 17, kScreenWidth - 30, 94)];
    _contentContactInformationTextView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    _contentContactInformationTextView.placeholder = @"输入内容及联系方式...";
    _contentContactInformationTextView.font = [UIFont systemFontOfSize:15];
    _contentContactInformationTextView.maxLength = 200;
    [sixthView addSubview:_contentContactInformationTextView];
    
    [_contentContactInformationTextView didChangeText:^(PlaceholderTextView *textView) {
        phone = textView.text;
        NSLog(@"%@",textView.text);
    }];
    
    [self choosePictureButton];
    
    UIButton *postedButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sixthView.frame)+10.5, kScreenWidth, 45)];
    postedButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
    [postedButton setTitle:@"发布" forState:UIControlStateNormal];
    [postedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postedButton addTarget:self action:@selector(posted:) forControlEvents:UIControlEventTouchUpInside];
    [bjScrollView addSubview:postedButton];
    
    
    bjScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(postedButton.frame)+64);
    bjScrollView.showsVerticalScrollIndicator = NO;
    bjScrollView.bounces = NO;
    [self.view addSubview:bjScrollView];
}
#pragma mark 平台收费提示
- (void)instructionsUpInside
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"平台收费标准" message:@"按照成交订单每人次一元计算收取，不成交订单平台不扣除手续费" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"action = %@", action);
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];

}



#pragma mark TextField代理方法
//限制输入字数
- (void)textFieldDidChange:(UITextField *)textField
{
    UITextRange *rang = textField.markedTextRange; // 获取非=选中状态文字范围
    if (rang == nil) { // 没有非选中状态文字.就是确定的文字输入
        if (textField == headingsTextField) {
            if (textField.text.length > 14) {
                textField.text = [textField.text substringToIndex:14];
            }
        }
    }
    
    
    
    if (peopleNumberTextField.text.length != 0 && payTextField.text.length != 0 && ![startTimeLabel.text isEqualToString:@"选择开始时间"] && ![endTimeLabel.text isEqualToString:@"选择结束时间"]) {
     
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/gongdan/shouXuFei",kPRTURL];
        
        int peopleNumberString = [peopleNumberTextField.text intValue];
        CGFloat payString = [payTextField.text floatValue];
        NSDictionary *parameters =
        [NSDictionary dictionaryWithObjectsAndKeys:
         @(peopleNumberString),@"renShu",
         @(yonggongshijianNub),@"shouFeiDanWei",
         @(payString),@"danJia",
         startTimeLabel.text,@"kaiShiShiJian",
         endTimeLabel.text,@"jieShuShiJian",nil];
        
        [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
            if (result == 1) {
                shouxufeiNumber = [[[responseObj objectForKey:@"data"]objectForKey:@"shouXuFei"] floatValue];
                [handlingChargeLabel setText:[NSString stringWithFormat:@"%.2f",shouxufeiNumber]];
                
                AlwaysRememberToSpendLabel.text = [NSString stringWithFormat:@"%.2f",[[[responseObj objectForKey:@"data"]objectForKey:@"zongJi"] floatValue]];
//                [self shouqijianpan];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
            
        }];
    }
}
#pragma mark 选择工种
- (void)occupation
{
    NSLog(@"选择工种");
//    occupationLabel.text = @"瓦工";
    
    WorkTypeSViewController *WorkTypeSVC = [[WorkTypeSViewController alloc]init];
    WorkTypeSVC.WorkTypeDate = _WorkTypeAry;
    [WorkTypeSVC setBlock:^(NSString *Str) {
        occupationLabel.text = Str;
    }];
    [self.navigationController pushViewController:WorkTypeSVC animated:YES];
    
    
}

#pragma mark 用工时间
- (void)skybutton:(UIButton *)btn
{
    NSLog(@"用工时间");
    UIButton *myButton1 = (UIButton *)[self.view viewWithTag:200];
    UIButton *myButton2 = (UIButton *)[self.view viewWithTag:201];
    UIButton *myButton3 = (UIButton *)[self.view viewWithTag:202];
    if (btn.tag == 200) {
        [myButton1 setBackgroundImage:[UIImage imageNamed:@"fbgz_tian"] forState:UIControlStateNormal];
        [myButton2 setBackgroundImage:[UIImage imageNamed:@"fbgz_xiaoshi_hui"] forState:UIControlStateNormal];
        [myButton3 setBackgroundImage:[UIImage imageNamed:@"fbgz_ci_hui"] forState:UIControlStateNormal];
        yonggongshijianNub = 2;
    }else if (btn.tag == 201)
    {
        [myButton1 setBackgroundImage:[UIImage imageNamed:@"fbgz_tian_hui"] forState:UIControlStateNormal];
        [myButton2 setBackgroundImage:[UIImage imageNamed:@"fbgz_xiaoshi"] forState:UIControlStateNormal];
        [myButton3 setBackgroundImage:[UIImage imageNamed:@"fbgz_ci_hui"] forState:UIControlStateNormal];
        yonggongshijianNub = 1;
    }else if (btn.tag == 202)
    {
        [myButton1 setBackgroundImage:[UIImage imageNamed:@"fbgz_tian_hui"] forState:UIControlStateNormal];
        [myButton2 setBackgroundImage:[UIImage imageNamed:@"fbgz_xiaoshi_hui"] forState:UIControlStateNormal];
        [myButton3 setBackgroundImage:[UIImage imageNamed:@"fbgz_ci"] forState:UIControlStateNormal];
        yonggongshijianNub = 3;
    }
    
    
    
    
}
#pragma mark 开始时间
- (void)startTime
{
    NSLog(@"开始时间");
    [self shouqijianpan];
    [self xuanzeshijian:@"startTime"];

}
#pragma mark 结束时间
- (void)endTime
{
    NSLog(@"结束时间");
    [self shouqijianpan];
    [self xuanzeshijian:@"endTime"];
}

#pragma mark 手续费
- (void)handlingCharge
{
    NSLog(@"手续费");
    [self shouqijianpan];
    
    if (peopleNumberTextField.text.length != 0 && payTextField.text.length != 0 && ![startTimeLabel.text isEqualToString:@"选择开始时间"] && ![endTimeLabel.text isEqualToString:@"选择结束时间"]) {
    
        NSString *urlStr = [NSString stringWithFormat:@"%@/gongdan/shouXuFei",kPRTURL];
    
        int peopleNumberString = [peopleNumberTextField.text intValue];
        CGFloat payString = [payTextField.text floatValue];
        NSDictionary *parameters =
        [NSDictionary dictionaryWithObjectsAndKeys:
         @(peopleNumberString),@"renShu",
         @(yonggongshijianNub),@"shouFeiDanWei",
         @(payString),@"danJia",
         startTimeLabel.text,@"kaiShiShiJian",
         endTimeLabel.text,@"jieShuShiJian",nil];
    
        [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
            if (result == 1) {
                shouxufeiNumber = [[[responseObj objectForKey:@"data"]objectForKey:@"shouXuFei"] floatValue];
                [handlingChargeLabel setText:[NSString stringWithFormat:@"%.2f",shouxufeiNumber]];
            
                AlwaysRememberToSpendLabel.text = [NSString stringWithFormat:@"%.2f",[[[responseObj objectForKey:@"data"]objectForKey:@"zongJi"] floatValue]];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
        
        }];
    }else
    {
        return;
    }
}

#pragma mark 用工地址
- (void)address
{
    NSLog(@"用工地址");
    [self shouqijianpan];
    CommonAddressViewController *CommonAddressVC = [[CommonAddressViewController alloc]init];
    CommonAddressVC.SelectAddress = @"yes";
    __weak typeof(self) weakSelf = self;
    [CommonAddressVC setBlock:^(NSString *str, CGFloat Y, CGFloat X) {
        [addressLabel setText:str];
        weakSelf.latitudeY = Y;
        weakSelf.longitudeX = X;
    }];
    [self.navigationController pushViewController:CommonAddressVC animated:YES];
}

#pragma mark 选择常用地址
- (void)commonlyUsedAddress
{
    NSLog(@"选择常用地址");
    [self shouqijianpan];
    
    
    CommonAddressViewController *CommonAddressVC = [[CommonAddressViewController alloc]init];
    CommonAddressVC.SelectAddress = @"yes";
    __weak typeof(self) weakSelf = self;
    [CommonAddressVC setBlock:^(NSString *str, CGFloat Y, CGFloat X) {
        [addressLabel setText:str];
        weakSelf.latitudeY = Y;
        weakSelf.longitudeX = X;
    }];
    [self.navigationController pushViewController:CommonAddressVC animated:YES];
}
#pragma mark 选择图片
- (void)choosePicture
{
//    NSLog(@"选择图片");
//    [self shouqijianpan];
//    
//    HeadJumpViewController *HeadJumpVC = [[HeadJumpViewController alloc]init];
//    HeadJumpVC.tupianshu = @"4";
//    HeadJumpVC.Images = choosePictureButton.imageView.image;
////    __block __typeof(self) weakSelf = self;
////    [HeadJumpVC setBlock:^(UIImage *image)
////     {
////         [choosePictureButton setImage:image forState:UIControlStateNormal];
////         NSData *data = UIImageJPEGRepresentation(image, 1.0f);
////         NSString *imagestr = [ToHireViewController typeForImageData:data];
////         NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
////         NSDictionary *parameters =
////         [NSDictionary dictionaryWithObjectsAndKeys:encodedImageStr,imagestr,nil];
////         [self.dicAry addObject:parameters];
////
////     }];
//    __weak typeof(self)weakself = self;
//    [HeadJumpVC setBlocks:^(NSArray *ary) {
////        self.dicAry = ary;
//        for (int i = 0; i< ary.count; i++) {
//            NSData *data = [weakself zipNSDataWithImage:ary[i]];
//            NSString *imagestr = [ToHireViewController typeForImageData:data];
//            NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//             NSDictionary *parameters =
//             [NSDictionary dictionaryWithObjectsAndKeys:encodedImageStr,imagestr,nil];
//             [weakself.dicAry addObject:parameters];
//        }
//        
//        
//        
//        
//    }];
//    
//    [self.navigationController pushViewController:HeadJumpVC animated:YES];
    
    
    
    __weak typeof(self) weakSelf = self;
    
    TJLActionSheet *sheet = [[TJLActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:2 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [[TJLImagePickerController sharedInstance] showCameraInController:self successBlock:^(UIImage *image) {
                [weakSelf.ImageAry addObject:image];
                [weakSelf SetImageViewWithImage:weakSelf.ImageAry];
                NSData *data = [weakSelf zipNSDataWithImage:image];
                NSString *imagestr = [ToHireViewController typeForImageData:data];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                NSDictionary *parameters =
                [NSDictionary dictionaryWithObjectsAndKeys:encodedImageStr,imagestr,nil];
                [weakSelf.dicAry addObject:parameters];
            }];
        } else if (buttonIndex == 1) {
            [[TJLImagePickerController sharedInstance] showPickerInController:self total:4-self.ImageAry.count successBlock:^(NSArray *imageArray) {
                [weakSelf.ImageAry addObjectsFromArray:imageArray.mutableCopy];
                [weakSelf SetImageViewWithImage:weakSelf.ImageAry];
                for (int i = 0; i< imageArray.count; i++) {
                                NSData *data = [weakSelf zipNSDataWithImage:imageArray[i]];
                                NSString *imagestr = [ToHireViewController typeForImageData:data];
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





#pragma mark 发布
- (void)posted:(UIButton *)btn
{
    btn.userInteractionEnabled = NO;
    NSLog(@"发布");
    if (headingsTextField.text.length == 0 || headingsTextField.text == nil) {
        [self showInfoWithTitle:@"标题不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if (occupationLabel.text.length == 0 || [occupationLabel.text isEqualToString:@"选择工种"])
    {
        [self showInfoWithTitle:@"工种不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if ([self inputShouldNumber:peopleNumberTextField.text]== NO){
        btn.userInteractionEnabled = YES;
        return;
    }else if (startTimeLabel.text.length == 0 || startTimeLabel.text == nil)
    {
        [self showInfoWithTitle:@"开始时间不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if (endTimeLabel.text.length == 0 || endTimeLabel.text == nil)
    {
        [self showInfoWithTitle:@"结束时间不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if (addressLabel.text.length == 0 || addressLabel.text == nil)
    {
        [self showInfoWithTitle:@"用工地址不能为空" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if ([addressLabel.text isEqualToString:@"请选择工作地点"])
    {
        [self showInfoWithTitle:@"请选择工作地点" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if(_dicAry.count < 2)
    {
        [self showInfoWithTitle:@"工作图片不得少于2张" autoCloseTime:2];
        btn.userInteractionEnabled = YES;
        return;
    }else if([self inputNumber:payTextField.text] == NO)
    {
        btn.userInteractionEnabled = YES;
        return;
    }
    
    NSInteger yonggongrenshuNumber = [peopleNumberTextField.text integerValue];
    CGFloat xinchou = [payTextField.text floatValue];
    NSArray *myArray = [self.dicAry copy];
    NSString *text = [RankingTotalModel arrayToJson:myArray];
    NSDictionary *parameters =
    [[NSDictionary alloc]initWithObjectsAndKeys:
     @(Global.userInfoId),@"zhangGuiId",
     headingsTextField.text,@"biaoTi",
     occupationLabel.text,@"jiNeng",
     @(yonggongrenshuNumber),@"yongGongRenShu",
     @(yonggongshijianNub),@"yongGongShiJian",
     startTimeLabel.text,@"kaiShi",
     endTimeLabel.text,@"jieShu",
     @(xinchou),@"xinChou",
     handlingChargeLabel.text,@"shouXuFei",
     AlwaysRememberToSpendLabel.text,@"zongJi",
     addressLabel.text,@"diZhi",
     phone,@"gongZuoNeiRong",
     text,@"tuPians",
     @(self.latitudeY),@"Y",
     @(self.longitudeX),@"X",
     nil];

    NSString *urlStr = [NSString stringWithFormat:@"%@/gongdan/fabu",kPRTURL];
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];

        if (result == 1) {
            NSInteger recruitInfoId = [[responseObj valueForKeyWithNullDetection:@"data"] integerValue];
            [self.view showRightWithTitle:@"资料上传成功" autoCloseTime:2];
            if (recruitInfoId != 0) {
                FaBuZhiFuViewController *FaBuZhiFuVC = [[FaBuZhiFuViewController alloc] init];
                FaBuZhiFuVC.parameters = parameters;
                FaBuZhiFuVC.recruitInfoId = [[responseObj objectForKey:@"data"] integerValue];
                [self.navigationController pushViewController:FaBuZhiFuVC animated:YES];
            }
        }else
        {

        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);

    }];
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


#pragma mark - 时间选择
- (void)xuanzeshijian:(NSString *)str
{
    __weak typeof(self) weakSelf = self;
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        if ([str isEqualToString:@"startTime"]) {
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            NSLog(@"选择的日期：%@",date);
            startTimeLabel.text = date;
            [weakSelf handlingCharge];
        }else{
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            NSLog(@"选择的日期：%@",date);
            endTimeLabel.text = date;
            [weakSelf handlingCharge];
        }
    }];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval  interval = 60 * 60 * 2; //+2小时
    NSDate *date = [nowDate initWithTimeIntervalSinceNow:+interval];
    datepicker.minLimitDate = date;
    
    datepicker.dateLabelColor = [UIColor hx_colorWith8BitRed:65 green:188 blue:241];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor hx_colorWith8BitRed:65 green:188 blue:241];//确定按钮的颜色
    [datepicker show];
}


#pragma mark 保险费
-(void)insurancePremium
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"该功能尚未开完全敬请期待" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"action = %@", action);
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark - 收起键盘
- (void)shouqijianpan
{
    [headingsTextField resignFirstResponder];
    [peopleNumberTextField resignFirstResponder];
    [payTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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





//- (void)initUI{
    //    [self goBackBtn];
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth-30, 307)];
//    _mapView.mapType=BMKMapTypeStandard;
//
//    [self.DiZhiView addSubview:_mapView];
//    [self initlocationService];
    
//}

#pragma mark --initlocationService--定位

-(void)initlocationService{
    
    _locService = [[BMKLocationService alloc]init];
    
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.showMapScaleBar = YES;//显示比例尺
    _mapView.zoomLevel = 17;//地图显示的级别
    
    _searchAddress = [[BMKGeoCodeSearch alloc]init];
    _searchAddress.delegate = self;
    
}

//这里是创建中心显示的图片和显示详细地址的View

- (void)createLocationSignImage{
    
    //LocationView定位在当前位置，换算为屏幕的坐标，创建的定位的图标
    
    self.locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 21, 24)];
    self.locImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 21, 24)];
    self.locImageView.image = [UIImage imageNamed:@"yg_sy_gddrdd_nr_tb1"];
    [self.locationView addSubview:self.locImageView];
    
    //messageView 展示定位信息的View和Label和button
    
    self.messageView = [[UIView alloc]init];
    self.messageView.backgroundColor = [UIColor whiteColor];
    
    //把当前定位的经纬度换算为了View上的坐标
    
    CGPoint point = [self.mapView convertCoordinate:_mapView.centerCoordinate toPointToView:_mapView];
    
    //当解析出现错误的时候，会出现超出屏幕的情况，一种是大于了屏幕，一种是小于了屏幕
    if(point.x > kScreenWidth || point.x < kScreenWidth/5){
        
        point.x = _mapView.centerX-30;
        point.y = _mapView.centerY-64;
        
    }
    
    NSLog(@"Point------%f-----%f",point.x,point.y);
    //重新定位了LocationView
    
    self.locationView.center = point;
    
    [self.locationView setFrame:CGRectMake(point.x-14, point.y-18, 28, 35)];
    
    //重新定位了messageView
    [self.messageView setFrame:CGRectMake(30, point.y-40-20, kScreenWidth-90, 40)];
    
    //展示地址信息的label
    self.addressLabels = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.messageView.frame.size.width - 80, 40)];
    
    self.addressLabels.font = [UIFont systemFontOfSize:13.0f];
    
    [self.messageView addSubview:self.addressLabels];
    
    //把地址信息传递到上个界面的button
    
    self.sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.addressLabels.frame.origin.x + self.addressLabels.frame.size.width, 0,self.messageView.frame.size.width - self.addressLabels.frame.origin.x - self.addressLabels.frame.size.width, 40)];
    
    [self.messageView addSubview:self.sureButton];
    
    self.sureButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBlueColor];
    
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapView addSubview:self.messageView];
    
    [self.mapView addSubview:self.locationView];
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    BMKCoordinateRegion region;
    
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];//取消定位  这个一定要写，不然无法移动定位了
    _mapView.centerCoordinate = userLocation.location.coordinate;
    NSLog(@" _mapView.centerCoordinate------%f-----%f", _mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
//    [self createLocationSignImage];
}


//确定按钮的点击
//
//- (void)sureButtonClick:(UIButton *)button{
//
//    //    if([self.chosseAddressDelegate respondsToSelector:@selector(chosseAddressBack:name:point:)]){
//    //        [self.chosseAddressDelegate chosseAddressBack:self.addressLabel.text name:self.name point:self.location2D];
//    //    }
//    //    [self.navigationController popViewControllerAnimated:YES];
//    [addressLabel setText:self.addressLabels.text];
//}

//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
//    NSLog(@"点击了");
//    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
//    pt=(CLLocationCoordinate2D){mapView.region.center.latitude,mapView.region.center.longitude};
//    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
//    option.reverseGeoPoint = pt;
//    BOOL flag=[_searchAddress reverseGeoCode:option];
//
//    if (flag) {
//        //        _mapView.showsUserLocation=NO;//不显示自己的位置
//
//    }
//}


//地图被拖动的时候，需要时时的渲染界面，当渲染结束的时候我们就去定位然后获取图片对应的经纬度

//- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status{
//    NSLog(@"onDrawMapFrame");
//}

//- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//    NSLog(@"regionWillChangeAnimated");
//}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"regionDidChangeAnimated");
    
    
    CGPoint touchPoint = self.locationView.center;
    
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
    self.latitudeY = touchMapCoordinate.latitude;
    self.longitudeX = touchMapCoordinate.longitude;
    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = touchMapCoordinate;
    BOOL flag=[_searchAddress reverseGeoCode:option];
    
    if (flag) {
        //        _mapView.showsUserLocation=NO;//不显示自己的位置
    }
}


//定位自己的位置
- (IBAction)locationButtonClick:(UIButton *)sender {
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

////点击地图的空白区域
//
//- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
//
//    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
//    self.latitudeY = coordinate.latitude;
//    self.longitudeX = coordinate.longitude;
//}

////点击地图中的背景有标记的区域
//
//- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{
//    NSLog(@"点击onClickedMapPoi---%@",mapPoi.text);
//
//    CLLocationCoordinate2D coordinate = mapPoi.pt;
//    //长按之前删除所有标注
//    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:arrayAnmation];
//    //设置地图标注
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    annotation.coordinate = coordinate;
//    annotation.title = mapPoi.text;
//    [_mapView addAnnotation:annotation];
//    BMKReverseGeoCodeOption *re = [[BMKReverseGeoCodeOption alloc] init];
//    re.reverseGeoPoint = coordinate;
//    [SVProgressHUD show];
//    [_searchAddress reverseGeoCode:re];
//    BOOL flag =[_searchAddress reverseGeoCode:re];
//    if (!flag){
//        NSLog(@"search failed!");
//    }
//}

//根据经纬度返回点击的位置的名称
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    //addressDetail:     层次化地址信息
    //
    //    //address:    地址名称
    //
    //    //businessCircle:  商圈名称
    //
    //    // location:  地址坐标
    //
    //    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
    
    
    [SVProgressHUD dismiss];
    NSString * resultAddress = @"";
    NSString * houseName = @"";
    
    CLLocationCoordinate2D  coor = result.location;
    
    if(result.poiList.count > 0){
        BMKPoiInfo * info = result.poiList[0];
        if([info.name rangeOfString:@"-"].location != NSNotFound){
            houseName = [info.name componentsSeparatedByString:@"-"][0];
        }else{
            houseName = info.name;
        }
        resultAddress = [NSString stringWithFormat:@"%@%@",result.address,info.name];
    }else{
        resultAddress =result.address;
    }
    
    if(resultAddress.length == 0){
        self.addressLabels.text = @"位置解析错误，请拖动重试！";
        return;
    }
    
    self.addressLabels.text = resultAddress;
    NSLog(@"%@",resultAddress);
    self.location2D = coor;
    self.name = houseName;
}

//点击一个大头针

//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
//    NSLog(@"点击didSelectAnnotationView-");
//}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param3a  地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
//}


/**
 *在地图View停止定位后，会调用此函数
 *@param2a  地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param1a  地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
//- (void)didFailToLocateUserWithError:(NSError *)error
//{
//    NSLog(@"location error");
//}

- (BOOL)inputNumber:(NSString *)inputString {
    if (inputString.length == 0)
    {
        [self showInfoWithTitle:@"请输入用工薪酬" autoCloseTime:2];
        return NO;
    }
    if (inputString.length > 4)
    {
        [self showInfoWithTitle:@"用工薪酬不得超过4位" autoCloseTime:2];
        return NO;
    }
    if ([inputString integerValue] <= 0)
    {
        [self showInfoWithTitle:@"用工薪酬不得为0" autoCloseTime:2];
        return NO;
    }
    NSString *subString12 = [inputString substringToIndex:1];
    if ([subString12 isEqualToString:@"0"])
    {
        [self showInfoWithTitle:@"用工薪酬不得以0开头" autoCloseTime:2];
        return NO;
    }
    return YES;
}


- (BOOL)inputShouldNumber:(NSString *)inputString {
    if (inputString.length == 0)
    {
        [self showInfoWithTitle:@"请输入用工人数" autoCloseTime:2];
        return NO;
    }
    if (inputString.length > 3)
    {
        [self showInfoWithTitle:@"用工人数不得超过3位数" autoCloseTime:2];
        return NO;
    }
    if ([inputString integerValue] == 0) {
        [self showInfoWithTitle:@"用工人数不能输入0" autoCloseTime:2];
        return NO;
    }
    NSString *subString12 = [inputString substringToIndex:1];
    if ([subString12 isEqualToString:@"0"])
    {
        [self showInfoWithTitle:@"用工人数不得以0开头" autoCloseTime:2];
        return NO;
    }
    return YES;
}

- (void)dealloc {
    
    if (_mapView) {
        _mapView = nil;
    }
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
