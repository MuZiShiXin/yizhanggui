//
//  DaRenModel.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/16.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "DaRenModel.h"

@implementation DaRenModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict]; 
    }
    return self;
}

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    DaRenModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
