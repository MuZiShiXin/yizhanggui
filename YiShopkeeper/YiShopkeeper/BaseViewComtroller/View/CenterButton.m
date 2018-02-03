//
//  CenterButton.m
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "CenterButton.h"

@interface CenterButton()

@property (strong , nonatomic)UIImageView *bgView;

@end

@implementation CenterButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"baView"];
        [self insertSubview:_bgView atIndex:0];
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
        self.imageView.frame = CGRectMake(0, - 34, width, 78);
        //背景位置
        self.bgView.frame = CGRectMake(0, 0, self.currentImage.size.width+15, self.currentImage.size.height+15);
        self.bgView.center = self.imageView.center;
        
    }
}


-(void)setHighlighted:(BOOL)highlighted{
    
}


@end
