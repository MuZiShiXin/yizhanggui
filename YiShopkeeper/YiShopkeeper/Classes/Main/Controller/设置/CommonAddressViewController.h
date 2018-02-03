//
//  CommonAddressViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^CommonAddressBlock)(NSString * str,CGFloat Y,CGFloat X);

@interface CommonAddressViewController : BaseViewController
@property (nonatomic, strong) CommonAddressBlock block;

@property (nonatomic ,strong) NSString *SelectAddress;
@end
