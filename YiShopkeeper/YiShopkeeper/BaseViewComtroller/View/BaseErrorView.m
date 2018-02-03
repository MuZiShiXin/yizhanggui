//
//  BaseErrorView.m
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/19.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BaseErrorView.h"
#import "AppDelegate.h"

@implementation BaseErrorView

- (void)roloadData:(ErrorBlock)block{
    errorBlock_ = block;
}

+ (instancetype)errorViewWithFrame:(CGRect)frame superView:(UIView*)superView withBlock:(ErrorBlock)block{
    return [[BaseErrorView alloc]initWithFrame:frame superView:superView withBlock:block];

}

+ (instancetype)errorViewWithSuperView:(UIView*)superView withBlock:(ErrorBlock)block{
    return [[BaseErrorView alloc]initWithFrame:CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height) superView:superView withBlock:block];
}

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView*)superView withBlock:(ErrorBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat rate = frame.size.height/(kScreenHeight-64);
        errorBlock_ = block;
        self.backgroundColor = [UIColor hx_colorWith8BitRed:237 green:237 blue:237];
        CGRect rect = CGRectMake((kScreenWidth-100*rate)/2.0, frame.size.height*0.2*rate, 100*rate, 100*rate);
        UIImageView* headerImageView = [[UIImageView alloc]initWithFrame:rect];
        headerImageView.image = [UIImage imageNamed:@"wifi"];
        [self addSubview:headerImageView];
        
        BTPLabel* titleLabel = [[BTPLabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(headerImageView.frame)+25, kScreenWidth-20, 20) title:@"数据加载失败" fontSize:17 alignment:1 textColor:RGB(10, 10, 10)];
        [self addSubview:titleLabel];
        
        BTPLabel* contentLabel = [[BTPLabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+5, kScreenWidth-20, 20) title:@"请检查您的手机是否联网，点击按钮重新加载" fontSize:14 alignment:1 textColor:RGB(165, 165, 165)];
        [self addSubview:contentLabel];
        
        BTPButton* button = [BTPButton btpButton:CGRectMake((kScreenWidth-140)/2.0, CGRectGetMaxY(contentLabel.frame)+15, 140, 40) title:@"重新加载" titleColor:RGB(117, 117, 117) fontSize:17 superView:self];
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = 5;
        button.layer.borderColor = RGB(117, 117, 117).CGColor;
        button.layer.borderWidth = 1;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (frame.size.height < 225) {
//            self.backgroundColor = [UIColor clearColor];
            titleLabel.frame = CGRectMake(0, CGRectGetMaxY(headerImageView.frame)+10, frame.size.width, 15);
            titleLabel.font = [UIFont systemFontOfSize:14];
            contentLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+2, frame.size.width, 15);
            contentLabel.font = [UIFont systemFontOfSize:12];
            button.frame = CGRectMake((kScreenWidth-140)/2.0, CGRectGetMaxY(contentLabel.frame)+10, 140, 20);
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        [superView addSubview:self];
    }
    return self;
}

- (void)reloadData:(BTPButton*)button{
    
    if (DeviceVersion >= 9.0) {
        [self removeFromSuperview];
    }else{
         [self removeFromSuperview];
    }
    errorBlock_();
}
@end
