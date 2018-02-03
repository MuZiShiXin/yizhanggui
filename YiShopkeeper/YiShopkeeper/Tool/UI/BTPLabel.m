//
//  BTPLabel.m
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/7/30.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BTPLabel.h"

@implementation BTPLabel

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title fontSize:(CGFloat)size alignment:(NSInteger)alignment textColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        if (alignment == 0) {
            self.textAlignment = NSTextAlignmentLeft;
        }else if (alignment == 1){
            self.textAlignment = NSTextAlignmentCenter;
        }else if (alignment == 2){
            self.textAlignment =  NSTextAlignmentRight;
        }
        self.textColor = color;
        self.text = title;
        self.font = [UIFont systemFontOfSize:size];
        self.isSelected = NO;
    }
    return self;
}

@end
