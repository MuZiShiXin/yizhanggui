//
//  SCModel.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "SCModel.h"

@implementation SCModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    SCModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
