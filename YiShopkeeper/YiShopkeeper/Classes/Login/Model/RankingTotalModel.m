//
//  RankingTotalModel.m
//  sgs
//
//  Created by 杨奉泊 on 25/08/2017.
//  Copyright © 2017 中玩. All rights reserved.
//

#import "RankingTotalModel.h"

@implementation RankingTotalModel

static RankingTotalModel *s_defaultInstance;


+ (RankingTotalModel *)defaults
{
    @synchronized(self)
    {
        if (s_defaultInstance == nil)
        {
            s_defaultInstance = [[RankingTotalModel alloc] init];
            
        }
        return s_defaultInstance;
    }
}



+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    RankingTotalModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        Global.userInfoId = [[dict objectForKeyWithInteger:@"userInfoId"] integerValue];
        Global.headPicAdd = [dict objectForKeyWithNullUnKnown:@"headPicAdd"];
        Global.nick = [dict objectForKeyWithNullUnKnown:@"nick"];
        Global.socialCredit = [dict objectForKeyWithNullUnKnown:@"socialCredit"];
        Global.picAdd = [dict objectForKeyWithNullUnKnown:@"picAdd"];
        Global.firmIntro = [dict objectForKeyWithNullUnKnown:@"firmIntro"];
        Global.gender = [dict objectForKeyWithNullUnKnown:@"gender"];
        Global.idNum = [dict objectForKeyWithNullUnKnown:@"idNum"];
        Global.idPicAdd = [dict objectForKeyWithNullUnKnown:@"idPicAdd"];
        Global.workType = [dict objectForKeyWithNullUnKnown:@"workType"];
        Global.skill = [dict objectForKeyWithNullUnKnown:@"skill"];
        Global.skillPicAdd = [dict objectForKeyWithNullUnKnown:@"skillPicAdd"];
        Global.userName = [dict objectForKeyWithNullUnKnown:@"userName"];
        Global.userPassword = [dict objectForKeyWithNullUnKnown:@"userPassword"];
        Global.accountBalance = [[dict objectForKeyWithInteger:@"accountBalance"] doubleValue];
        Global.sussOrderNumber = [[dict objectForKeyWithInteger:@"sussOrderNumber"] integerValue];
        Global.evaluateCore = [dict objectForKeyWithNullUnKnown:@"evaluateCore"];
        Global.userType = [dict objectForKeyWithNullDetection:@"userType"];
        Global.checkState = [dict objectForKeyWithNullUnKnown:@"checkState"];
        Global.clientType = [dict objectForKeyWithNullUnKnown:@"clientType"];
        Global.clientVersion = [dict objectForKeyWithNullUnKnown:@"clientVersion"];
        Global.workYear = [[dict objectForKeyWithInteger:@"workYear"] integerValue];
        Global.wanShanXinXi = [[dict objectForKeyWithInteger:@"wanShanXinXi"] integerValue];
        Global.zhuXiao = [[dict objectForKeyWithInteger:@"zhuXiao"] integerValue];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if (dic == nil) {
        return @" ";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(NSString*)arrayToJson:(NSArray*)array

{
    
    NSError* parseError =nil;
    
    //options=0转换成不带格式的字符串
    
    //options=NSJSONWritingPrettyPrinted格式化输出
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&parseError];
    return[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


@end
