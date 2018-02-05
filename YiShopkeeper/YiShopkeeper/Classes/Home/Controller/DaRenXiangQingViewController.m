//
//  DaRenXiangQingViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "DaRenXiangQingViewController.h"
#import "MyWorkSheetDetailsViewController.h"
#import "DaRenModel.h"
#import "TipAlertView.h"
@interface DaRenXiangQingViewController ()
@property (strong ,nonatomic) DaRenModel *daRenModel;
@property (nonatomic ,strong)TipAlertView *alert;

@end

@implementation DaRenXiangQingViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _view1.hidden = YES;
    _view2.hidden = YES;
    _view3.hidden = YES;
    [self httpRequest];
}


-(void)httpRequest
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/daren",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.homeModel.dingDanId),@"dingDanId", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSDictionary *resultDic = [responseObj objectForKeyWithNullDetection:@"data"];
        _daRenModel = [DaRenModel creatRankingTotalModelWith:resultDic];
        if (result == 1) {
            [self setValueSDic:_daRenModel];
            _view1.hidden = NO;
            _view2.hidden = NO;
            _view3.hidden = NO;
        }else
        {
            
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
    self.titelLabel.text = @"达人详情";
    [self WorkDetailsButton];
    _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _shoucangButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _shoucangButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _shoucangButton.layer.masksToBounds = YES;
    
    if (self.homeModel.dingDanZhuangTai != 1) {
        self.yichuanniuButton.hidden = YES;
        self.querenanniuButton.hidden = YES;
        self.blackxian.hidden = YES;
    }
}

- (void)setValueSDic:(DaRenModel *)dic
{
    [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:dic.touXiang]placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_biaotiLabel setText:dic.niCheng];
    
    if (dic.shouCang == 1) {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    }else
    {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    [_biaotiLabel setText:dic.niCheng];
    [_nianlingLabel setText:[NSString stringWithFormat:@"%ld", dic.nianLing]];
    if ([dic.xingBie isEqualToString:@"男"]) {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }else
    {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }
    [_gonglingLabel setText:[NSString stringWithFormat:@"%ld年",(long) dic.gongLing]];
    
//    NSArray * ary = @[@"1",@"2",@"3",@"4",@"5"];
    if (dic.gongZhongs.count >= 1 && dic.gongZhongs.count > 0) {
        _zhiweiLabel1.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
        //设置边框宽度
        _zhiweiLabel1.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel1.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel1.layer.masksToBounds = YES;
        _zhiweiLabel1.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel1.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
        [_zhiweiLabel1 setText:dic.gongZhongs[0]];
        _zhiweiLabel1.textAlignment = 1;
        CGFloat labellingwidth1 = [UILabel getWidthWithTitle:_zhiweiLabel1.text font:_zhiweiLabel1.font];
        self.zhiweiLabel1.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+11, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth1+10, 15);
        _labelwidth1.constant = labellingwidth1+10;
    }else
    {
        [_zhiweiLabel1 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count >= 2 && dic.gongZhongs.count > 1) {
        _zhiweiLabel2.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _zhiweiLabel2.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel2.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel2.layer.masksToBounds = YES;
        _zhiweiLabel2.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel2.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_zhiweiLabel2 setText:dic.gongZhongs[1]];
        _zhiweiLabel2.textAlignment = 1;
        CGFloat labellingwidth2 = [UILabel getWidthWithTitle:_zhiweiLabel2.text font:_zhiweiLabel2.font];
        self.zhiweiLabel2.frame = CGRectMake(CGRectGetMaxX(_zhiweiLabel1.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth2+10, 15);
        _labelwidth2.constant = labellingwidth2+10;
    }else
    {
        [_zhiweiLabel2 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count >= 3 && dic.gongZhongs.count > 2) {
        _zhiweiLabel3.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _zhiweiLabel3.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel3.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel3.layer.masksToBounds = YES;
        _zhiweiLabel3.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel3.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_zhiweiLabel3 setText:dic.gongZhongs[2]];
        _zhiweiLabel3.textAlignment = 1;
        CGFloat labellingwidth3 = [UILabel getWidthWithTitle:_zhiweiLabel3.text font:_zhiweiLabel3.font];
        self.zhiweiLabel3.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth3+10, 15);
        _labelwidth3.constant = labellingwidth3+10;

    }else
    {
        [_zhiweiLabel3 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count >= 4 && dic.gongZhongs.count > 3) {
        _zhiweiLabel4.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
        //设置边框宽度
        _zhiweiLabel4.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel4.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel4.layer.masksToBounds = YES;
        _zhiweiLabel4.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel4.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
        [_zhiweiLabel4 setText:dic.gongZhongs[3]];
        _zhiweiLabel4.textAlignment = 1;
        CGFloat labellingwidth4 = [UILabel getWidthWithTitle:_zhiweiLabel4.text font:_zhiweiLabel4.font];
        self.zhiweiLabel4.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth4+10, 15);
        _labelwidth4.constant = labellingwidth4+10;

    }else
    {
        [_zhiweiLabel4 removeFromSuperview];
    }
    
    if (dic.gongZhongs.count <= 5 && dic.gongZhongs.count > 4) {
        _zhiweiLabel5.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _zhiweiLabel5.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _zhiweiLabel5.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _zhiweiLabel5.layer.masksToBounds = YES;
        _zhiweiLabel5.font = [UIFont systemFontOfSize:10];
        _zhiweiLabel5.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_zhiweiLabel5 setText:dic.gongZhongs[4]];
        _zhiweiLabel5.textAlignment = 1;
        CGFloat labellingwidth5 = [UILabel getWidthWithTitle:_zhiweiLabel5.text font:_zhiweiLabel5.font];
        self.zhiweiLabel5.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_gonglingLabel.frame)+9.5, labellingwidth5+10, 15);
        _labelwidth5.constant = labellingwidth5+10;

    }else
    {
        [_zhiweiLabel5 removeFromSuperview];
    }
    [_miaoshuLabel setText:dic.neiRong];
    
    [_chengdanzongshuLabel setText:[NSString stringWithFormat:@"成单 %ld 单",dic.chengDanShu]];
    [self xingxing:dic.zhunShi Str:@"准时"];
    [self xingxing:dic.jiNeng Str:@"技能"];
    [self xingxing:dic.xiaoLv Str:@"效率"];
    [self xingxing:dic.zhiLiang Str:@"质量"];
}

