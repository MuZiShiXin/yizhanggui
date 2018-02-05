//
//  FaBuZhiFuViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import "XZUnifiedorderModel.h"

@interface FaBuZhiFuViewController : BaseViewController
@property (strong, nonatomic) NSDictionary *parameters;
@property (strong, nonatomic) IBOutlet UILabel *gongzuobiaotiLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshichangLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzhongLabel;
@property (strong, nonatomic) IBOutlet UILabel *xuyaorenshuLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidianLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongjihuafeiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *xuanzeweixinImageView;
@property (strong, nonatomic) IBOutlet UIButton *weixinButton;
@property (strong, nonatomic) IBOutlet UIImageView *zhifubaoImageView;
@property (strong, nonatomic) IBOutlet UIButton *zhifubaoButton;

@property (strong, nonatomic) IBOutlet UIButton *querenzhifuButton;

@property (nonatomic,strong) XZUnifiedorderModel *UnifiedorderModel;
@property (nonatomic,assign) NSInteger recruitInfoId;


















@end
