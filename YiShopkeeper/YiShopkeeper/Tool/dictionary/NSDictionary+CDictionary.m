//
//  NSDictionary+CDictionary.m
//  字典对象辅助处理类别
//  项目：用于所有iOS开发的公共库
//
//
//  Created by 宋扬 on 12-12-24.
//  Copyright (c) 2012年 宋扬. All rights reserved.
//
//
//#import "NSString+CString.h"
#import "NSDictionary+CDictionary.h"
#import <objc/runtime.h>

@implementation NSDictionary (CDictionary)

+ (NSDictionary *)dictionaryWithObject:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 取得当前类类型
    Class cls = [obj class];
    unsigned int ivarsCnt = 0;
    
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        //　获取变量值
        id value = [obj valueForKey:key];
        
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        //const char *type = ivar_getTypeEncoding(ivar);
        
        if (value)
        {
            [dic setObject:value forKey:key];
        }
    }
    
    return dic;
}




- (id)valueForKeyWithNullDetection:(NSString *)key
{
    id result = [self valueForKey:key];
    if ([result isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    return result;
}

- (id)objectForKeyWithNullDetection:(NSString *)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    return result;
}

- (id)objectForKeyWithNullUnKnown:(NSString *)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNumber class]]) {
        return @"number";
    }
    if ([result isKindOfClass:[NSNull class]])
    {
        return @"未知";
    }
    
    if (result == nil) {
        return @"未知";
    }
    if ([result isEqualToString:@""]) {
        return @"未知";
    }
    return result;
}

- (id)objectForKeyWithSpaceDetection:(NSString *)key{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    
    if (result == nil) {
        return @"";
    }
    return result;
}

- (id)objectForKeyWithROUNDED:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return @"未知";
    }
    if (result == nil) {
        return @"未知";
    }
    CGFloat resultFloat = [result doubleValue];
    if (resultFloat > 100) { // 千人收视率
        NSInteger resultInt = resultFloat / 1;
        if ((resultFloat - resultInt) >= 0.5) {
            resultInt += 1;
        }
        return [NSString stringWithFormat:@"%ld",resultInt];
    } else { // 收视率
        return [NSString stringWithFormat:@"%.2f%%",resultFloat];
    }
    return result;
}

- (id)objectForKeyWithHUANBI:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return @"未知";
    }
    if (result == nil) {
        return @"未知";
    }
    CGFloat resultFloat = [result doubleValue];
    
    return [NSString stringWithFormat:@"%.2f%%",resultFloat * 100.f];
}

- (id)objectForKeyWithInteger:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return @"未知";
    }
    if (result == nil) {
        return @"未知";
    }
    CGFloat resultFloat = [result doubleValue];
    
    if (resultFloat > 0) { // 市场份额
        NSInteger resultInt = resultFloat / 1;
        if ((resultFloat - resultInt) >= 0.5) {
            resultInt += 1;
        }
        return [NSString stringWithFormat:@"%ld",resultInt];
    } else return 0;
}

- (id)objectForKeyWithHundredMillion:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return @"未知";
    }
    if (result == nil) {
        return @"未知";
    }
    CGFloat resultFloat = [result doubleValue] / 100000000.0f;
    return [NSString stringWithFormat:@"%.2f",resultFloat];
}

- (id)objectForKeyWithIntegerScore:(NSString *)key {
    
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return @"未知";
    }
    if (result == nil) {
        return @"未知";
    }
    NSInteger resultInt = [result floatValue] * 10000.f;
    CGFloat remainder = [result floatValue]  * 10000.f - resultInt;
    if (remainder >= 0.5) {
        resultInt++;
    }
    return [NSString stringWithFormat:@"%ld",resultInt];
}

- (id)objectForKeyWithDecimalScore:(NSString *)key {
    
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return @"未知";
    }
    if (result == nil) {
        return @"未知";
    }
    CGFloat resultFloat = [result doubleValue] / 10000.00f;
    return [NSString stringWithFormat:@"%.2f",resultFloat];
}


- (BOOL)isEqualToOtherDictionary:(NSDictionary*)otherDic{
    if (self.allKeys.count != otherDic.allKeys.count) {
        return NO;
    }else{
        NSArray* otherDicAllKeys = otherDic.allKeys;
        __block BOOL noHave = NO;
        [self.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* key = (NSString*)obj;
            __block BOOL have = NO;
            [otherDicAllKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                NSString* otherKey = (NSString*)obj1;
                if ([key isEqualToString:otherKey]) {
                    have = YES;
                    *stop1 = YES;
                }
            }];
            if (!have) {
                noHave = YES;
                *stop = YES;
            }
            
            
        }];
        
        if (noHave) {
            return NO;
        }else{
            __block BOOL have = NO;
            [self.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString* key = (NSString*)obj;
                NSString* value = [self objectForKeyWithNullDetection:key];
                NSString* otherValue = [otherDic objectForKeyWithNullDetection:key];
                if (![value isEqualToString:otherValue]) {
                    have = YES;
                    *stop = YES;
                }
            }];
            if (have) {
                return NO;
            }else{
                return YES;
            }
        }
    }
}
@end
