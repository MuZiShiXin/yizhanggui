//  企业
//  NicknameChangeViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/27.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^NicknameChangeBlock)(NSString *);
@interface NicknameChangeViewController : BaseViewController
@property (strong, nonatomic) NSString *BiaoTiTitleLabelText;
@property (nonatomic ,strong) NicknameChangeBlock block;

@end
