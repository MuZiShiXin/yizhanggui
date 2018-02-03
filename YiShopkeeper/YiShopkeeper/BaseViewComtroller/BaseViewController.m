//
//  BaseViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic) CGFloat halfHeight;
@end

@implementation BaseViewController
{
    BOOL                      isHideBackButton;
    BOOL                      isHideRightButton;
    BOOL                      isHideNavigation;
    BOOL                      isHideTitelLabel;
    UIImage                   *backImg;
}
@synthesize titelLabel,LeftBtnImv,backButton,closeButton;
@synthesize navigationView;
@synthesize NVBJImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self._delegate = self;
        isHideBackButton = NO;
        isHideRightButton = NO;
        isHideTitelLabel = NO;
        
    }
    return self;
}
//UIStatusBarStyleDefault         状态栏文字黑色
//UIStatusBarStyleLightContent    状态栏文字白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    isHideNavigation = [self._delegate isHideNavigation];
    isHideBackButton = [self._delegate isHideBackButton];
    [self initNavigationImageView];
    [self initNavigation];
    
    [self.view addSubview:NVBJImageView];
    [self.view addSubview:navigationView];//添加自定义的导航条
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"fafafa"];
}
/*
 @param  navitationview  导航条
 @param  tag             获取导航条的标识
 */

//创建导航条及导航标题
- (UIView *)CreateNavigation
{
    
    id NavigationView;
    
    if (IOS7)
    {
        NavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,iPhoneX ? iPhoneX_Hight:iPhone_Hight)];
        [NavigationView setTag:iNavgationTag];
        [NavigationView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:NavigationView];
    }
    else
    {
        NavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth,iPhoneX ? iPhoneX_Hight:iPhone_Hight)];
        [NavigationView setTag:iNavgationTag];
        [(UIView *)NavigationView setBackgroundColor:[UIColor clearColor]];
        
    }
    
    titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(55,15, kScreenWidth-55-55, iPhoneX ? iPhoneX_Hight-5-5 :iPhone_Hight-5-5)];
    [titelLabel setTextAlignment:NSTextAlignmentCenter];
    [titelLabel setTextColor:[UIColor blackColor]];
    [titelLabel setFont:[UIFont boldSystemFontOfSize:17.f]];
    [titelLabel setBackgroundColor:[UIColor clearColor]];
    [titelLabel setTag:102];
    [titelLabel setHidden:[self._delegate isHideTitelLabel]];
    
    [NavigationView addSubview:titelLabel];
    
    
    
    
    return NavigationView;
}

-(UIButton *)CreateNavigationBackButton
{
    
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"yg_dhl_tb1"];
    imageView.frame = CGRectMake(9, (44-22)/2.0, 22, 22);
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    [btnBack setBackgroundColor:[UIColor clearColor]];
    [btnBack addSubview:imageView];
    if ([self._delegate isHideNavigation])
    {
        [btnBack setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:155.0f/255.0f blue:155.0f/255.0f alpha:0.75]];
        [[btnBack layer] setCornerRadius:5];
    }
    return btnBack;
}

- (UIButton *)createNavigationCloseButton {
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backButton.frame), backButton.mj_y, 50, backButton.mj_h)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    
    return closeBtn;
    
}

//创建导航条及导航标题
- (UIImageView *)NavigationImageView
{
    NVBJImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,iPhoneX ? iPhoneX_Hight:iPhone_Hight)];
    NVBJImageView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#FAFAFA"];
    NVBJImageView.alpha = 0;
    [self.view addSubview:NVBJImageView];
    return NVBJImageView;
}


- (void)initNavigationImageView
{
    NVBJImageView = [self NavigationImageView];
}

-(void)initNavigation
{
    navigationView = [self CreateNavigation];
    [navigationView setHidden:[self._delegate isHideNavigation]];
    backButton = [self CreateNavigationBackButton];
    [backButton setHidden:[self._delegate isHideBackButton]];
    [navigationView addSubview:backButton];
    
    if (self.navigationController.viewControllers.count > 4) {
//        closeButton = [self createNavigationCloseButton];
//        [navigationView addSubview:closeButton];
//        [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
}

//返回事件
- (void)backAction:(id)sender
{
    //    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.wise.e-mba299-test"]){
        
    }else{
        //        [MTA trackPageViewBegin:self.title?self.title:@"无标题"];
    }
}

- (void)closeAction:(UIButton *)sender {
    //    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleIdentifier isEqualToString:@"com.wise.e-mba299-test"]){
        
    }else{
        //        [MTA trackPageViewEnd:self.title?self.title:@"无标题"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma QJQW_BaseViewDelegate
-(BOOL)isHideNavigation
{
    return isHideNavigation;
}
//隐藏返回按钮
- (BOOL)isHideBackButton
{
    return isHideBackButton;
}
- (BOOL)isHideRightButton
{
    return NO;
}
//隐藏标题

- (BOOL)isHideTitelLabel
{
    return isHideTitelLabel;
}
- (void)dealloc
{
    NSLog(@"控制器被dealloc: %@", [[self class]description]);
}

@end
