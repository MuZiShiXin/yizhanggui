//
//  BaseTabBarController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTabBar.h"
@interface BaseTabBarController : UITabBarController

//tabbar
@property (nonatomic, strong) LZTabBar *tabbar;

//设置中间凸出按钮
- (void)addCenterButtonTitle:(NSString *)Title
                       image:(NSString *)image
               selectedImage:(NSString *)selectedImage;

//设置子控制器按钮
- (void)addOneChildController:(UIViewController *)Controller
                        title:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName;


@end
