// 明细
//  DetailTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/25.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 提现 / 支出 / 退款
        _functionLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_functionLabel];
        // 提现 / 支出 / 退款 时间
        _withdrawalTimeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_withdrawalTimeLabel];
        // 余额
        _balanceLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_balanceLabel];
        // 金额
        _TheAmountOfLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_TheAmountOfLabel];
        //线
        _lineView = [[UILabel alloc]init];
        [self.contentView addSubview:_lineView];

    }
    return self;
}

- (void)dealloc
{
    self.functionLabel = nil;
    self.withdrawalTimeLabel = nil;
    self.balanceLabel = nil;
    self.TheAmountOfLabel = nil;
    self.lineView = nil;

}

- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath Model:(JYJLModel *)model{
    
    _functionLabel.frame = CGRectMake(15, 14, 60, 15);
    _functionLabel.text = [NSString stringWithFormat:@"%@",model.dealType];
    _functionLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    _functionLabel.font = [UIFont systemFontOfSize:15];
    
    _withdrawalTimeLabel.frame = CGRectMake(CGRectGetMaxX(_functionLabel.frame), 18.5, kScreenWidth - 30 - _functionLabel.mj_w, 13);
    _withdrawalTimeLabel.text = [NSString stringWithFormat:@"%@",model.dealTm];
    _withdrawalTimeLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
    _withdrawalTimeLabel.textAlignment = NSTextAlignmentRight;
    _withdrawalTimeLabel.font = [UIFont systemFontOfSize:13];
    
    _balanceLabel.frame = CGRectMake(15, CGRectGetMaxY(_functionLabel.frame)+25, (kScreenWidth-30)/2, 14);
    _balanceLabel.text = [NSString stringWithFormat:@"余额:%.2f元",model.balance];
    _balanceLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    _balanceLabel.textAlignment = NSTextAlignmentLeft;
    _balanceLabel.font = [UIFont systemFontOfSize:14];
    
    
    _TheAmountOfLabel.frame = CGRectMake(CGRectGetMaxX(_balanceLabel.frame), CGRectGetMaxY(_withdrawalTimeLabel.frame)+24, (kScreenWidth-30)/2, 14);
    _TheAmountOfLabel.text = [NSString stringWithFormat:@"%.2f元",model.dealAmount];
    _TheAmountOfLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"333333"];
    _TheAmountOfLabel.textAlignment = NSTextAlignmentRight;
    _TheAmountOfLabel.font = [UIFont systemFontOfSize:14];
    
    _lineView.frame = CGRectMake(0, 92 - 10.5, kScreenWidth, 10.5);
    _lineView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef2f5"];
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
