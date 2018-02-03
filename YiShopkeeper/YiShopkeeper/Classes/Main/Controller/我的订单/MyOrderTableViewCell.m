//
//  MyOrderTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/29.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "PingjiaSViewController.h"
#import "DingDanGuiJiSViewController.h"
#import "TalentShowDetailsViewController.h"
#import "DaRenXiangQingViewController.h"
@interface MyOrderTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *touxiang;
@property (strong, nonatomic) IBOutlet UILabel *gongdanbiaoti;
@property (strong, nonatomic) IBOutlet UILabel *fabushijian;
@property (strong, nonatomic) IBOutlet UIButton *daipingjiaButton;
@property (strong, nonatomic) IBOutlet UILabel *shijianbiaoti;
@property (strong, nonatomic) IBOutlet UILabel *kaigongshijian;
@property (strong, nonatomic) IBOutlet UILabel *gongzuoshijian;
@property (strong, nonatomic) IBOutlet UILabel *zhiwei;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidianbiaoti;
@property (strong, nonatomic) IBOutlet UILabel *gongzuodidian;
@property (strong, nonatomic) IBOutlet UIButton *quxiaobaomingButton;
@property (strong, nonatomic) IBOutlet UIButton *weiButton;
@property (strong, nonatomic) dingdanModel *models;
@end


@implementation MyOrderTableViewCell

- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataDic:(dingdanModel *)dic
{
    self.models = dic;
    _daipingjiaButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _daipingjiaButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _daipingjiaButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _daipingjiaButton.layer.masksToBounds = YES;
    
//    if ([_ButtonNameStr isEqualToString:@"1"] ) {
//        [_quxiaobaomingButton setTitle:@"取消订单" forState:UIControlStateNormal];
//    }else
//    {
//        [_quxiaobaomingButton setTitle:@"订单轨迹" forState:UIControlStateNormal];
//    }
    //给按钮设置角的弧度
    _quxiaobaomingButton.layer.cornerRadius = 4.0f;
    //设置背景颜色
    _quxiaobaomingButton.layer.masksToBounds = YES;
    
    
    _weiButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _weiButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _weiButton.layer.cornerRadius = 4.0f;
    //设置背景颜色
    _weiButton.layer.masksToBounds = YES;
    
    
    [_touxiang sd_setImageWithURL:[NSURL URLWithString:dic.daRenTouXiang]placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_gongdanbiaoti setText:dic.daRenMingCheng];
    [_fabushijian setText:dic.baoMingShiJian];
    [_kaigongshijian setText:dic.kaiShiShiJian];
    [_gongzuoshijian setText:[NSString stringWithFormat:@"%ld小时",dic.gongZuoShiChang]];
    [_zhiwei setText:dic.gongZhong];
    [_gongzuodidian setText:dic.diZhi];
    
    if (self.zhuangtai == 3) {
        if (dic.dingDanZhuangTai != 6) {
            [_daipingjiaButton removeFromSuperview];
        }
    }
//    if (dic.dingDanZhuangTai != 6 || dic.dingDanZhuangTai != 8) {
//        [_quxiaobaomingButton removeFromSuperview];
//    }
    if (dic.dingDanZhuangTai == 1){
        _weiButton.hidden = NO;
        _quxiaobaomingButton.hidden = NO;
        [_daipingjiaButton setTitle:@"待确认" forState:UIControlStateNormal];
        [_weiButton setTitle:@"移出" forState:UIControlStateNormal];
        [_quxiaobaomingButton setTitle:@"确认" forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 2){
        _weiButton.hidden = NO;
        _quxiaobaomingButton.hidden = NO;
        [_daipingjiaButton setTitle:@"待到达" forState:UIControlStateNormal];
        [_weiButton setTitle:@"未到达" forState:UIControlStateNormal];
        [_quxiaobaomingButton setTitle:@"确认到达" forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 3){
        _quxiaobaomingButton.hidden = NO;
        [_daipingjiaButton setTitle:@"待完工" forState:UIControlStateNormal];
        _weiButton.hidden = YES;
        [_quxiaobaomingButton setTitle:@"确认完工" forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 4){
        _weiButton.hidden = NO;
        _quxiaobaomingButton.hidden = NO;
        [_daipingjiaButton setTitle:@"待验收" forState:UIControlStateNormal];
        [_weiButton setTitle:@"查看轨迹" forState:UIControlStateNormal];
        [_quxiaobaomingButton setTitle:@"验收" forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 6){
        _quxiaobaomingButton.hidden = NO;
        [_daipingjiaButton setTitle:@"待评价" forState:UIControlStateNormal];
        _weiButton.hidden = YES;
        [_quxiaobaomingButton setTitle:@"评价" forState:UIControlStateNormal];
    }else if (dic.dingDanZhuangTai == 8){
        _quxiaobaomingButton.hidden = NO;
        [_daipingjiaButton setTitle:@"已完成" forState:UIControlStateNormal];
        _weiButton.hidden = YES;
        _quxiaobaomingButton.hidden = YES;
    }else if (dic.dingDanZhuangTai == 9){
        [_daipingjiaButton setTitle:@"已拒绝" forState:UIControlStateNormal];
        _weiButton.hidden = YES;
        _quxiaobaomingButton.hidden = YES;
    } else if (dic.dingDanZhuangTai == 10) {
        [_daipingjiaButton setTitle:@"异常订单" forState:UIControlStateNormal];
        _weiButton.hidden = YES;
        _quxiaobaomingButton.hidden = YES;
    }else if (dic.dingDanZhuangTai == 11){
        [_daipingjiaButton setTitle:@"已取消" forState:UIControlStateNormal];
        _weiButton.hidden = YES;
        _quxiaobaomingButton.hidden = YES;
    }
}

- (IBAction)daipingjiasbutton {
//    __block __typeof(self) weakSelf = self;

    if (_zhuangtai == 6 ) {
        PingjiaSViewController *PingjiaSVC = [[PingjiaSViewController alloc]init];
        PingjiaSVC.dingDanId = self.models.dingDanId;
        PingjiaSVC.gongDanId = self.models.gongDanId;
        [self.Navi pushViewController:PingjiaSVC animated:YES];
    }else if (_zhuangtai == 2 || _zhuangtai == 13) {
        TalentShowDetailsViewController *TalentShowDetailsVC = [[TalentShowDetailsViewController alloc]init];
//        TalentShowDetailsVC.homeModel = INdexpathDlc;
//        [TalentShowDetailsVC setBlock:^(NSString *str) {
//            [weakSelf headerRereshing];
//        }];
        [self.Navi pushViewController:TalentShowDetailsVC animated:YES];
    }
    
}






- (IBAction)zhuangtaisButton:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        NSLog(@"取消订单");
    }else if ([sender.titleLabel.text isEqualToString:@"订单轨迹"])
    {
        NSLog(@"订单轨迹");
        DingDanGuiJiSViewController *DingDanGuiJiSVC = [[DingDanGuiJiSViewController alloc]init];
        [self.Navi pushViewController:DingDanGuiJiSVC animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"评价"])
    {
        PingjiaSViewController *PingjiaSVC = [[PingjiaSViewController alloc]init];
        PingjiaSVC.dingDanId = self.models.dingDanId;
        PingjiaSVC.gongDanId = self.models.gongDanId;
        [self.Navi pushViewController:PingjiaSVC animated:YES];
    }
}

- (void)dealloc
{
    _weiButton = nil;
    _quxiaobaomingButton = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
