//
//  gongdanxiangqingView.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/5.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gongzuoxinxiModel.h"
@interface gongdanxiangqingView : UIView
@property (strong, nonatomic) IBOutlet UIScrollView *bjScrollView;

@property (strong, nonatomic) IBOutlet UILabel *gongdanbiaotineirongLabel;
@property (strong, nonatomic) IBOutlet UILabel *fabushijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *qianLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *yonggongshichangLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzhong;
@property (strong, nonatomic) IBOutlet UILabel *xuyaorenshu;
@property (strong, nonatomic) IBOutlet UILabel *shengyurenshu;
@property (strong, nonatomic) IBOutlet UILabel *yibaorenshu;
@property (strong, nonatomic) IBOutlet UILabel *gongdanbianhao;

@property (strong, nonatomic) IBOutlet UILabel *teshuyaoqiu;
@property (strong, nonatomic) IBOutlet UIView *OneView;
@property (strong, nonatomic) IBOutlet UIView *TwoView;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoxiangxidizhi;
@property (strong, nonatomic) IBOutlet UIView *ThreeView;
@property (strong, nonatomic) IBOutlet UILabel *gongzuohuanjing;

@property (strong, nonatomic) IBOutlet UIButton *quxiaogongdan;
@property (strong, nonatomic) gongzuoxinxiModel *model;
@end
