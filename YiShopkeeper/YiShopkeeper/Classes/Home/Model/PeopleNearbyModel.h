//
//  PeopleNearbyModel.h
//  YiShopkeeper
//
//  Created by  apple on 2018/1/25.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleNearbyModel : NSObject
@property (nonatomic ,assign)NSInteger userInfoId;
@property (nonatomic ,strong)NSString *gender;
@property (nonatomic ,strong)NSString *skill;
@property (nonatomic ,strong)NSString *nick;
@property (nonatomic ,assign)NSInteger workYear;
@property (nonatomic ,strong)NSString *headPicAdd;
@property (nonatomic ,strong)NSString *distance;
@property (nonatomic ,assign)NSInteger age;
@property (nonatomic ,strong)NSString *workType;
@property (nonatomic ,assign)double xCoord;
@property (nonatomic ,assign)double yCoord;

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
