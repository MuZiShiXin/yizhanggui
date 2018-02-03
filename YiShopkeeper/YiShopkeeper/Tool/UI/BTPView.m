//
//  BTPView.m
//  YeQ
//
//  Created by  xiaotu on 16/10/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BTPView.h"

@implementation BTPView{
    ClickActionBlock block_;
}


- (instancetype)initWithFrame:(CGRect)frame clickAction:(ClickActionBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        block_ = block;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)clickAction:(UITapGestureRecognizer*)tap{
    BTPView* view = (BTPView*)tap.view;
    block_(view);
}

@end
