//
//  DingDanXiangQingSViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"

@interface DingDanXiangQingSViewController : BaseViewController

@property (assign ,nonatomic) NSInteger dingDanId;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView1;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView2;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView3;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView4;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView5;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView6;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView7;
@property (strong, nonatomic) IBOutlet UIImageView *liuchengImageView8;

@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage1;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage2;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage3;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage4;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage5;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage6;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage7;
@property (strong, nonatomic) IBOutlet UIImageView *dingdanzhuangtaiImage8;


@property (strong, nonatomic) IBOutlet UIProgressView *jinduProgressView;

@property (strong, nonatomic) IBOutlet UIView *OneView;

@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UILabel *feoyongLabel;
@property (strong, nonatomic) IBOutlet UILabel *danweiLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongjiaLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshichangLabel;

@property (strong, nonatomic) IBOutlet UILabel *gongzhongLabel;

@property (strong, nonatomic) IBOutlet UILabel *xuyaorenshuLabel;

@property (strong, nonatomic) IBOutlet UILabel *shengyurenshuLabel;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodizhiLabel;

@property (strong, nonatomic) IBOutlet UILabel *teshuyaoqiuLabel;
@property (strong, nonatomic) IBOutlet UIView *TwoView;

@property (strong, nonatomic) IBOutlet UILabel *gongdanbianhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *dingdanbianhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *baomngshijianoLabel;
@property (strong, nonatomic) IBOutlet UILabel *jiafangquerenshijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *daodashijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *wangongshijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *jiafangyanshoushijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *quxiaoSSLabel;

@property (strong, nonatomic) IBOutlet UILabel *quxiaoyuanyinLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ViewHight;

@end
