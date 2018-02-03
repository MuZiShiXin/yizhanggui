//
//  BTPView.h
//  YeQ
//
//  Created by  xiaotu on 16/10/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTPView;

typedef void(^ClickActionBlock)(BTPView* view);

@interface BTPView : UIView

@property (nonatomic) BOOL isSelected;

- (instancetype)initWithFrame:(CGRect)frame clickAction:(ClickActionBlock)block;

@end
