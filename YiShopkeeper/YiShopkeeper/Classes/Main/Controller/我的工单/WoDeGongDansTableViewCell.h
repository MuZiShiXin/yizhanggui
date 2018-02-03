//
//  WoDeGongDansTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gongdansModel.h"


@interface WoDeGongDansTableViewCell : UITableViewCell
@property (strong ,nonatomic)NSString *jinduStr;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataModel:(gongdansModel *)Model;
@end
