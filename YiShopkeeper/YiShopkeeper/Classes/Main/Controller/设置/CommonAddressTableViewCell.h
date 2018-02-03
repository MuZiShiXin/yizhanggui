//
//  CommonAddressTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYDZModel.h"
@interface CommonAddressTableViewCell : UITableViewCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath CYDZdic:(CYDZModel *)Model;

//地址
@property (nonatomic, strong) UILabel *addressLabel;
//详细地址
@property (nonatomic, strong) UILabel *detailedAddressLabel;
@end
