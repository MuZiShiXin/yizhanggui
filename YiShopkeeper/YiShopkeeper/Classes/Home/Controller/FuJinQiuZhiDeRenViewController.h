//
//  FuJinQiuZhiDeRenViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
//#import "baomingxinxiModel.h"
@interface FuJinQiuZhiDeRenViewController : BaseViewController
@property (strong ,nonatomic) UINavigationController *Navi;
@property (assign ,nonatomic) NSInteger userDrId;
@property (assign ,nonatomic) NSInteger userZgId;
@property (assign ,nonatomic) NSInteger recruitNum; //需要
@property (assign ,nonatomic) NSInteger appliedPeoNum;//以报
@property (assign ,nonatomic) NSInteger lastPeoNum;//剩余

//@property (strong ,nonatomic) baomingxinxiModel *model;
@end
