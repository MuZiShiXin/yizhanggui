//
//  LZTabBar.m
//  FilmBaiXiaoSheng
//
//  Created by  apple on 16/9/21.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "LZTabBar.h"
#import "OtherButton.h"
#import "PopupAnimation.h"
#import "HireViewController.h"
#import "BaseNavigationController.h"
#import "ToHireViewController.h"
#import "EnterpriseInformationViewController.h"
#import "PersonalInformationEditorViewController.h"
#import "UserInfoQueryModel.h"
#define TabBarTag 199202
#define LZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LZTabBar ()<PopupAnimationDelegate>

@end

@implementation LZTabBar

-(instancetype)init{
    self = [super init];
    if (self) {
        //获取通知用户授权
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    return self;
}


#pragma mark - 设置模型数据
- (void)setCenterButtonitem:(UITabBarItem *)CenterButtonitem{
    CenterButton *btn = [CenterButton buttonWithType:UIButtonTypeCustom];
    self.bigButton = btn;
    //设置tag值
    btn.tag = self.subviews.count + TabBarTag;
    //设置图片
    [btn setImage:CenterButtonitem.image forState:UIControlStateNormal];
    [btn setImage:CenterButtonitem.selectedImage forState:UIControlStateSelected];
    btn.adjustsImageWhenHighlighted = NO;
    //设置文字
    [btn setTitle:CenterButtonitem.title forState:UIControlStateNormal];
    [btn setTitleColor:LZColor(113, 109, 104) forState:UIControlStateNormal];
    [btn setTitleColor:LZColor(113, 109, 104) forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(centerClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
}

- (void)setItems:(NSArray *)items{
    _items = items;
    for (UITabBarItem * item in items) {
        
        OtherButton *btn = [OtherButton buttonWithType:UIButtonTypeCustom];
        //设置tag值
        btn.tag = self.subviews.count + TabBarTag;
        //设置图片
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = NO;
        //设置文字
        [btn setTitle:item.title forState:UIControlStateNormal];
        [btn setTitleColor:LZColor(113, 109, 104) forState:UIControlStateNormal];
        [btn setTitleColor:LZColor(113, 109, 104) forState:UIControlStateSelected];
        
        btn.item = item;
        // 添加观察者
        [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(btn)];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        [self.OtherButtons addObject:btn];
    }
    
}

#pragma mark - 隐藏tabbar 执行弹出动画
-(void)setHidden:(BOOL)hidden{
    if (hidden) {
        __weak typeof (self)weakself = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakself.layer.affineTransform = CGAffineTransformMakeTranslation(0, 100);
        }completion:^(BOOL finished) {
            [super setHidden:hidden];
        }];
    }
    else{
        [super setHidden:hidden];
        __weak typeof (self)weakself = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakself.layer.affineTransform = CGAffineTransformIdentity;
        }];
    }
}

#pragma makr- KVO监听  提醒数字显示
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    OtherButton *btn = (__bridge OtherButton *)(context);
    UITabBarItem *item = object;
    btn.item = item;
    
    //增加桌面提醒小红点
    int sum = 0;
    for (UITabBarItem * loop in _items) {
        sum += [loop.badgeValue intValue];
    }
//    [UIApplication sharedApplication].applicationIconBadgeNumber = sum;
}

#pragma mark - 外部设置索引，跳转页面
- (void)setSeletedIndex:(NSInteger)seletedIndex{
    _seletedIndex = seletedIndex;
    int n = [[self viewWithTag:TabBarTag + seletedIndex] isEqual:self.bigButton]?1:0;
    UIButton *button = [self viewWithTag:(TabBarTag + seletedIndex + n)];
    [self btnClick:button];
}




