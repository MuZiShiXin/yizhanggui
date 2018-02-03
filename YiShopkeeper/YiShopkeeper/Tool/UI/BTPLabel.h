//
//  BTPLabel.h
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/7/30.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTPLabel : UILabel

@property (nonatomic) BOOL isSelected;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title fontSize:(CGFloat)size alignment:(NSInteger)alignment textColor:(UIColor*)color;


@end
