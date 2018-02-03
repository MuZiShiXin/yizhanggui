//
//  NSArray+ToString.m
//  YeQ
//
//  Created by  xiaotu on 2016/11/26.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "NSArray+ToString.h"

@implementation NSArray (ToString)

- (NSString*)toSting:(NSString*)separator{
    
    if (self == nil || self.count == 0) {
        return nil;
    }else{
        id fStr = [self firstObject];
        if ([fStr isKindOfClass:[NSString class]]) {
           __block NSString* str = (NSString*)fStr;
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx > 0) {
                    NSString* objStr = (NSString*)obj;
                    str = [str stringByAppendingFormat:@"%@%@",separator,objStr];
                }
            }];
            return str;
        }else if ([fStr isKindOfClass:[NSNumber class]]){
            __block NSString* str = [NSString stringWithFormat:@"%@",fStr];
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx > 0) {
                    NSString* objStr = [NSString stringWithFormat:@"%@",obj];
                    str = [str stringByAppendingFormat:@"%@%@",separator,objStr];
                }
            }];
            return str;
        }else{
            return nil;
        }
    }
}

@end
