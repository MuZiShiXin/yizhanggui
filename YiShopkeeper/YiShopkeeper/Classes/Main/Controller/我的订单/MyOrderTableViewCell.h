//
//  MyOrderTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/29.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dingdanModel.h"
@interface MyOrderTableViewCell : UITableViewCell
@property (nonatomic ,strong)UINavigationController *Navi;
@property (nonatomic ,assign)NSInteger zhuangtai;
@property (nonatomic ,strong)NSString *ButtonNameStr;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataDic:(dingdanModel *)dic;
@end
