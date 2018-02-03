//
//  BaseTabBarController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "HireViewController.h"
#import "OrderViewController.h"
@interface BaseTabBarController ()<LZTabBarDelegate>
//保存所有控制器对应按钮的属性
@property (strong , nonatomic) NSMutableArray *items;
//保存中间按钮对应按钮的属性
@property (strong , nonatomic)UITabBarItem *CenterButtonitem;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //子控制器
    HomeViewController  * HomeVC  =[[HomeViewController alloc]init];
    NewsViewController * NewsVC =[[NewsViewController alloc]init];
//    HireViewController  * HireVC  =[[HireViewController alloc]init];
    OrderViewController * OrderVC =[[OrderViewController alloc]init];
    MainViewController  * MainVC  =[[MainViewController alloc]init];
    //其他按钮
    [self addOneChildController:HomeVC
                          title:@"首页"
                      imageName:@"yg_xx_dbl_tb5"
              selectedImageName:@"yg_sy_dbl_tb1"];
    [self addOneChildController:NewsVC
                          title:@"消息"
                      imageName:@"yg_wd_dbl_tb6"
              selectedImageName:@"yg_xx_dbl_tb2"];
    
    [self addOneChildController:OrderVC
                          title:@"订单"
                      imageName:@"yg_wd_dbl_tb7"
              selectedImageName:@"yg_wddd_dbl_tb3"];
    [self addOneChildController:MainVC
                          title:@"我的"
                      imageName:@"yg_wddd_dbl_tb8"
              selectedImageName:@"yg_wd_dbl_tb4"];
    
    
    //中间按钮
    [self addCenterButtonTitle:@"招工"
                         image:@"yg_wddd_dbl_tb9"
                 selectedImage:@"yg_wddd_dbl_tb9"];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveFriendApplyMessages:) name:@"ReceiveFriendApplyMessages" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shouldRemoveFriendApply:) name:@"RemoveFriendApply" object:nil];
    
    //    NSArray* controllers = @[FirstVC, ThirdVC,FourthVC,FifthVC];
    //    [self setViewControllers:controllers animated:YES];
    //    [self setSelectedIndex:0];
}


#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载自定义tabbar
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yg_sy_dbq"]];
    image.frame = CGRectMake(0, kScreenHeight-74, kScreenWidth, 74);
    [self.view addSubview:image];
    
    
    [self.view addSubview:self.tabbar];
    
    //干掉系统tabBar
    self.tabBar.hidden = YES;
    [self.tabBar removeFromSuperview];
    
    for (UIView *loop in self.tabBar.subviews) {
        if (![loop isKindOfClass:[LZTabBar class]]) {
            [loop removeFromSuperview];
        }
    }
}

//#pragma mark 通知
//- (void)didReceiveFriendApplyMessages:(NSNotification*)notification{
//    NSInteger badgeValue = [notification.object integerValue];
//    if (badgeValue > 0) {
//    }
//}
//- (void)shouldRemoveFriendApply:(NSNotification*)notification{
//}


#pragma mark - 设置中间凸出按钮
- (void)addCenterButtonTitle:(NSString *)Title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    if (!_CenterButtonitem) {
        //设置按钮属性
        UITabBarItem * TabBarItem = [[UITabBarItem alloc]initWithTitle:Title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
        //记录按钮对应内容
        _CenterButtonitem = TabBarItem;
    }
}


#pragma mark - 设置子控制器按钮
- (void)addOneChildController:(UIViewController *)Controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    Controller.tabBarItem.title = title;
    // 设置图标
    Controller.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Controller.tabBarItem.selectedImage = selectedImage;
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:Controller.tabBarItem];
    // 添加为tabbar控制器的子控制器
    [self addChildViewController:Controller];
}

#pragma mark - tabBar上按钮的点击切换控制器 Delegate方法
- (void)tabBar:(LZTabBar *)tabBar didClickBtn:(NSInteger)index{
    [super setSelectedIndex:index];
}

#pragma mark - 懒加载
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (LZTabBar *)tabbar{
    if (!_tabbar) {
        // 初始化tabBar
        _tabbar = [[LZTabBar alloc]init];
        _tabbar.CenterButtonitem = self.CenterButtonitem;
        _tabbar.delegate = self;
        _tabbar.backgroundColor = [UIColor whiteColor];
//        _tabbar.image = [UIImage imageNamed:@"yg_sy_dbq"];
        //保存tabbar的属性
        _tabbar.items = self.items;
        
        _tabbar.frame = self.tabBar.frame;
        _tabbar.nav = self.navigationController;
        //默认选中0
        [_tabbar setSeletedIndex:0];
    }
    return _tabbar;
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ReceiveFriendApplyMessages" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"RemoveFriendApply" object:nil];
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
