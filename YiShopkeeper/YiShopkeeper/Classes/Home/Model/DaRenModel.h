//
//  DaRenModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/16.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaRenModel : NSObject
@property (assign ,nonatomic) NSInteger zhangGuiId;
@property (assign ,nonatomic) NSInteger daRenId;
@property (assign ,nonatomic) NSInteger gongDanId;
@property (assign ,nonatomic) NSInteger dingDanId;
@property (strong ,nonatomic) NSString  *niCheng;
@property (strong ,nonatomic) NSString  *touXiang;
@property (assign ,nonatomic) NSInteger nianLing;
@property (assign ,nonatomic) NSInteger *gongLing;
@property (strong ,nonatomic) NSArray  *gongZhongs;
@property (strong ,nonatomic) NSString  *neiRong;
@property (strong ,nonatomic) NSString  *xingBie;
@property (assign ,nonatomic) NSInteger dingDanZhuangTai;
@property (assign ,nonatomic) NSInteger shouCang;
@property (assign ,nonatomic) NSInteger chengDanShu;
@property (assign ,nonatomic) double    zhunShi;
@property (assign ,nonatomic) double    zhiLiang;
@property (assign ,nonatomic) double    xiaoLv;
@property (assign ,nonatomic) double    jiNeng;
@property (strong ,nonatomic) NSString  *gongZuoDiZhi;
@property (assign ,nonatomic) NSArray   *tuPianList;

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
