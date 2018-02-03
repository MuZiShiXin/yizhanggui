//
//  BadgeView.m
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //设置红点图片
        UIImage *image = [UIImage imageNamed:@"main_badge"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        //设置文字
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    if (![_badgeValue isEqualToString:badgeValue]) {
        _badgeValue = [badgeValue copy];
        [self layoutSubviews];
    }
}

#pragma mark - 绘制小红点
- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置文字
    if ([_badgeValue integerValue] <= 0) {
        _badgeValue = nil;
        self.hidden = YES;
        return;
    }
    
    int n = 7;
    self.hidden = NO;
    if ([_badgeValue integerValue]>999) {
        [self setTitle:@"···" forState:UIControlStateNormal];
    }
    else{
        n = [_badgeValue integerValue] > 9 ? 7 : 0; //提醒数字大于9增宽
        [self setTitle:_badgeValue forState:UIControlStateNormal];
    }
    
    //设置frame
    self.frame = CGRectMake(self.superview.frame.size.width/2+5, 1,
                            self.currentBackgroundImage.size.width+n,
                            self.currentBackgroundImage.size.height);
}


@end
