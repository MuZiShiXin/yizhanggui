//
//  QueRentiXingTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/11.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasseaModel.h"
@interface QueRentiXingTableViewCell : UITableViewCell
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath MasseaModelData:(MasseaModel *)Model;

@property (strong, nonatomic) NSString *TiShiStr;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UILabel *shijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhangguimingchengLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzhongLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshichang;
@property (strong, nonatomic) IBOutlet UILabel *gongdanbianhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *tixingxinxiLabel;



@end
