//
//  CommonAddressTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/28.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "CommonAddressTableViewCell.h"

@implementation CommonAddressTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _addressLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_addressLabel];
        _detailedAddressLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_detailedAddressLabel];
    }
    return self;
}
- (void)dealloc
{
    self.addressLabel = nil;
    self.detailedAddressLabel = nil;
}
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath CYDZdic:(CYDZModel *)Model{
    _addressLabel.frame = CGRectMake(15, 10, kScreenWidth-30, 15);
    _addressLabel.text = @"详细地址";
    _addressLabel.font = [UIFont systemFontOfSize:15];
   
    _detailedAddressLabel.frame = CGRectMake(15, CGRectGetMaxY(_addressLabel.frame)+18.5, kScreenWidth-30, 37);
    _detailedAddressLabel.text = Model.xiangXiDiZhi;
    _detailedAddressLabel.font = [UIFont systemFontOfSize:15];
    _detailedAddressLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
    //根据最大行数需求来设置
    _detailedAddressLabel.numberOfLines = 0;
    _detailedAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreenWidth-30, 37);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_detailedAddressLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    _detailedAddressLabel.frame = CGRectMake(15, CGRectGetMaxY(_addressLabel.frame)+18.5, expectSize.width, expectSize.height);

    
    
    
    
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
