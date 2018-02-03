//
//  MasseaModel.m
//  UniversalApp
//
//  Created by  apple on 2018/1/19.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "MasseaModel.h"

@implementation MasseaModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict {
    MasseaModel *model = [[self alloc] initWithDict:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
