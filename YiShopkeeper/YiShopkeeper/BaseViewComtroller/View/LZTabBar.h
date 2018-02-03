//
//  LZTabBar.h
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterButton.h"

//tabbar按钮点击通知协议
@class LZTabBar;
@protocol LZTabBarDelegate <NSObject>
@optional
- (void)tabBar:(LZTabBar *)tabBar didClickBtn:(NSInteger)index;
@end

@interface LZTabBar : UIView

// 点击代理人
@property (weak , nonatomic) id<LZTabBarDelegate> delegate;
// 控制器按钮属性(UITabBarItem)
@property (weak , nonatomic) NSArray *items;
// 中间按钮属性
@property (weak , nonatomic)UITabBarItem *CenterButtonitem;

@property (weak , nonatomic)UINavigationController *nav;


// 中间按钮
@property (weak, nonatomic) CenterButton *bigButton;
// 其他按钮
@property (strong , nonatomic) NSMutableArray* OtherButtons;
// 选中按钮
@property (weak, nonatomic) UIButton *selButton;
// 选中的索引
@property (assign , nonatomic) NSInteger seletedIndex;
// 外部设置索引跳转页面
- (void)setSeletedIndex:(NSInteger)seletedIndex;

@end
