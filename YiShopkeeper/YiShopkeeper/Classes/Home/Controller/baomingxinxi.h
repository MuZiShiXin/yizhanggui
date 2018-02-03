//
//  baomingxinxi.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gongzuoxinxiModel.h"
@interface baomingxinxi : UIView
- (instancetype)initWithFrame:(CGRect)frame GongZuoXinXi:(gongzuoxinxiModel *)Model;
@property (strong ,nonatomic)gongzuoxinxiModel *Models;
- (void)layoutSubviews;
@property (nonatomic ,strong)UINavigationController *Navi;
@end
