//
//  DDPJModel.m
//  YiShopkeeper
//
//  Created by  apple on 2018/1/6.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import "DDPJModel.h"

@implementation DDPJModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    DDPJModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