//工作详情
- (void)WorkDetailsButton
{
    UIButton *WorkDetailsBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, 30, 100, 22)];
    [WorkDetailsBtn setTitle:@"工作信息" forState:UIControlStateNormal];
    [WorkDetailsBtn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"27b8f3"] forState:UIControlStateNormal];
    WorkDetailsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [WorkDetailsBtn addTarget:self action:@selector(WorkDetailsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WorkDetailsBtn];
}

#pragma mark 工作信息
- (void)WorkDetailsBtn
{
    NSLog(@"工作信息");
    MyWorkSheetDetailsViewController *MyWorkSheetDetailsVC = [[MyWorkSheetDetailsViewController alloc]init];
    MyWorkSheetDetailsVC.recruitInfoId = self.homeModel.gongDanId;
    [self.navigationController pushViewController:MyWorkSheetDetailsVC animated:YES];
}





#pragma mark - 收藏
- (IBAction)shoucangBtn {
    NSLog(@"收藏");
    if ([_shoucangImageView.image isEqual:[UIImage imageNamed:@"yg_sy_nr_tb3"]]) {
        NSLog(@"收藏");
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
        
    }else {
        NSLog(@"取消收藏");
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shoucang",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.homeModel.zhangGuiId),@"zhangGuiId",@(self.homeModel.daRenId),@"daRenId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            NSLog(@"收藏成功");
            if (self.homeModel.shouCang == 0) {
                self.homeModel.shouCang = 1;
                [self showRightWithTitle:@"收藏成功" autoCloseTime:2];
                
            }else
            {
                self.homeModel.shouCang = 0;
                [self showRightWithTitle:@"取消收藏成功" autoCloseTime:2];
            }
        }else
        {
            NSLog(@"收藏失败");
            [self showRightWithTitle:@"收藏失败" autoCloseTime:2];
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
    
    
}





#pragma mark - 移除
- (IBAction)yichuButton {
    NSLog(@"移除");
    __weak typeof(self) weakSelf = self;
    self.alert = [[TipAlertView alloc] initWithMessage:[NSString stringWithFormat:@"是否%@", self.yichuanniuButton.titleLabel.text]
                                                 image:[UIImage imageNamed:@"11"]
                                          buttonTitles:@[@"取消",@"确认"]];
    
    self.alert.AcceptBlock = ^(){
        NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(weakSelf.homeModel.dingDanId),@"myOrderId",@(9),@"orderState",@(weakSelf.homeModel.gongDanId),@"recruitInfoId", nil];
        
        [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
            if (result == 1) {
                NSLog(@"成功");
                [weakSelf showRightWithTitle:@"移除成功" autoCloseTime:2];
                if (weakSelf.block != nil) {
                    weakSelf.block(weakSelf.indexPath);
                }

            }else if (result == 2)
            {
                [weakSelf showInfoWithTitle:@"请勿重复提交" autoCloseTime:2];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
            
        }];
    };
    self.alert.RefuseBlock = ^(){
        
        
    };
    [self.alert show];
    
    
}

