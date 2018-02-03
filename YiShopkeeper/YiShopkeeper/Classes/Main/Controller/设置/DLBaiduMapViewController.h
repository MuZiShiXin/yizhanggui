//
//  DLBaiduMapViewController.h
//  回顾
//
//  Created by 周冰烽 on 2018/1/3.
//  Copyright © 2018年 devil. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CommonAddressBlock)(NSString * str,CGFloat Y,CGFloat X);
@interface DLBaiduMapViewController :BaseViewController
@property (nonatomic, strong) CommonAddressBlock block;

@end
