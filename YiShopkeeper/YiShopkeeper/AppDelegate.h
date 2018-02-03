//
//  AppDelegate.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/20.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WXApi.h"
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>

static NSString *appKey = @"d975ddcbfabd56d8971b2335";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMConnectionStatusDelegate>
@property (strong, nonatomic) BaseTabBarController            *tabBarController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController              *baseViewController;
@property (strong, nonatomic) UINavigationController        *baseNavigationController;
- (void)setUpTabControllerToMainPage;
- (void)setUpLoginToMainPage;

@end

