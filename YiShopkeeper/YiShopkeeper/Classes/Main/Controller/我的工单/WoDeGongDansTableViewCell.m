//
//  WoDeGongDansTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "WoDeGongDansTableViewCell.h"
@interface WoDeGongDansTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UILabel *shijianLabel;
@property (strong, nonatomic) IBOutlet UIButton *anniusButton;
@property (strong, nonatomic) IBOutlet UILabel *fabushijianLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshichangLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzhongLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidianLabel;
@property (strong, nonatomic) IBOutlet UILabel *gongjijineLabel;


@end


@implementation WoDeGongDansTableViewCell
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataModel:(gongdansModel *)Model
{
    [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:Model.gongDanTuPian] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_biaotiLabel setText:Model.biaoTi];
    [_shijianLabel setText:Model.faBuShiJian];
    [_fabushijianLabel setText:Model.kaiShiShiJian];
    [_gongzuoshichangLabel setText:[NSString stringWithFormat:@"%ld小时",Model.xiaoShi]];
    [_gongzhongLabel setText:Model.jiNeng];
    [_gongzuodidianLabel setText:Model.diZhi];
    [_gongjijineLabel setText:[NSString stringWithFormat:@"共计：%.2f元",Model.zongJi]];
    [self.anniusButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    _anniusButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
    if (Model.zhuangTai == 1) {
        [self.anniusButton setTitle:@"未报名" forState:UIControlStateNormal];

    }else if(Model.zhuangTai == 2)
    {
       [self.anniusButton setTitle:@"进行中" forState:UIControlStateNormal];
    }else if(Model.zhuangTai == 3)
    {
        [self.anniusButton setTitle:@"已完工" forState:UIControlStateNormal];
    }else if(Model.zhuangTai == 4)
    {
        [self.anniusButton setTitle:@"已取消" forState:UIControlStateNormal];
    }else if(Model.zhuangTai == 5)
    {
        [self.anniusButton setTitle:@"异常工单" forState:UIControlStateNormal];
    }
    
    
    
//    _anniusButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _anniusButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _anniusButton.layer.cornerRadius = 4.0f;
    //设置背景颜色
    _anniusButton.layer.masksToBounds = YES;
    
//    if ([_jinduStr isEqualToString:@"1"]) {
//        [self.anniusButton setTitle:@"进行中" forState:UIControlStateNormal];
//        [self.anniusButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
//        _anniusButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
//
//    }else if ([_jinduStr isEqualToString:@"2"])
//    {
//        [self.anniusButton setTitle:@"已完工" forState:UIControlStateNormal];
//    }else if ([_jinduStr isEqualToString:@"3"])
//    {
//        [self.anniusButton setTitle:@"以取消" forState:UIControlStateNormal];
//    }
    
}

- (IBAction)jinxingzhuangtaiBtn:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
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
