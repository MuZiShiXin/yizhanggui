//
//  UIImageView+Alpha.h
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/22.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Alpha)
/**
 渐变导航栏
 
 @param scrollsetY scrollView 当前位置
 @param offY       允许滑动到多少为不透明
 */
- (void)scrollsetY:(CGFloat )scrollsetY offsetY:(CGFloat)offY;

@end