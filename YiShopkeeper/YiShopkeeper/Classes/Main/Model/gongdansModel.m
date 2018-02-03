//
//  gongdansModel.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/29.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "gongdansModel.h"

@implementation gongdansModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    gongdansModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
