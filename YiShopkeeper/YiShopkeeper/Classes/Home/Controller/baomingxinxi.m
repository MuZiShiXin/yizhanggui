//
//  baomingxinxi.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "baomingxinxi.h"
#import "AllXinXiTableViewCell.h"
#import "FuJinQiuZhiDeRenViewController.h"
#import "baomingxinxiModel.h"
#import "HomeModel.h"
#import "DaRenXiangQingViewController.h"
@interface baomingxinxi ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UITableView *mainTableView;
@property ( nonatomic ,strong) NSMutableArray *ModelDic;
@property (nonatomic, strong) HomeModel *mode;
@end

@implementation baomingxinxi

- (NSMutableArray *)ModelDic
{
    if (!_ModelDic ) {
        _ModelDic = [NSMutableArray array];
    }
    return _ModelDic;
}


- (UIView *)headView:(gongzuoxinxiModel *)ModelNmb
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self addSubview:_headView];
        UIImageView *imageView= [[UIImageView alloc]initWithFrame:CGRectMake(15, 16, 13, 13)];
        imageView.image = [UIImage imageNamed:@"yg_sygdbmdd_nr_tb1"];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]init];
        NSString *str = @"3";
        if ([str isEqualToString:@"1"]) {
            label.text = [NSString stringWithFormat:@"需要%ld人  已报",ModelNmb.recruitNum];
        }else if ([str isEqualToString:@"2"])
        {
            label.text = [NSString stringWithFormat:@"需要%ld人  已到达",ModelNmb.recruitNum];
        }else
        {
            label.text = [NSString stringWithFormat:@"需要%ld人  已报",ModelNmb.recruitNum];
        }
        
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
        CGFloat width = [UILabel getWidthWithTitle:label.text font:label.font];
        label.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+6.5, 16, width, 13);
        [self addSubview:label];
        
        UILabel *RegistrationNumberLabel = [[UILabel alloc]init];
        RegistrationNumberLabel.textColor = [UIColor redColor];
        RegistrationNumberLabel.font = [UIFont systemFontOfSize:13];
        RegistrationNumberLabel.text = [NSString stringWithFormat:@"%ld人",ModelNmb.appliedPeoNum];
        CGFloat width1 = [UILabel getWidthWithTitle:RegistrationNumberLabel.text font:RegistrationNumberLabel.font];
        RegistrationNumberLabel.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, 16, width1, 13);
        [self addSubview:RegistrationNumberLabel];
        
        
        if ([str isEqualToString:@"2"]||[str isEqualToString:@"3"]) {
            
            UILabel *remainingAndacceptance = [[UILabel alloc]init];
            remainingAndacceptance.textColor = [UIColor hx_colorWithHexRGBAString:@"666666"];
            remainingAndacceptance.font = [UIFont systemFontOfSize:13];
            if ([str isEqualToString:@"2"]) {
                remainingAndacceptance.text = @"已验收";
            }else
            {
                remainingAndacceptance.text = @"剩余";
            }
            
            CGFloat width2 = [UILabel getWidthWithTitle:remainingAndacceptance.text font:remainingAndacceptance.font];
            remainingAndacceptance.frame = CGRectMake(CGRectGetMaxX(RegistrationNumberLabel.frame)+10, 16, width2, 13);
            [self addSubview:remainingAndacceptance];
            
            UILabel *RenNumberLabel = [[UILabel alloc]init];
            RenNumberLabel.textColor = [UIColor redColor];
            RenNumberLabel.font = [UIFont systemFontOfSize:13];
            RenNumberLabel.text = [NSString stringWithFormat:@"%ld人",ModelNmb.lastPeoNum];
            CGFloat width3 = [UILabel getWidthWithTitle:RenNumberLabel.text font:RenNumberLabel.font];
            RenNumberLabel.frame = CGRectMake(CGRectGetMaxX(remainingAndacceptance.frame)+5, 16, width3, 13);
            [self addSubview:RenNumberLabel];
            
            
            if ([str isEqualToString:@"3"]) {
                UIButton *VicinityButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 75, 12.5, 60, 20)];
                VicinityButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:kBlueColor] CGColor];
                //设置边框宽度
                VicinityButton.layer.borderWidth = 0.50f;
                //给按钮设置角的弧度
                VicinityButton.layer.cornerRadius = 10.0f;
                //设置背景颜色
                VicinityButton.layer.masksToBounds = YES;
                VicinityButton.titleLabel.font = [UIFont systemFontOfSize:13];
                [VicinityButton setTitle:@"附近求职" forState:UIControlStateNormal];
                [VicinityButton setTitleColor:[UIColor hx_colorWithHexRGBAString:kBlueColor] forState:UIControlStateNormal];
                [VicinityButton addTarget:self action:@selector(VicinityBtn) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:VicinityButton];
            }
        }
        UIView * dixianView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 5)];
        dixianView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef2f5"];
        [self addSubview:dixianView];
        
    }
    return _headView;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kScreenWidth, kScreenHeight-44-48)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_mainTableView];
    }
    return _mainTableView;
}

- (instancetype)initWithFrame:(CGRect)frame GongZuoXinXi:(gongzuoxinxiModel *)Model
{
    if (self = [super initWithFrame:frame]) {
        self.Models = Model;
        [self httpRequest:Model];
        [self headView:Model];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark 网络请求
- (void)httpRequest:(gongzuoxinxiModel *)model;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shouye/baomingxinxi",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(model.recruitInfoId),@"gongDanId",@(1),@"pageNum",@(10),@"pageSize", nil];
    
    [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        
        if (result == 1) {
            NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"rows"];
            for (int i = 0; i < resultDic.count; i++) {
                self.mode = [HomeModel creatRankingTotalModelWith:resultDic[i]];
                [self.ModelDic addObject:self.mode];
            }
        }
        [self mainTableView];
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
    }];
}


#pragma mark 附近求职
- (void)VicinityBtn
{
    NSLog(@"附近求职");
    FuJinQiuZhiDeRenViewController *FuJinQiuZhiDeRenVC = [[FuJinQiuZhiDeRenViewController alloc]init];
    FuJinQiuZhiDeRenVC.Navi = self.Navi;
    FuJinQiuZhiDeRenVC.recruitNum = self.Models.recruitNum;
    FuJinQiuZhiDeRenVC.appliedPeoNum = self.Models.appliedPeoNum;
    FuJinQiuZhiDeRenVC.lastPeoNum = self.Models.lastPeoNum;
    [self.Navi pushViewController:FuJinQiuZhiDeRenVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:_ModelDic.count];
    return self.ModelDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //使用cell重用机制
    static NSString *cellIdentifier = @"cellIdentifier";//设置cell重用标示
    AllXinXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //根据标示去找cell，如果有现成的就用现成的
    if (!cell) {
        //没有现成的cell的时候：
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AllXinXiTableViewCell" owner:nil options:nil] firstObject];
    }
    [cell initSubViewsWithIndexPath:indexPath baomingxinxiModel:self.ModelDic[indexPath.row]nav:self.Navi];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //给cell设置内容 从之前设置的数据数组中拿数据
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 172;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里是cell的点击事件 点击了cell便触发这个函数
    NSLog(@"点击了cell");
    
    DaRenXiangQingViewController *DaRenXiangQingVC = [[DaRenXiangQingViewController alloc]init];
    DaRenXiangQingVC.homeModel = self.mode;
    [self.Navi pushViewController:DaRenXiangQingVC animated:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
