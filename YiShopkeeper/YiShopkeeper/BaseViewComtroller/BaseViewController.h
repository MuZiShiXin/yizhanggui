//
//  BaseViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewDelegate<NSObject>
//完成此委托指定导航条是否隐藏
-(BOOL)isHideNavigation;
//隐藏返回按钮
- (BOOL)isHideBackButton;
//隐藏右侧按钮
- (BOOL)isHideRightButton;
//隐藏标题
- (BOOL)isHideTitelLabel;

//设置右按钮图片
//-(UIImage*)setRightButtonImg;
////设置返回图片
//-(UIImage*)setBackButtonImg;
@end

@interface BaseViewController : UIViewController<BaseViewDelegate>
@property (nonatomic, weak) id<BaseViewDelegate>  _delegate;
@property (nonatomic, strong)   UIButton                   *backButton;
@property (nonatomic, strong)   UIButton                   *closeButton;
@property (nonatomic, strong)   UIButton                   *rightButton;
@property (nonatomic,strong)    UILabel                    *titelLabel;
@property (nonatomic,strong)    NSString                   *myTitleStr;
@property (nonatomic ,strong)   UIView                     *navigationView;
//左侧按钮的图片
@property (nonatomic ,strong)   UIImageView                *LeftBtnImv;

@property (nonatomic ,strong)   UIImageView                *
NVBJImageView;

/**
 *  返回事件
 *
 */
- (void)backAction:(id)sender;

@end
