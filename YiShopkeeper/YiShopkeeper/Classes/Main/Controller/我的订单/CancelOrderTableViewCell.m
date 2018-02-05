//
//  CancelOrderTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/30.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "CancelOrderTableViewCell.h"
#import "PingjiaSViewController.h"
#import "TalentShowDetailsViewController.h"
@interface CancelOrderTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
@property (strong, nonatomic) IBOutlet UILabel *gongdanbiaoti;
@property (strong, nonatomic) IBOutlet UILabel *fabushijian;
@property (strong, nonatomic) IBOutlet UIButton *yiquxiaoButton;
@property (strong, nonatomic) IBOutlet UILabel *shijianbiaoti;
@property (strong, nonatomic) IBOutlet UILabel *kaigongshijian;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshijian;
@property (strong, nonatomic) IBOutlet UILabel *zhiwei;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidianbiaoti;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidian;
@property (strong, nonatomic) dingdanModel *models;
@end


@implementation CancelOrderTableViewCell



- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataDic:(dingdanModel *)dic
{
    self.models = dic;
    _yiquxiaoButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _yiquxiaoButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _yiquxiaoButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _yiquxiaoButton.layer.masksToBounds = YES;
    _yiquxiaoButton.tag = dic.dingDanId;
    [_touxiang sd_setImageWithURL:[NSURL URLWithString:dic.daRenTouXiang]placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_gongdanbiaoti setText:dic.daRenMingCheng];
    [_fabushijian setText:dic.baoMingShiJian];
    [_kaigongshijian setText:dic.kaiShiShiJian];
    [_gongzuoshijian setText:[NSString stringWithFormat:@"%ld小时",dic.gongZuoShiChang]];
    [_zhiwei setText:dic.gongZhong];
    [_gongzuodidian setText:dic.diZhi];

    if (dic.dingDanZhuangTai == 1){
        [_yiquxiaoButton setTitle:@"待确认" forState:UIControlStateNormal];
        _yiquxiaoButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
        [_yiquxiaoButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 2 || dic.dingDanZhuangTai == 13)
    {
        [_yiquxiaoButton setTitle:@"待到达" forState:UIControlStateNormal];
//        _yiquxiaoButton.userInteractionEnabled = NO;
        _yiquxiaoButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
        [_yiquxiaoButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 3)
    {
        [_yiquxiaoButton setTitle:@"待完工" forState:UIControlStateNormal];
        _yiquxiaoButton.userInteractionEnabled = NO;

    }else if (dic.dingDanZhuangTai == 4)
    {
        [_yiquxiaoButton setTitle:@"待验收" forState:UIControlStateNormal];
        _yiquxiaoButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
        [_yiquxiaoButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 5)
    {
        [_yiquxiaoButton setTitle:@"结算中" forState:UIControlStateNormal];
        _yiquxiaoButton.userInteractionEnabled = NO;

    }else if (dic.dingDanZhuangTai == 6 ||dic.dingDanZhuangTai == 15)
    {
        [_yiquxiaoButton setTitle:@"待评价" forState:UIControlStateNormal];
        _yiquxiaoButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
        [_yiquxiaoButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 8)
    {
        [_yiquxiaoButton setTitle:@"订单结束" forState:UIControlStateNormal];
        _yiquxiaoButton.userInteractionEnabled = NO;

    }else if (dic.dingDanZhuangTai == 10)
    {
        [_yiquxiaoButton setTitle:@"工单异常" forState:UIControlStateNormal];
        _yiquxiaoButton.userInteractionEnabled = NO;

    }else if (dic.dingDanZhuangTai == 11)
    {
        [_yiquxiaoButton setTitle:@"已取消" forState:UIControlStateNormal];
        _yiquxiaoButton.userInteractionEnabled = NO;
    }else if (dic.dingDanZhuangTai == 14)
    {
        [_yiquxiaoButton setTitle:@"已评价" forState:UIControlStateNormal];
        _yiquxiaoButton.userInteractionEnabled = NO;
    }
    
}




- (IBAction)dianjishijianAnNiu:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"待评价"]) {
        PingjiaSViewController *PingjiaSVC = [[PingjiaSViewController alloc]init];
        PingjiaSVC.dingDanId = self.models.dingDanId;
        PingjiaSVC.gongDanId = self.models.gongDanId;
        PingjiaSVC.daRenID   = self.models.daRenId;
        [self.Navi pushViewController:PingjiaSVC animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"已取消"] || [btn.titleLabel.text isEqualToString:@"订单结束"] || [btn.titleLabel.text isEqualToString:@"工单异常"])
    {
        return;
    }else
    {
        TalentShowDetailsViewController *TalentShowDetailsVC = [[TalentShowDetailsViewController alloc]init];
        TalentShowDetailsVC.dingdanId = btn.tag;
        TalentShowDetailsVC.Navi = self.Navi;
        [self.Navi pushViewController:TalentShowDetailsVC animated:YES];
    }
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
