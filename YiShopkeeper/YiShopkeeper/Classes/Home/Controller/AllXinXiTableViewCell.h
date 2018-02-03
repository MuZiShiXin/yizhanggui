//
//  AllXinXiTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "baomingxinxiModel.h"
@interface AllXinXiTableViewCell : UITableViewCell
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath baomingxinxiModel:(baomingxinxiModel *)maodel nav:(UINavigationController *)Navi;
@property (strong, nonatomic) baomingxinxiModel *model;
@property (strong ,nonatomic) UINavigationController *Navi;
@property (strong, nonatomic) IBOutlet UILabel *shoucangLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shoucangImageView;
@property (strong, nonatomic) IBOutlet UIButton *shoucangButton;
@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;
@property (strong, nonatomic) IBOutlet UILabel *nianlingLabel;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *xingbieImageVIew;
@property (strong, nonatomic) IBOutlet UILabel *gonglingLabel;
@property (strong, nonatomic) IBOutlet UILabel *labellingView1;
@property (strong, nonatomic) IBOutlet UILabel *labellingView2;
@property (strong, nonatomic) IBOutlet UILabel *labellingView3;
@property (strong, nonatomic) IBOutlet UILabel *labellingView4;
@property (strong, nonatomic) IBOutlet UILabel *labellingView5;
@property (strong, nonatomic) IBOutlet UILabel *jianjieLabel;
@property (strong, nonatomic) IBOutlet UIButton *oneButtons;
@property (strong, nonatomic) IBOutlet UIButton *twoButtons;
@property (strong, nonatomic) IBOutlet UIImageView *juliImageView;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth5;


@end
