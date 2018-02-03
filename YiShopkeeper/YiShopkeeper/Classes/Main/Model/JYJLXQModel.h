//
//  JYJLXQModel.h
//  UniversalApp
//
//  Created by  apple on 2017/12/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYJLXQModel : NSObject

@property (nonatomic ,assign) NSInteger dealRecordId;//交易记录id
@property (nonatomic ,assign) NSInteger myOrderId;//我的订单id
@property (nonatomic ,strong) NSString *dealState;//交易状态
@property (nonatomic ,strong) NSString *serialNum; //流水号
@property (nonatomic ,strong) NSString *dealType;//交易类型
@property (nonatomic ,assign) double   dealAmount;//交易金额
@property (nonatomic ,strong) NSString *dealTm; //时间
@property (nonatomic ,strong) NSString *recruitDetail;//工单说明
@property (nonatomic ,strong) NSString *modePay;//支付方式
@property (nonatomic ,assign) double   balance; //余额
@property (nonatomic ,strong) NSString *workOrderTab;//工单号
@property (nonatomic ,strong) NSString *orderNum;//订单号
@property (nonatomic ,strong) NSString *dealTypeNum;//交易类型标识符
@property (nonatomic ,strong) NSString *nick;
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;
@end
