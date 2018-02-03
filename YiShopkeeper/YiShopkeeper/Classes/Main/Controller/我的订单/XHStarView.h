//
//  XHStarView.h
//  星星评价进阶2
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 mac.gu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^XHStar_ViewBlock)(NSInteger star);


@interface XHStarView : UIView
{
    XHStar_ViewBlock block_;
}

- (void)alterproperty:(XHStar_ViewBlock)block;

@property (nonatomic, assign) CGFloat score;


//给外界调用
@property (nonatomic, assign) CGFloat score2;

- (void)startStar:(CGFloat)sender;

@end
