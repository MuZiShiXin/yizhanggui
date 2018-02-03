//
//  PeopleNearbyTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2018/1/25.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleNearbyModel.h"
@interface PeopleNearbyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;
@property (strong, nonatomic) IBOutlet UILabel *darenxingmingLabel;
@property (strong, nonatomic) IBOutlet UILabel *nianlingLabel;

@property (strong, nonatomic) IBOutlet UIImageView *xingbieImageView;

@property (strong, nonatomic) IBOutlet UILabel *gonglingLabel;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;
@property (strong, nonatomic) IBOutlet UIButton *yaoqingButton;

@property (assign ,nonatomic) NSInteger userDrId;
@property (assign ,nonatomic) NSInteger userZgId;

@property (strong, nonatomic) PeopleNearbyModel *model;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath baomingxinxiModel:(PeopleNearbyModel *)maodel;





@end
