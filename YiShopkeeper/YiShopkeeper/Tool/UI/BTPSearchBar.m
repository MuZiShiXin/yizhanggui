//
//  BTPSearchBar.m
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/10/11.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//  去掉两条线

#import "BTPSearchBar.h"

@implementation BTPSearchBar

- (instancetype)initWithFrame:(CGRect)frame barStyle:(UIBarStyle)barStyle placeholder:(NSString*)placeholder superView:(UIView*)superView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barStyle = barStyle;
        self.placeholder = placeholder;
        self.translucent = YES;
        self.barTintColor = [UIColor whiteColor];
        self.returnKeyType = UIReturnKeySearch;
        self.showsCancelButton = YES;
        //去掉两条线
        for (UIView *obj in [self subviews]) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton*)obj;
                // 修改文字颜色
                [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            for (UIView *objs in [obj subviews]) {
                if ([objs isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
                    [objs removeFromSuperview];
                }
            }
        }
//        self.showsCancelButton = YES;
        [superView addSubview:self];
    }
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,nil] forState:UIControlStateNormal];
    return self;
}




@end
