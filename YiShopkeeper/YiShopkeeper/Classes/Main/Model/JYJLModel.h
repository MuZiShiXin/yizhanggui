//
//  JYJLModel.h
//  UniversalApp
//
//  Created by  apple on 2017/12/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYJLModel : NSObject
@property (nonatomic ,assign) NSInteger dealRecordId;//交易记录id
@property (nonatomic ,strong) NSString *dealType;//交易类型
@property (nonatomic ,strong) NSString *dealState;//交易状态
@property (nonatomic ,strong) NSString *dealTm; //时间
@property (nonatomic ,assign) double   balance; //余额
@property (nonatomic ,assign) double   dealAmount;//交易金额
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
