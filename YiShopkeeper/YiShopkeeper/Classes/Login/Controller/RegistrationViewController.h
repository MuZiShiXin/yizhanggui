//
//  RegistrationViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/21.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^RegistrationBlock)(NSString *,NSString *);

@interface RegistrationViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic ,strong) RegistrationBlock block;

@end
