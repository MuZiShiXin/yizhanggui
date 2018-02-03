//
//  MyCollectionTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionView.h"
#import "SCModel.h"
typedef void (^MyCollectionBlock)(NSString *);
@interface MyCollectionTableViewCell : UITableViewCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataDic:(SCModel *)Model;
@property (nonatomic ,strong) MyCollectionBlock block;

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
@property (nonatomic, strong) MyCollectionView *labellingView;
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
