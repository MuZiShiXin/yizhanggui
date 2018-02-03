//
//  DingDanXiangQingSViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "DingDanXiangQingSViewController.h"
#import "dingdanxiangqingModel.h"
@interface DingDanXiangQingSViewController ()
@property (nonatomic ,strong) dingdanxiangqingModel *Model;
@end

@implementation DingDanXiangQingSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"订单详情";
    [self httpRequest];

}

- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/dingdan/dingdanxinxi",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.dingDanId),@"dingDanId",@(12.1),@"x",@(13.1),@"y", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        if (result == 1) {
            self.Model = [dingdanxiangqingModel creatRankingTotalModelWith:resultDic];
            [self refreshView:self.Model];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
}

- (void)refreshView:(dingdanxiangqingModel *)model
{
    [self liuchengImagejindu:[NSString stringWithFormat:@"%ld",model.orderState]];
    [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:model.headPicAdd] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_biaotiLabel setText:model.workTotal];
    [_feoyongLabel setText:[NSString stringWithFormat:@"%.2f",model.pay]];
    [_danweiLabel setText:[NSString stringWithFormat:@"/%@",model.payUtil]];
    [_zongjiaLabel setText:[NSString stringWithFormat:@"共计：%.2f元",model.payAll]];

    [_gongzuoshijianLabel setText: model.startTm];
    [_gongzuoshichangLabel setText:[NSString stringWithFormat:@"%ld小时",model.woekDuration]];
    [_gongzhongLabel setText:model.workType];
    [_xuyaorenshuLabel setText:[NSString stringWithFormat:@"%ld人  剩余:",model.recruitNum]];
    [_shengyurenshuLabel setText:[NSString stringWithFormat:@"%ld人",model.lastPeoNum]];
    [_juliLabel setText:[NSString stringWithFormat:@"%@m",model.distance]];
    [_teshuyaoqiuLabel setText:model.workDetail];
    [_gongzuodizhiLabel setText:model.minuteAdd];
    [_gongdanbianhaoLabel setText:model.workOrderTab];
    [_dingdanbianhaoLabel setText:model.orderNum];
    [_baomngshijianoLabel setText:model.applyTm];
    [_jiafangquerenshijianLabel setText:model.owberTm];
    [_daodashijianLabel setText:model.arrivalTm];
    [_wangongshijianLabel setText:model.completeTm];
    [_jiafangyanshoushijianLabel setText:model.owberAccpetTm];
    
    if (model.orderState == 11) {
        
        _ViewHight.constant = 1048 ;
    }else
    {
        _ViewHight.constant = 1048 - 105;
        [_quxiaoSSLabel removeFromSuperview];
        [_quxiaoyuanyinLabel removeFromSuperview];
    }
    
}

- (void)liuchengImagejindu:(NSString *)str
{
    if ([str isEqualToString:@"1"]) {
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
         [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 0.1428;
        
    }else if ([str isEqualToString:@"2"]||[str isEqualToString:@"13"])
    {
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 0.2857;
        
    }else if ([str isEqualToString:@"3"])
    {
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView4 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage4 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 0.4285;
        
    }else if ([str isEqualToString:@"4"])
    {
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView4 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView5 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage5 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 0.5714;
        
        
    }else if ([str isEqualToString:@"5"])
    {
  
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView4 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView5 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView6 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage6 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 0.7142;
        
    }else if ([str isEqualToString:@"6"])
    {
        
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView4 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView5 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView6 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView7 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage7 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 0.8571;
        
    }else if ([str isEqualToString:@"8"])
    {
        [self.liuchengImageView1 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView2 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView3 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView4 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView5 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView6 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView7 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.liuchengImageView8 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb1"]];
        [self.dingdanzhuangtaiImage8 setImage:[UIImage imageNamed:@"yg_dd_qxxq_nr_tb2"]];
        self.jinduProgressView.progress = 1;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
