//
//  UIView+UIViewController.m
//  WXWeibo
//
//  Created by apple on 14-4-3.
//  Copyright  All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)
//事件响应者链
- (UIViewController *)viewVC
{
    UIResponder *next = self.nextResponder;
    do {
        //判断事件响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    return nil;
}
@end
