//
//  BasicDisplayTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/22.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWContentView.h"
#import "HomeModel.h"

typedef void (^BasicDisplayTCBlock)(NSIndexPath *);
@interface BasicDisplayTableViewCell : UITableViewCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath Model:(HomeModel *)dic;
@property (nonatomic ,strong) UINavigationController *Navi;

@property (nonatomic ,strong) BasicDisplayTCBlock block;


@property (nonatomic ,strong) HomeModel *Homemodel;
@property (nonatomic ,strong) NSIndexPath *HomeIndexPahh;
@property (nonatomic ,assign) NSInteger resultNmb;

// 头像
@property (nonatomic, strong) UIImageView *headImageView;
// 姓名
@property (nonatomic, strong) UILabel *nameLabel;
// 年龄
@property (nonatomic, strong) UILabel *ageLabel;
// 性别
@property (nonatomic, strong) UIImageView *genderImageView;
// 工龄
@property (nonatomic, strong) UILabel *lengthLabel;
// 标签
@property (nonatomic, strong) UILabel *labellingView1;
@property (nonatomic, strong) UILabel *labellingView2;
@property (nonatomic, strong) UILabel *labellingView3;
@property (nonatomic, strong) UILabel *labellingView4;
@property (nonatomic, strong) UILabel *labellingView5;

// 收藏图片
@property (nonatomic, strong) UIImageView *collectImageView;
//收藏文字
@property (nonatomic, strong) UILabel *collectLabel;
// 收藏
@property (nonatomic, strong) UIButton *collectButton;
// 线
@property (nonatomic, strong) UIView *lineView;
// 简介
@property (nonatomic, strong) UILabel *profileLabel;
// 线
@property (nonatomic, strong) UIView *lineView1;
// 移除
@property (nonatomic, strong) UIButton *removeButton;
// 确定
@property (nonatomic, strong) UIButton *confirmButton;
// 线
@property (nonatomic, strong) UIView *lineView2;



@end
