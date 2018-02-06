//
//  UserInfoQueryModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoQueryModel : NSObject
@property (nonatomic ,assign) NSInteger userInfoId;// 用户Id
@property (nonatomic ,strong) NSString  *headPicAdd;//头像
@property (nonatomic ,strong) NSString  *nick;//昵称
@property (nonatomic ,strong) NSString  *socialCredit;//社会信用社代码
@property (nonatomic ,strong) NSString  *picAdd;//照片
@property (nonatomic ,strong) NSString  *firmIntro;//企业简介
@property (nonatomic ,strong) NSString  *gender;//性别（男女）
@property (nonatomic ,strong) NSString  *idNum;//身份证号
@property (nonatomic ,strong) NSString  *idPicAdd;//身份证照片
@property (nonatomic ,strong) NSString  *workType;//工种Id
@property (nonatomic ,strong) NSString  *skill;//技能
@property (nonatomic ,strong) NSString  *skillPicAdd;//技能照片
@property (nonatomic ,strong) NSString  *userName;//账户名（手机号）
@property (nonatomic ,strong) NSString  *userPassword;//密码
@property (nonatomic ,strong) NSString  *userType;//用户类型（1,掌柜企业,2,掌柜个人,3,达人）
@property (nonatomic ,assign) NSInteger checkState;//审核状态（0否1是）
@property (nonatomic ,assign) NSInteger wanShanXinXi;//完善信息（0否1是）
@property (nonatomic ,assign) NSInteger zhuXiao;//是否已注销（0否1是）
@property (nonatomic ,strong) NSString  *idPicInfo;
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