#pragma mark - 中间按钮点击
- (void)centerClick{
//    PopupAnimation * view = [PopupAnimation standardPublishAnimate];
//    view.delegate = self;
    if (Global.wanShanXinXi == 0) {
        
        
        if ([[NSString stringWithFormat:@"%@",Global.userType]  isEqualToString:@"1"]) {
            
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/user/query/userInfo",kPRTURL];
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", nil];
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
                if (result == 1) {
                    UserInfoQueryModel *UserInfoModel = [UserInfoQueryModel creatRankingTotalModelWith:resultDic];
                    EnterpriseInformationViewController *EnterpriseInformationVC = [[EnterpriseInformationViewController alloc]init];
                    EnterpriseInformationVC.model = UserInfoModel;
                    [_nav pushViewController:EnterpriseInformationVC animated:YES];
                }
            } failure:^(NSError * _Nullable error) {
                NSLog(@"loginError:%@",error);
                
            }];
            
            
        }else if ([[NSString stringWithFormat:@"%@",Global.userType]  isEqualToString:@"2"])
        {
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/user/query/userInfo",kPRTURL];
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId", nil];
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
                if (result == 1) {
                    UserInfoQueryModel *UserInfoModel = [UserInfoQueryModel creatRankingTotalModelWith:resultDic];
                    PersonalInformationEditorViewController *PersonalInformationEditorVC = [[PersonalInformationEditorViewController alloc]init];
                    PersonalInformationEditorVC.model = UserInfoModel;
                    [_nav pushViewController:PersonalInformationEditorVC animated:YES];
                }
            } failure:^(NSError * _Nullable error) {
                NSLog(@"loginError:%@",error);
                
            }];
            
            
        }
    }else
    {
        ToHireViewController *ToHireVC = [[ToHireViewController alloc]init];
        [_nav pushViewController:ToHireVC animated:YES];
        NSLog(@"点击发布");
    }
    
}

#pragma mark - 动画弹出view点击协议方法
-(void)didSelectBtnWithBtnTag:(NSInteger)tag{
    NSLog(@"在LZTabBar.m 文件中 , %ld点击",(long)tag);
}


#pragma mark - 控制器器按钮点击
- (void)btnClick:(UIButton *)button{
    if (button.tag < TabBarTag)
        return;
    
    _selButton.selected = NO;
    button.selected = YES;
    _selButton = button;
    
    // 通知tabBarVc切换控制器
    if ([_delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        int n = button.tag > _bigButton.tag ? -1 : 0;
        _seletedIndex = button.tag - TabBarTag + n;
        [_delegate tabBar:self didClickBtn:button.tag - TabBarTag + n];
    }
}

#pragma mark - 绘制按钮
- (void)layoutSubviews{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    CGFloat width = self.frame.size.width/count;
    CGFloat height = self.frame.size.height;
    if (width!=0 && height!=0) {
        
        int i = 0;
        for (UIButton * loop in self.subviews) {
            if (i == self.subviews.count/2) {
                i++;
            }
            if (![loop isEqual:_bigButton]) {
                loop.frame = CGRectMake(i++ * width, 0, width, self.frame.size.height);
            }
        }
        
        if (_bigButton != nil) {
            _bigButton.frame = CGRectMake(self.subviews.count/2*width, 0, width, self.frame.size.height);
        }
        
    }
}

#pragma mark - 处理中间凸出的按钮部分点击事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 这里宽度应该跟突出部分的宽度一样，减少点击反应区域
    CGFloat pointW = 43;
    CGFloat pointH = 61;
    CGFloat pointX = ([UIScreen mainScreen].bounds.size.width - pointW) / 2;
    CGFloat pointY = -12;
    CGRect rect = CGRectMake(pointX, pointY, pointW, pointH);
    if (CGRectContainsPoint(rect, point))
        return self.bigButton;
    return [super hitTest:point withEvent:event];
}

-(NSMutableArray*)OtherButtons{
    if(!_OtherButtons){
        _OtherButtons = [NSMutableArray array];
    }
    return _OtherButtons;
}

@end
