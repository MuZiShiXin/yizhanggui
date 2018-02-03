//
//  HeadJumpViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^HeadJumpBlock)(UIImage *);
typedef void (^headJumpBlock)(NSArray *);

@interface HeadJumpViewController : BaseViewController <UIActionSheetDelegate>
@property (nonatomic ,strong) HeadJumpBlock block;
@property (nonatomic ,strong) headJumpBlock blocks;
@property (nonatomic ,strong) NSString *tupianshu;
@property (nonatomic ,strong) UIImage *Images;
@end
