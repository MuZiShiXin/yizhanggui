//
//  BTPButton.h
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/11.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTPButton;

typedef void(^ActionBlock)(BTPButton* button);

@interface BTPButton : UIButton{
}

@property (nonatomic) NSInteger type;
@property (nonatomic,copy) ActionBlock block;

+ (BTPButton*)btpButton:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)fontColor fontSize:(NSInteger)size superView:(UIView*)superView;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)fontColor fontSize:(NSInteger)size superView:(UIView*)superView tag:(NSInteger)tag action:(ActionBlock)action;


@end
