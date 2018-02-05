//
//  PingjiaSViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/7.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"
@interface PingjiaSViewController : BaseViewController
/** 打分score */
@property (nonatomic ,strong) HomeModel *homeModel;
@property (nonatomic ,assign) NSInteger dingDanId;
@property (nonatomic ,assign) NSInteger gongDanId;
@property (nonatomic ,assign) NSInteger daRenID;
@property (nonatomic,assign) NSInteger score;
@end
