//
//  CYDZModel.m
//  YiShopkeeper
//
//  Created by  apple on 2018/1/8.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import "CYDZModel.h"

@implementation CYDZModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    CYDZModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
