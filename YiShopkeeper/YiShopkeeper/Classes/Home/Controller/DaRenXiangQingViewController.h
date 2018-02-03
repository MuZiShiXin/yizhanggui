//
//  DaRenXiangQingViewController.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeModel.h"

typedef void (^DaRenXiangQingBlock)(NSIndexPath *);
typedef void (^qurenQingBlock)(NSString *);


@interface DaRenXiangQingViewController : BaseViewController
@property (strong, nonatomic) HomeModel *homeModel;
@property (nonatomic ,strong) DaRenXiangQingBlock block;
@property (nonatomic ,strong) qurenQingBlock blocks;
@property (nonatomic ,strong) NSIndexPath *indexPath;
@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;

@property (strong, nonatomic) IBOutlet UILabel *shoucangLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shoucangImageView;
@property (strong, nonatomic) IBOutlet UIButton *shoucangButton;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UILabel *nianlingLabel;

@property (strong, nonatomic) IBOutlet UIImageView *xingbieImageVIew;
@property (strong, nonatomic) IBOutlet UILabel *gonglingLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel1;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel2;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel3;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel4;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel5;


@property (strong, nonatomic) IBOutlet UILabel *miaoshuLabel;

@property (strong, nonatomic) IBOutlet UILabel *chengdanzongshuLabel;

@property (strong, nonatomic) IBOutlet UIImageView *zhunshiimage1;
@property (strong, nonatomic) IBOutlet UIImageView *zhunshiimage2;
@property (strong, nonatomic) IBOutlet UIImageView *zhunshiimage3;
@property (strong, nonatomic) IBOutlet UIImageView *zhunshiimage4;
@property (strong, nonatomic) IBOutlet UIImageView *zhunshiimage5;
@property (strong, nonatomic) IBOutlet UIImageView *jineng1;
@property (strong, nonatomic) IBOutlet UIImageView *jineng2;
@property (strong, nonatomic) IBOutlet UIImageView *jineng3;
@property (strong, nonatomic) IBOutlet UIImageView *jineng4;
@property (strong, nonatomic) IBOutlet UIImageView *jineng5;
@property (strong, nonatomic) IBOutlet UIImageView *xiaolv1;
@property (strong, nonatomic) IBOutlet UIImageView *xiaolv2;
@property (strong, nonatomic) IBOutlet UIImageView *xiaolv3;
@property (strong, nonatomic) IBOutlet UIImageView *xiaolv4;
@property (strong, nonatomic) IBOutlet UIImageView *xiaolv5;
@property (strong, nonatomic) IBOutlet UIImageView *zhiliang1;
@property (strong, nonatomic) IBOutlet UIImageView *zhiliang2;
@property (strong, nonatomic) IBOutlet UIImageView *zhiliang3;
@property (strong, nonatomic) IBOutlet UIImageView *zhiliang4;
@property (strong, nonatomic) IBOutlet UIImageView *zhiliang5;


@property (strong, nonatomic) IBOutlet UIView *blackxian;

@property (strong, nonatomic) IBOutlet UIButton *yichuanniuButton;

@property (strong, nonatomic) IBOutlet UIButton *querenanniuButton;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelwidth5;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;


@end
