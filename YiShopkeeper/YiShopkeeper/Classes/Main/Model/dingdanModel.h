//
//  dingdanModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/19.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dingdanModel : NSObject
@property (strong ,nonatomic) NSString   *daRenMingCheng;
@property (strong ,nonatomic) NSString   *daRenTouXiang;
@property (strong ,nonatomic) NSString   *baoMingShiJian;
@property (strong ,nonatomic) NSString   *kaiShiShiJian;
@property (strong ,nonatomic) NSString   *gongZhong;
@property (strong ,nonatomic) NSString   *diZhi;
@property (assign ,nonatomic) NSUInteger gongZuoShiChang;
@property (assign ,nonatomic) NSUInteger dingDanZhuangTai;
@property (assign ,nonatomic) NSUInteger zhangGuiId;
@property (assign ,nonatomic) NSUInteger gongDanId;
@property (assign ,nonatomic) NSUInteger dingDanId;
@property (assign ,nonatomic) NSUInteger daRenId;
@property (assign ,nonatomic) double    zongJi;
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
