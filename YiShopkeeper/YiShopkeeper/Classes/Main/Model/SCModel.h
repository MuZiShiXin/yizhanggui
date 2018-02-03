//
//  SCModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCModel : NSObject

@property (nonatomic ,assign) NSInteger zhangGuiId;
@property (nonatomic ,assign) NSInteger daRenId;
@property (nonatomic ,strong) NSString  *xingMing;
@property (nonatomic ,strong) NSString  *touXiang;
@property (assign ,nonatomic) NSInteger nianLing;
@property (assign ,nonatomic) NSInteger gongLing;
@property (strong ,nonatomic) NSArray  *gongZhongs;
@property (strong ,nonatomic) NSString  *neiRong;
@property (strong ,nonatomic) NSString  *xingBie;
@property (assign ,nonatomic) NSInteger shouCang;
@property (assign ,nonatomic) NSInteger chengDanShu;
@property (assign ,nonatomic) double    zhunShi;
@property (assign ,nonatomic) double    zhiLiang;
@property (assign ,nonatomic) double    xiaoLv;
@property (assign ,nonatomic) double    jiNeng;
@property (assign ,nonatomic) NSArray   *tuPianList;

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
