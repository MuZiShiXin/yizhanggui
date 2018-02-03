//
//  BTPButton.m
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/11.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BTPButton.h"

@implementation BTPButton

+ (BTPButton*)btpButton:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)fontColor fontSize:(NSInteger)size superView:(UIView*)superView{
    BTPButton* button = [[self alloc]initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    if (fontColor != nil) {
        [button setTitleColor:fontColor forState:UIControlStateNormal];
    }
    button.showsTouchWhenHighlighted = YES;
    if (size != 0) {
         button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
    [superView addSubview:button];
    return button;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)fontColor fontSize:(NSInteger)size superView:(UIView*)superView tag:(NSInteger)tag action:(ActionBlock)action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.block = [action copy];
        [self setTitle:title forState:UIControlStateNormal];
        if (fontColor != nil) {
            [self setTitleColor:fontColor forState:UIControlStateNormal];
        }
        self.tag = tag;
        if (size != 0) {
            self.titleLabel.font = [UIFont systemFontOfSize:size];
        }
        [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        self.showsTouchWhenHighlighted = YES;
        [superView addSubview:self];

    }
    return self;
}

- (void)clickButton:(BTPButton*)button{
    button.block(button);
}
@end
