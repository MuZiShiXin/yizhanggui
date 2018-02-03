//
//  PeopleNearbyTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2018/1/25.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import "PeopleNearbyTableViewCell.h"

@implementation PeopleNearbyTableViewCell

- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath baomingxinxiModel:(PeopleNearbyModel *)maodel
{
    _model = maodel;
    [self.touxiangImageView sd_setImageWithURL:[NSURL URLWithString:maodel.headPicAdd]placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [self.darenxingmingLabel setText:maodel.nick];
    [self.nianlingLabel setText:[NSString stringWithFormat:@"%ld",maodel.age]];
    if ([maodel.gender isEqualToString:@"男"]) {
        [self.xingbieImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb2"]];
    }else
    {
        [self.xingbieImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb1"]];
    }
    [self.gonglingLabel setText:[NSString stringWithFormat:@"%ld 年",maodel.workYear]];
    [self.juliLabel setText:[NSString stringWithFormat:@"距离:%@ m",maodel.distance]];
    self.yaoqingButton.layer.cornerRadius = 4;
}



- (IBAction)yaoqingButtonSender{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/askforDr",kPRTURL];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userZgId",@(_model.userInfoId),@"userDrId", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj objectForKey:@"result"] integerValue];
        if (result == 1) {
            [self showRightWithTitle:@"邀请成功" autoCloseTime:2];
        }else
        {
            [self showInfoWithTitle:@"请勿重复操作" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
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
