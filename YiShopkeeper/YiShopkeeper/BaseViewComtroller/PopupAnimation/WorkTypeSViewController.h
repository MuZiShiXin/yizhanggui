//
//  WorkTypeSViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2018/1/17.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^WorkTypeBlock)(NSString *);

@interface WorkTypeSViewController : BaseViewController
@property (nonatomic ,strong) NSArray *WorkTypeDate;
@property (nonatomic ,strong) WorkTypeBlock block;

@end
