// 明细
//  DetailTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/25.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYJLModel.h"
@interface DetailTableViewCell : UITableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath Model:(JYJLModel *)model;

// 提现 / 支出 / 退款
@property (nonatomic, strong) UILabel *functionLabel;
// 提现 / 支出 / 退款 时间
@property (nonatomic, strong) UILabel *withdrawalTimeLabel;
;
// 余额
@property (nonatomic, strong) UILabel *balanceLabel;
;
// 金额
@property (nonatomic, strong) UILabel *TheAmountOfLabel;
;
// 线
@property (nonatomic, strong) UIView *lineView;
;


@end
