//
//  DetailsPageViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/27.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "DetailsPageViewController.h"
#import "JYJLXQModel.h"
@interface DetailsPageViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;
@property (strong, nonatomic) IBOutlet UILabel *label6;
@property (strong, nonatomic) IBOutlet UILabel *label7;
@property (strong, nonatomic) IBOutlet UILabel *label8;
@property (strong, nonatomic) IBOutlet UILabel *label9;
@property (strong, nonatomic) IBOutlet UILabel *label10;
@property (strong, nonatomic) IBOutlet UILabel *label11;
@property (strong, nonatomic) IBOutlet UILabel *label12;
@property (strong, nonatomic) IBOutlet UILabel *label13;
@property (strong, nonatomic) IBOutlet UILabel *label14;
@property (strong, nonatomic) IBOutlet UILabel *label15;
@property (strong, nonatomic) IBOutlet UILabel *label16;
@property (strong, nonatomic) IBOutlet UILabel *label17;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *HightViews;


@end

@implementation DetailsPageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef2f5"];
    self.NVBJImageView.alpha = 1;
    self.titelLabel.text = _BiaotiLabel;
    
}



- (void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/DealRecord/findDealRecordDtail",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.dealRecordId),@"dealRecordId", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        
        if (result == 1) {
            JYJLXQModel *model = [JYJLXQModel creatRankingTotalModelWith:resultDic];
            [self ShuaXinView:model];
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
}

- (void)ShuaXinView:(JYJLXQModel *)model
{
    if ([model.dealTypeNum isEqualToString:@"4"]) {
        self.title = @"提现详情";
        _label1.text = model.dealState;
        _label2.text = @"流水";
        _label4.text = @"类型";
        _label6.text = @"支出";
        _label8.text = @"支付方式";
        _label10.text = @"时间";
        _label12.text = @"余额";
        _label3.text = model.serialNum;
        _label5.text = model.dealType;
        _label7.text = [NSString stringWithFormat:@"%.2f元",model.dealAmount];
        _label9.text = model.modePay;
        _label11.text = model.dealTm;
        _label13.text = [NSString stringWithFormat:@"%.2f",model.balance];
        [_label14 removeFromSuperview];
        [_label15 removeFromSuperview];
        [_label16 removeFromSuperview];
        [_label17 removeFromSuperview];
        _HightViews.constant = 230;

    }else if ([model.dealTypeNum isEqualToString:@"2"])
    {
        self.title = @"退款详情";
        _label1.text = model.dealState;
        _label2.text = @"流水号";
        _label4.text = @"类型";
        _label6.text = @"支出";
        _label8.text = @"工单号";
        _label10.text = @"订单号";
        _label12.text = @"时间";
        _label3.text = model.serialNum;
        _label5.text = model.dealType;
        _label7.text = [NSString stringWithFormat:@"%.2f元",model.dealAmount];
        _label9.text = model.workOrderTab;
        _label11.text = model.orderNum;
        _label13.text = model.dealTm;
        [_label14 removeFromSuperview];
        [_label15 removeFromSuperview];
        [_label16 removeFromSuperview];
        [_label17 removeFromSuperview];
        _HightViews.constant = 230;

        
    }else if ([model.dealTypeNum isEqualToString:@"3"])
    {
        self.title = @"支出详情";
        _label1.text = model.dealState;
        _label2.text = @"流水号";
        _label4.text = @"类型";
        _label6.text = @"支出";
        _label8.text = @"工单号";
        _label10.text = @"订单号";
        _label12.text = @"时间";
        _label3.text = model.serialNum;
        _label5.text = model.dealType;
        _label7.text = [NSString stringWithFormat:@"%.2f元",model.dealAmount];
        _label9.text = model.workOrderTab;
        _label11.text = model.orderNum;
        _label13.text = model.dealTm;
        [_label14 removeFromSuperview];
        [_label15 removeFromSuperview];
        [_label16 removeFromSuperview];
        [_label17 removeFromSuperview];
        _HightViews.constant = 230;
        
    }else if ([model.dealTypeNum isEqualToString:@"1"])
    {
        self.title = @"进账详情";
        _label1.text = model.dealState;
        _label2.text = @"流水号";
        _label4.text = @"类型";
        _label6.text = @"收入";
        _label8.text = @"时间";
        _label10.text = @"收入来源";
        _label12.text = @"订单编号";
        _label14.text = @"工单编号";
        _label16.text = @"工单说明";
        _label3.text = model.serialNum;
        _label5.text = model.dealType;
        _label7.text = [NSString stringWithFormat:@"%.2f元",model.dealAmount];
        _label9.text = model.dealTm;
        _label11.text = model.nick;
        _label13.text = model.orderNum;
        _label15.text = model.workOrderTab;
        _label17.text = model.recruitDetail;
        _HightViews.constant = 290;
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
