//
//  PopupAnimation.m
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "PopupAnimation.h"

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#define CenterPoint CGPointMake(W/2 ,H-38.347785)
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface PopupAnimation()
//中间按钮
@property (strong , nonatomic) UIButton* CenterBtn;
//功能按钮
@property (strong , nonatomic) NSMutableArray* BtnItem;
@property (strong , nonatomic) NSMutableArray* BtnItemTitle;

@end

@implementation PopupAnimation

#pragma mark - 显示
+(PopupAnimation *)standardPublishAnimate{
    PopupAnimation * view = [[PopupAnimation alloc]init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:view];
    
    //添加按钮
    [view CrentBtnImageName:@"AnimateBtn_01" Title:@"拍照" tag:2];
    [view CrentBtnImageName:@"AnimateBtn_02" Title:@"相册" tag:3];
    [view CrentBtnImageName:@"AnimateBtn_03" Title:@"一键转卖" tag:4];
    //中间加号
    [view CrentCenterBtnImageName:@"AnimatePlus" tag:1];
    //开始动画
    [view AnimateBegin];
    return view;
}

#pragma mark - 初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        //毛玻璃
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        [self addSubview:visualEffectView];
        
    }
    return self;
}

#pragma mark - 生成元素按钮
-(void)CrentBtnImageName:(NSString *)ImageName Title:(NSString *)Title tag:(int)tag{
    if (_BtnItem.count >= 3)  return;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0 , 0, 51 ,51)];
    btn.center = CenterPoint;
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.BtnItem addObject:btn];
    [self.BtnItemTitle addObject:[self CrenterBtnTitle:Title]];
}

#pragma mark - 生成加号按钮
-(void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    _CenterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 , 0, 51 ,51)];
    _CenterBtn.center = CenterPoint;
    [_CenterBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [_CenterBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _CenterBtn.tag = tag;
    
    [self addSubview:_CenterBtn];
}

#pragma mark - 懒加载
-(NSMutableArray *)BtnItem{
    if (!_BtnItem) {
        _BtnItem = [NSMutableArray array];
    }
    return _BtnItem;
}
-(NSMutableArray *)BtnItemTitle{
    if (!_BtnItemTitle) {
        _BtnItemTitle = [NSMutableArray array];
    }
    return _BtnItemTitle;
}
-(UILabel *)CrenterBtnTitle:(NSString *)Title{
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = Color(240, 240, 240,1);
    lab.font = [UIFont italicSystemFontOfSize:13.5*bl];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = Title;
    [self addSubview:lab];
    return lab;
}

#pragma mark - 移除视图并通知代理
-(void)removeView:(UIButton*)btn{
    [self removeFromSuperview];
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
}

#pragma mark - 空白处取消
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAnimation];
}

#pragma mark - 点击按钮动画
-(void)BtnClick:(UIButton*)btn{
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
    [self removeFromSuperview];
}
#pragma mark - 开始动画
-(void)AnimateBegin{
    //加号旋转
    [UIView animateWithDuration:0.2 animations:^{
        _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
    
    
    __block int  i = 0 , k = 0;
    __weak typeof(self)weakself = self;
    for (UIView *  btn in _BtnItem) {
        //移动
        [UIView animateWithDuration:0.5 delay:i*0.1 usingSpringWithDamping:0.46 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 1.6734*bl, 1.6734*bl);//缩放
            btn.center = CGPointMake((74+i++*113)*bl, weakself.frame.size.height-165*bl);
            
        } completion:nil];
        
        //旋转
        [UIView animateWithDuration:0.2 delay:i*0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            btn.transform = CGAffineTransformRotate (btn.transform, -M_2_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                btn.transform = CGAffineTransformRotate (btn.transform, M_2_PI+M_LOG10E);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    btn.transform = CGAffineTransformRotate (btn.transform, -M_LOG10E);
                } completion:^(BOOL finished) {
                    UILabel * lab = (UILabel *)_BtnItemTitle[k++];
                    lab.frame = CGRectMake(0, 0, W/3-30, 30);
                    lab.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)+20);
                }];
            }];
        }];
    }
    
    
}


#pragma mark - 取消动画
-(void)cancelAnimation{
    __weak typeof(self)weakself = self;
    //旋转
    [UIView animateWithDuration:0.15 animations:^{
        _CenterBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        //移动
        int n = (int)_BtnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = _BtnItem[i];
            [UIButton animateWithDuration:0.25 delay:0.1*(n-i) options:UIViewAnimationOptionTransitionCurlDown animations:^{
                btn.center = CGPointMake(W/2 ,H-43.052385);
                btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
                btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
                
                UILabel * lab = (UILabel *)_BtnItemTitle[i];
                [lab removeFromSuperview];
            } completion:^(BOOL finished) {
                [btn removeFromSuperview];
                if (i==0) {
                    [weakself removeFromSuperview];
                }
            }];
        }
    }];
    
}

@end
