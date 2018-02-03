//
//  QueRentiXingTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/11.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "QueRentiXingTableViewCell.h"

@implementation QueRentiXingTableViewCell

- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath MasseaModelData:(MasseaModel *)Model;
{
    if ([_TiShiStr isEqualToString:@"确认提醒"]) {
        _biaotiLabel.text = _TiShiStr;
    }else if ([_TiShiStr isEqualToString:@"验收提醒"])
    {
        _biaotiLabel.text = _TiShiStr;
    }
    self.biaotiLabel.text = Model.msgTotal;
    self.shijianLabel.text = Model.seetime;
    self.zhangguimingchengLabel.text = Model.userName;
    self.gongzhongLabel.text = Model.workType;
    self.gongzuoshichang.text = Model.woekDuration;
    self.gongdanbianhaoLabel.text = Model.workOrderTab;
    self.tixingxinxiLabel.text = Model.msgContent;
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
