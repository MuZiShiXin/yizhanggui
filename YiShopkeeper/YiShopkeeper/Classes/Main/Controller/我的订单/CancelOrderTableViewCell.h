//
//  CancelOrderTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/30.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dingdanModel.h"
@interface CancelOrderTableViewCell : UITableViewCell
@property (nonatomic ,strong)UINavigationController *Navi;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataDic:(dingdanModel *)dic;
@end
