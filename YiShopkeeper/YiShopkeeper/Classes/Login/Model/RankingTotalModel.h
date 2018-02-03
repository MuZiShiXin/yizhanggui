//
//  RankingTotalModel.h
//  sgs
//
//  Created by 杨奉泊 on 25/08/2017.
//  Copyright © 2017 中玩. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Global [RankingTotalModel defaults]

@interface RankingTotalModel : NSObject

@property (assign, nonatomic) NSInteger userInfoId;
@property (strong, nonatomic) NSString *headPicAdd;
@property (strong, nonatomic) NSString *nick;
@property (strong, nonatomic) NSString *socialCredit;
@property (strong, nonatomic) NSString *picAdd;
@property (strong, nonatomic) NSString *firmIntro;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *idNum;
@property (strong, nonatomic) NSString *idPicAdd;
@property (strong, nonatomic) NSString *workType;
@property (strong, nonatomic) NSString *skill;
@property (strong, nonatomic) NSString *skillPicAdd;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userPassword;
@property (assign, nonatomic) double   accountBalance;
@property (assign, nonatomic) NSInteger sussOrderNumber;
@property (strong, nonatomic) NSString *evaluateCore;
@property (strong, nonatomic) NSString *userType;
@property (strong, nonatomic) NSString *checkState;
@property (strong, nonatomic) NSString *clientType;
@property (strong, nonatomic) NSString *clientVersion;
@property (assign, nonatomic) NSInteger workYear;
@property (assign, nonatomic) NSInteger wanShanXinXi;
@property (assign, nonatomic) NSInteger zhuXiao;

+ (RankingTotalModel*)defaults;

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

- (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (NSString*)arrayToJson:(NSArray*)array;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end
