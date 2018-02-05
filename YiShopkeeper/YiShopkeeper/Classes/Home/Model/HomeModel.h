//
//  HomeModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/15.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property (assign ,nonatomic) NSInteger zhangGuiId;
@property (assign ,nonatomic) NSInteger daRenId;
@property (assign ,nonatomic) NSInteger gongDanId;
@property (assign ,nonatomic) NSInteger dingDanId;
@property (strong ,nonatomic) NSString  *xingMing;
@property (strong ,nonatomic) NSString  *touXiang;
@property (assign ,nonatomic) NSInteger nianLing;
@property (assign ,nonatomic) NSInteger gongLing;
@property (strong ,nonatomic) NSArray  *gongZhongs;
@property (strong ,nonatomic) NSString  *neiRong;
@property (strong ,nonatomic) NSString  *xingBie;
@property (assign ,nonatomic) NSInteger dingDanZhuangTai;
@property (assign ,nonatomic) NSInteger shouCang;
@property (assign ,nonatomic) NSInteger chengDanShu;
@property (assign ,nonatomic) NSInteger zhaoGongRenShu;
@property (assign ,nonatomic) NSInteger shengYuRenShu;
@property (assign ,nonatomic) NSInteger yiBaoMingRenShu;
@property (assign ,nonatomic) CGFloat zhunShi;
@property (assign ,nonatomic) CGFloat zhiLiang;
@property (assign ,nonatomic) CGFloat xiaoLv;
@property (assign ,nonatomic) CGFloat jiNeng;
@property (assign ,nonatomic) NSInteger useramt;//总开工达人
@property (assign ,nonatomic) NSInteger gdamt;//总发布次数
@property (assign ,nonatomic) NSInteger orderamt;//已接活人数




+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;
@end
