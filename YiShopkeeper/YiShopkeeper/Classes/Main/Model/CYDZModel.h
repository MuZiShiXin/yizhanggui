//
//  CYDZModel.h
//  YiShopkeeper
//
//  Created by  apple on 2018/1/8.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYDZModel : NSObject
@property (nonatomic ,assign) NSInteger diZhiId;
@property (nonatomic ,strong) NSString *dingWeiDiZhi;
@property (nonatomic ,strong) NSString *xiangXiDiZhi;
@property (nonatomic ,assign) CGFloat Y;
@property (nonatomic ,assign) CGFloat X;

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
