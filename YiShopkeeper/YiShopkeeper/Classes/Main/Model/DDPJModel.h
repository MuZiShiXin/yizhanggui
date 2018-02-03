//
//  DDPJModel.h
//  YiShopkeeper
//
//  Created by  apple on 2018/1/6.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPJModel : NSObject

@property (nonatomic ,assign) NSInteger daRenId;
@property (nonatomic ,strong) NSString *xingMing;
@property (nonatomic ,strong) NSString *touXiang;
@property (nonatomic ,assign) NSInteger nianLing;
@property (nonatomic ,assign) NSInteger gongLing;
@property (nonatomic ,strong) NSArray *gongZhongs;
@property (nonatomic ,strong) NSString *xingBie;
@property (nonatomic ,assign) NSInteger shouCang;
@property (nonatomic ,assign) double pingFen;
@property (nonatomic ,strong) NSString *pingJia;
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
