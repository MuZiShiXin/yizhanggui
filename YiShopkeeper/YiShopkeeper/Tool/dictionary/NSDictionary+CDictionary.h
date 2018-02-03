//
//  NSDictionary+CDictionary.h
//  字典对象辅助处理类别
//  项目：用于所有iOS开发的公共库
//
//
//  Created by 宋扬 on 12-12-24.
//  Copyright (c) 2012年 宋扬. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CDictionary)

+ (NSDictionary *)dictionaryWithObject:(id)obj;

- (id)valueForKeyWithNullDetection:(NSString *)key;
// 如果是空返回nil
- (id)objectForKeyWithNullDetection:(NSString *)key;
// 如果是空返回@“”
- (id)objectForKeyWithSpaceDetection:(NSString *)key;
// 如果是空返回@“未知”
- (id)objectForKeyWithNullUnKnown:(NSString *)key;

- (id)objectForKeyWithROUNDED:(NSString *)key;
// 环比
- (id)objectForKeyWithHUANBI:(NSString *)key;
// 四舍五入返回整数
- (id)objectForKeyWithInteger:(NSString *)key;
// 四舍五入返回亿
- (id)objectForKeyWithHundredMillion:(NSString *)key;

- (id)objectForKeyWithIntegerScore:(NSString *)key;

- (id)objectForKeyWithDecimalScore:(NSString *)key;

//比较两个字典是否相等 注意 只能判断所有value都是字符串的类型的字典
- (BOOL)isEqualToOtherDictionary:(NSDictionary*)otherDic;
@end
