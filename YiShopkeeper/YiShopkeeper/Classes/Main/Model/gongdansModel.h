//
//  gongdansModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/29.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gongdansModel : NSObject
@property (nonatomic ,strong) NSString *biaoTi;
@property (nonatomic ,assign) NSInteger renShu;
@property (nonatomic ,strong) NSString *diZhi;
@property (nonatomic ,strong) NSString *faBuShiJian;
@property (nonatomic ,strong) NSString *kaiShiShiJian;
@property (nonatomic ,strong) NSString *jiNeng;
@property (nonatomic ,strong) NSString *gongDanTuPian;
@property (nonatomic ,assign) NSInteger gongDanId;
@property (nonatomic ,assign) double zongJi;
@property (nonatomic ,assign) NSInteger zhuangTai;
@property (nonatomic ,assign) NSInteger xiaoShi;
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
