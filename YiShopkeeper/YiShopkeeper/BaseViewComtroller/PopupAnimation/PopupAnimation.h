//
//  PopupAnimation.h
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>

//通知点击按钮协议
@protocol PopupAnimationDelegate <NSObject>
- (void)didSelectBtnWithBtnTag:(NSInteger)tag;
@end

@interface PopupAnimation : UIView
//通知点击按钮代理人
@property(weak,nonatomic) id<PopupAnimationDelegate> delegate;
//弹出动画view
+(PopupAnimation *)standardPublishAnimate;

@end