#pragma mark - 确认
- (IBAction)quedingButton {
    NSLog(@"确认");
    NSLog(@"确认到达");
    self.querenanniuButton.userInteractionEnabled = NO;
    self.yichuanniuButton.userInteractionEnabled = NO;
    __weak typeof(self) weakSelf = self;
    self.alert = [[TipAlertView alloc] initWithMessage:@"是否确认报名"
                                                 image:[UIImage imageNamed:@"11"]
                                          buttonTitles:@[@"取消",  @"确认"]];
    
    self.alert.AcceptBlock = ^(){
        
        NSLog(@"确认",nil);
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(weakSelf.homeModel.dingDanId),@"myOrderId",@(2),@"orderState",@(weakSelf.homeModel.gongDanId),@"recruitInfoId", nil];
        
        [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj valueForKey:@"result"] intValue];
            ;
            if (result == 1) {
                NSLog(@"成功");
                [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                weakSelf.homeModel.dingDanZhuangTai = 2;
                if (weakSelf.blocks != nil) {
                    weakSelf.blocks(@"1");
                }
                
            }else if (result == 2)
            {
                [weakSelf showInfoWithTitle:@"请勿重复提交" autoCloseTime:2];
            }
            else
            {
                [weakSelf showErrorWithTitle:@"提交失败" autoCloseTime:2];
                weakSelf.querenanniuButton.userInteractionEnabled = YES;
                weakSelf.yichuanniuButton.userInteractionEnabled = YES;
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
            weakSelf.querenanniuButton.userInteractionEnabled = YES;
            weakSelf.yichuanniuButton.userInteractionEnabled = YES;

        }];
    };
    self.alert.RefuseBlock = ^(){
        
        
    };
    [self.alert show];
}


