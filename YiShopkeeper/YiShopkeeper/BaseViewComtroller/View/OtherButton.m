//
//  OtherButton.m
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "OtherButton.h"
#import "BadgeView.h"
@interface OtherButton()
//提醒数字
@property (strong , nonatomic)BadgeView * badgeView;

@end


@implementation OtherButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

#pragma mark - 绘制按钮子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.superview.frame.size.height;
    if (width!=0 && height!=0) {
        // 文字位置
        self.titleLabel.frame = CGRectMake(0, height-16, width, 16);
        // 图片位置
        self.imageView.frame = CGRectMake(0 , 0, width, 35);
    }
}

#pragma mark - 设置小红点属性
- (void)setItem:(UITabBarItem *)item {
    _item = item;
    self.badgeView.badgeValue = item.badgeValue;
}


#pragma mark - 懒加载小红点
- (BadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[BadgeView alloc] init];
        [self addSubview:_badgeView];
    }
    return _badgeView;
}

- (void)setHighlighted:(BOOL)highlighted{

}

@end
