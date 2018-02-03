//
//  BaseErrorView.h
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/19.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ErrorBlock)();

@interface BaseErrorView : UIView{
    ErrorBlock errorBlock_;
}

+ (instancetype)errorViewWithFrame:(CGRect)frame superView:(UIView*)superView withBlock:(ErrorBlock)block;
+ (instancetype)errorViewWithSuperView:(UIView*)superView withBlock:(ErrorBlock)block;
@end