- (void)xingxing:(double)douNumber Str:(NSString *)str
{
    //ygdr_sy_nr_tb2 半星
    //yg_sy_gdpj_nr_tb2 全星
    //yg_sy_gdpj_nr_tb3 没星
    if ((douNumber <= 0.5 && douNumber > 0.0) || (douNumber <= 1.5 && douNumber > 1.0) || (douNumber <= 2.5 && douNumber > 2.0) || (douNumber <= 3.5 && douNumber > 3.0) || (douNumber <= 4.5 && douNumber > 4.0)){
        if ((douNumber <= 0.5 && douNumber > 0.0)) {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:banxing]];
            }
        }else if ((douNumber <= 1.5 && douNumber > 1.0))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang1 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:banxing]];
            }
            
        }else if ((douNumber <= 2.5 && douNumber > 2.0))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage3 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang3 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
                [_jineng3 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv3 setImage:[UIImage imageNamed:banxing]];
            }

        }else if ((douNumber <= 3.5 && douNumber > 3.0))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage3 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage4 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang3 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang4 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
                [_jineng3 setImage:[UIImage imageNamed:quanxing]];
                [_jineng4 setImage:[UIImage imageNamed:banxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv3 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv4 setImage:[UIImage imageNamed:banxing]];
            }

        }else if ((douNumber <= 4.5 && douNumber > 4.0))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage3 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage4 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage5 setImage:[UIImage imageNamed:banxing]];

            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang3 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang4 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang5 setImage:[UIImage imageNamed:banxing]];

            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
                [_jineng3 setImage:[UIImage imageNamed:quanxing]];
                [_jineng4 setImage:[UIImage imageNamed:quanxing]];
                [_jineng5 setImage:[UIImage imageNamed:banxing]];

            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv3 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv4 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv5 setImage:[UIImage imageNamed:banxing]];

            }

        }

    }else if ((douNumber <= 1.0 && douNumber > 0.5) || (douNumber <= 2.0 && douNumber > 1.5) || (douNumber <= 3.0 && douNumber > 2.5) || (douNumber <= 4.0 && douNumber > 3.5) || (douNumber <= 5.0 && douNumber > 4.5)){
        if ((douNumber <= 1.0 && douNumber > 0.5)) {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
            }
        }else if ((douNumber <= 2.0 && douNumber > 1.5))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
            }

        }else if ((douNumber <= 3.0 && douNumber > 2.5))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage3 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang3 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
                [_jineng3 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv3 setImage:[UIImage imageNamed:quanxing]];
            }

        }else if ((douNumber <= 4.0 && douNumber > 3.5))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage3 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage4 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang3 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang4 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
                [_jineng3 setImage:[UIImage imageNamed:quanxing]];
                [_jineng4 setImage:[UIImage imageNamed:quanxing]];
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv3 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv4 setImage:[UIImage imageNamed:quanxing]];
            }
        }else if ((douNumber <= 5.0 && douNumber > 4.5))
        {
            if ([str isEqualToString:@"准时"]) {
                [_zhunshiimage1 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage2 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage3 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage4 setImage:[UIImage imageNamed:quanxing]];
                [_zhunshiimage5 setImage:[UIImage imageNamed:quanxing]];
                
            }else if ([str isEqualToString:@"质量"]){
                [_zhiliang1 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang2 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang3 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang4 setImage:[UIImage imageNamed:quanxing]];
                [_zhiliang5 setImage:[UIImage imageNamed:quanxing]];
                
            }else if ([str isEqualToString:@"技能"]){
                [_jineng1 setImage:[UIImage imageNamed:quanxing]];
                [_jineng2 setImage:[UIImage imageNamed:quanxing]];
                [_jineng3 setImage:[UIImage imageNamed:quanxing]];
                [_jineng4 setImage:[UIImage imageNamed:quanxing]];
                [_jineng5 setImage:[UIImage imageNamed:quanxing]];
                
            }else if ([str isEqualToString:@"效率"]){
                [_xiaolv1 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv2 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv3 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv4 setImage:[UIImage imageNamed:quanxing]];
                [_xiaolv5 setImage:[UIImage imageNamed:quanxing]];
                
            }
        }

    }
//        else if (douNumber <= 1.5 && douNumber > 1.0){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:banxing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//    }else if (douNumber <= 2.0 && douNumber > 1.5){
//        image.backgroundColor = [UIColor blueColor];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//    }else if (douNumber <= 2.5 && douNumber > 2.0){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:banxing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//    }else if (douNumber <= 3.0 && douNumber > 2.5){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//    }else if (douNumber <= 3.5 && douNumber > 3.0){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:banxing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//    }else if (douNumber <= 4.0 && douNumber > 3.5){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:meixing]];
//    }else if (douNumber <= 4.5 && douNumber > 4.0){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:banxing]];
//    }else if (douNumber == 5.0 && douNumber > 4.5){
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//        [image setImage:[UIImage imageNamed:quanxing]];
//    }
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
