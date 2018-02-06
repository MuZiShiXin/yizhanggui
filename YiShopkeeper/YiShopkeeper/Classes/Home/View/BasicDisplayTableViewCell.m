//
//  BasicDisplayTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/22.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "BasicDisplayTableViewCell.h"
#import "PingjiaSViewController.h"
#import "TipAlertView.h"
@interface BasicDisplayTableViewCell ()
{
    NSArray *tagsArr;
}
@property (nonatomic ,strong)TipAlertView *alert;
@end

@implementation BasicDisplayTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 头像
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_headImageView];
        // 姓名
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nameLabel];
        // 年龄
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_ageLabel];
        // 性别
        _genderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_genderImageView];
        // 工龄
        _lengthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lengthLabel];
        // 标签
        for (int i = 0; i<5; i++) {
            if (i == 0) {
                _labellingView1 = [[UILabel alloc]init];
                _labellingView1.tag = 560 + 1;
                [self.contentView addSubview:_labellingView1];
            }else if (i == 1)
            {
                _labellingView2 = [[UILabel alloc]init];
                _labellingView2.tag = 560 + 1;
                [self.contentView addSubview:_labellingView2];
            }else if (i == 2)
            {
                _labellingView3 = [[UILabel alloc]init];
                _labellingView3.tag = 560 + 1;
                [self.contentView addSubview:_labellingView3];
            }else if (i == 3)
            {
                _labellingView4 = [[UILabel alloc]init];
                _labellingView4.tag = 560 + 1;
                [self.contentView addSubview:_labellingView4];
            }else if (i == 4)
            {
                _labellingView5 = [[UILabel alloc]init];
                _labellingView5.tag = 560 + 1;
                [self.contentView addSubview:_labellingView5];
            }
            
        }

        // 收藏
        _collectButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_collectButton];
        // 收藏图片
        _collectImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_collectButton addSubview:_collectImageView];
        //收藏文字
        _collectLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_collectButton addSubview:_collectLabel];
        // 线
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineView];
        // 简介
        _profileLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_profileLabel];
        // 线
        _lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineView1];
        // 移除
        _removeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_removeButton];
        // 确定
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_confirmButton];
        // 线
        _lineView2 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineView2];
        
    }
    return self;
}


-(void)dealloc
{
    // 头像
    self.headImageView = nil;
    // 姓名
    self.nameLabel = nil;
    // 年龄
    self.ageLabel = nil;
    // 性别
    self.genderImageView = nil;
    // 工龄
    self.lengthLabel = nil;
    // 标签
    self.labellingView1 = nil;
    self.labellingView2 = nil;
    self.labellingView3 = nil;
    self.labellingView4 = nil;
    self.labellingView5 = nil;
    
    // 收藏
    self.collectButton = nil;
    //收藏图片
    self.collectImageView = nil;
    //收藏文字
    self.collectLabel = nil;
    // 线
    self.lineView = nil;
    // 简介
    self.profileLabel = nil;
    // 线
    self.lineView1 = nil;
    // 移除
    self.removeButton = nil;
    // 确定
    self.confirmButton = nil;
    // 线
    self.lineView2 = nil;
    
    
}
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath Model:(HomeModel *)dic
{
    self.HomeIndexPahh = indexPath;
    self.Homemodel = dic;
    
    _headImageView.frame = CGRectMake(15, 10, 79, 79);
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:dic.touXiang] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    
    [_nameLabel setText:dic.xingMing];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    CGFloat width = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+10, 16, width, 20);
    
    _ageLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame), 20, 40, 15);
    _ageLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld岁",(long)dic.nianLing]];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"岁"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"999999"] range:range1];
    _ageLabel.attributedText = hintString;
    
    _genderImageView.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, CGRectGetMaxY(_nameLabel.frame)+11, 16, 15);
    if ([dic.xingBie isEqualToString:@"男"]) {
        _genderImageView.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }else
    {
        _genderImageView.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }
    
    
    _lengthLabel.text = [NSString stringWithFormat:@"工龄 %ld 年",(long)dic.gongLing];
    _lengthLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
    _lengthLabel.backgroundColor = [UIColor clearColor];
    _lengthLabel.font = [UIFont systemFontOfSize:18];
    CGFloat width1 = [UILabel getWidthWithTitle:_lengthLabel.text font:_lengthLabel.font];
    _lengthLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, 16, width1, 20);
    _lengthLabel.frame = CGRectMake(CGRectGetMaxX(_genderImageView.frame)+7, _genderImageView.frame.origin.y, width1, 15);
    
    
    _collectButton.frame = CGRectMake(kScreenWidth-70, 21, 55, 20);
    //设置边框颜色
    _collectButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _collectButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _collectButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _collectButton.layer.masksToBounds = YES;
    
    [_collectButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    _collectImageView.frame = CGRectMake(5, (20-11)/2, 13, 11);
    _collectImageView.image = [UIImage imageNamed:@"yg_sy_nr_tb3"];
    _collectLabel.frame = CGRectMake(CGRectGetMaxX(_collectImageView.frame)+4, 2.5, _collectButton.mj_w-4-5-13, 15);
    _collectLabel.text = @"收藏";
    _collectLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
    _collectLabel.font = [UIFont systemFontOfSize:13];
    
    if (dic.shouCang == 1) {
        [_collectImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _collectLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _collectButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    }else
    {
        [_collectImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _collectLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _collectButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    
    
    
    
    
    
    
    

//    NSArray * ary = @[@"1",@"2",@"3",@"4",@"5"];
    if (dic.gongZhongs != nil) {
        if (dic.gongZhongs.count >= 1 && dic.gongZhongs.count > 0) {
            
            _labellingView1.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
            //设置边框宽度
            _labellingView1.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView1.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView1.layer.masksToBounds = YES;
            _labellingView1.font = [UIFont systemFontOfSize:10];
            _labellingView1.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
            [_labellingView1 setText:dic.gongZhongs[0]];
            _labellingView1.textAlignment = 1;
            CGFloat labellingwidth1 = [UILabel getWidthWithTitle:_labellingView1.text font:_labellingView1.font];
            _labellingView1.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, CGRectGetMaxY(_lengthLabel.frame)+9.5, labellingwidth1+10, 15);
        }else
        {
            [_labellingView1 removeFromSuperview];
        }
        
        if (dic.gongZhongs.count >= 2 && dic.gongZhongs.count > 1) {
            _labellingView2.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _labellingView2.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView2.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView2.layer.masksToBounds = YES;
            _labellingView2.font = [UIFont systemFontOfSize:10];
            _labellingView2.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_labellingView2 setText:dic.gongZhongs[1]];
            _labellingView2.textAlignment = 1;
            CGFloat labellingwidth2 = [UILabel getWidthWithTitle:_labellingView2.text font:_labellingView2.font];
            _labellingView2.frame = CGRectMake(CGRectGetMaxX(_labellingView1.frame)+5, CGRectGetMaxY(_lengthLabel.frame)+9.5, labellingwidth2+10, 15);
        }else
        {
            [_labellingView2 removeFromSuperview];
        }
        
        if (dic.gongZhongs.count >= 3 && dic.gongZhongs.count > 2) {
            _labellingView3.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _labellingView3.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView3.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView3.layer.masksToBounds = YES;
            _labellingView3.font = [UIFont systemFontOfSize:10];
            _labellingView3.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_labellingView3 setText:dic.gongZhongs[2]];
            _labellingView3.textAlignment = 1;
            CGFloat labellingwidth3 = [UILabel getWidthWithTitle:_labellingView3.text font:_labellingView3.font];
            _labellingView3.frame = CGRectMake(CGRectGetMaxX(_labellingView2.frame)+5, CGRectGetMaxY(_lengthLabel.frame)+9.5, labellingwidth3+10, 15);
        }else
        {
            [_labellingView3 removeFromSuperview];
        }
        
        if (dic.gongZhongs.count >= 4 && dic.gongZhongs.count > 3) {
            _labellingView4.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
            //设置边框宽度
            _labellingView4.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView4.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView4.layer.masksToBounds = YES;
            _labellingView4.font = [UIFont systemFontOfSize:10];
            _labellingView4.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
            [_labellingView4 setText:dic.gongZhongs[3]];
            _labellingView4.textAlignment = 1;
            CGFloat labellingwidth4 = [UILabel getWidthWithTitle:_labellingView4.text font:_labellingView4.font];
            _labellingView4.frame = CGRectMake(CGRectGetMaxX(_labellingView3.frame)+5, CGRectGetMaxY(_lengthLabel.frame)+9.5, labellingwidth4+10, 15);
        }else
        {
            [_labellingView4 removeFromSuperview];
        }
        
        if (dic.gongZhongs.count <= 5 && dic.gongZhongs.count >4) {
            _labellingView5.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _labellingView5.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView5.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView5.layer.masksToBounds = YES;
            _labellingView5.font = [UIFont systemFontOfSize:10];
            _labellingView5.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_labellingView5 setText:dic.gongZhongs[4]];
            _labellingView5.textAlignment = 1;
            CGFloat labellingwidth5 = [UILabel getWidthWithTitle:_labellingView5.text font:_labellingView5.font];
            _labellingView5.frame = CGRectMake(CGRectGetMaxX(_labellingView4.frame)+5, CGRectGetMaxY(_lengthLabel.frame)+9.5, labellingwidth5+10, 15);
        }else
        {
            [_labellingView5 removeFromSuperview];
        }

    }
    if (self.resultNmb == 2) {
        _lineView2.frame = CGRectMake(0, CGRectGetMaxY(self.headImageView.frame)+10, kScreenWidth, 5);
        _lineView2.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
        
        // 线
        self.lineView.hidden = YES;
        // 简介
        self.profileLabel.hidden = YES;
        // 线
        self.lineView1.hidden = YES;
        // 移除
        self.removeButton.hidden = YES;
        // 确定
        self.confirmButton.hidden = YES;
        
        
    }else
    {
        // 线
        self.lineView.hidden = NO;
        // 简介
        self.profileLabel.hidden = NO;
        // 线
        self.lineView1.hidden = NO;
        // 移除
        self.removeButton.hidden = NO;
        // 确定
        self.confirmButton.hidden = NO;
        if (dic.neiRong.length != 0) {
            _lineView.frame = CGRectMake(15, CGRectGetMaxY(_headImageView.frame)+10, kScreenWidth-15, 1);
            _lineView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
            
            [_profileLabel setText:dic.neiRong];
            _profileLabel.frame = CGRectMake(15, CGRectGetMaxY(_lineView.frame)+ 10.5, kScreenWidth-30, 33);
            _profileLabel.font = [UIFont systemFontOfSize:12];
            _profileLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
            
            
            
            _lineView1.frame = CGRectMake(15, CGRectGetMaxY(_profileLabel.frame)+14.5, kScreenWidth-15, 1);
            _lineView1.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
        }else
        {
            _lineView1.frame = CGRectMake(15, CGRectGetMaxY(_headImageView.frame)+10, kScreenWidth-15, 1);
            _lineView1.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
        }
        
        
        _removeButton.frame = CGRectMake(kScreenWidth-190, CGRectGetMaxY(_lineView1.frame)+10, 80, 27);
        
        switch (dic.dingDanZhuangTai) {
            case 1:
            {
                _removeButton.hidden = NO;
                [_removeButton setTitle:@"移除" forState:UIControlStateNormal];
            }
                break;
                
            case 2:
            {
                _removeButton.hidden = NO;
                [_removeButton setTitle:@"未到达" forState:UIControlStateNormal];
            }
                break;
                
            case 13:
            {
                _removeButton.hidden = NO;
                [_removeButton setTitle:@"未到达" forState:UIControlStateNormal];
            }
                break;
            case 4:
            {
                //            [_removeButton removeFromSuperview];
                _removeButton.hidden = YES;
            }
                break;
                
            case 6:
            {
                //            [_removeButton removeFromSuperview];
                _removeButton.hidden = YES;
            }
                break;
            default:
                break;
        }
        [_removeButton setTitleColor:[UIColor hx_colorWithHexRGBAString:@"999999"] forState:UIControlStateNormal];
        //设置边框颜色
        _removeButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
        //设置边框宽度
        _removeButton.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _removeButton.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _removeButton.layer.masksToBounds = YES;
        _removeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_removeButton addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _confirmButton.frame = CGRectMake(kScreenWidth-95, CGRectGetMaxY(_lineView1.frame)+10, 80, 27);
        switch (dic.dingDanZhuangTai) {
            case 1:
            {
                [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
            }
                break;
                
            case 2:
            {
                [_confirmButton setTitle:@"确认到达" forState:UIControlStateNormal];
            }
                break;
                
            case 13:
            {
                [_confirmButton setTitle:@"确认到达" forState:UIControlStateNormal];
            }
                break;
            case 4:
            {
                [_confirmButton setTitle:@"验收" forState:UIControlStateNormal];
            }
                break;
            case 6:
            {
                [_confirmButton setTitle:@"评价" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
        //    //设置边框宽度
        //    _confirmButton.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _confirmButton.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        if (dic.neiRong.length != 0) {
            _lineView2.frame = CGRectMake(0, 212-5, kScreenWidth, 5);
            _lineView2.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
        }else
        {
            _lineView2.frame = CGRectMake(0, 212-58-5, kScreenWidth, 5);
            _lineView2.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
        }
    }
   
    
    
    
}
#pragma mark 收藏
- (void)collect
{
    
    if ([_collectImageView.image isEqual:[UIImage imageNamed:@"yg_sy_nr_tb3"]]) {
        NSLog(@"收藏");
        [_collectImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _collectLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _collectButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
        
    }else {
        NSLog(@"取消收藏");
        [_collectImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _collectLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _collectButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shoucang",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"zhangGuiId",@(self.Homemodel.daRenId),@"daRenId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
//        NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"rows"];
        if (result == 1) {
            NSLog(@"收藏成功");
            if (self.Homemodel.shouCang == 0) {
                self.Homemodel.shouCang = 1;
                [self showRightWithTitle:@"收藏成功" autoCloseTime:2];

            }else
            {
                self.Homemodel.shouCang = 0;
                [self showRightWithTitle:@"取消收藏成功" autoCloseTime:2];

            }
        }else
        {
            NSLog(@"收藏失败");
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
    
    
    
}
#pragma mark 移除
- (void)remove :(UIButton *)btn
{
    NSLog(@"移除");
    NSInteger orderState = 0;
    NSString *str = @"";
    if ([btn.titleLabel.text isEqualToString:@"移除"]) {
        orderState = 9;
        str = @"是否移除达人报名";
    }else if([btn.titleLabel.text isEqualToString:@"未到达"])
    {
        str = @"达人未到达";
        orderState = 12;
    }
    
    if (orderState != 0) {
        __weak typeof(self) weakSelf = self;
        self.alert = [[TipAlertView alloc] initWithMessage:str
                                                     image:[UIImage imageNamed:@"11"]
                                              buttonTitles:@[@"取消",@"确认"]];
        
        self.alert.AcceptBlock = ^(){
            NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(weakSelf.Homemodel.dingDanId),@"myOrderId",@(orderState),@"orderState",@(weakSelf.Homemodel.gongDanId),@"recruitInfoId", nil];
            
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                if (result == 1) {
                    NSLog(@"成功");
                    if (orderState == 9) {
                        [weakSelf showRightWithTitle:@"移除成功" autoCloseTime:2];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeViewControllersNotification" object:nil];
                    }else if(orderState == 12)
                    {
                        [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeViewControllersNotification" object:nil];
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
}

#pragma mark 确定
- (void)confirm:(UIButton *)btn
{
    NSLog(@"确定%@",btn.titleLabel.text);
    NSInteger orderState = 0;
    NSString *str = @"";

    if ([btn.titleLabel.text isEqualToString:@"确定"]) {
        str = @"确认达人报名";
        orderState = 2;
    }else if([btn.titleLabel.text isEqualToString:@"确认到达"])
    {
        str = @"确认达人已到达";
        orderState = 3;
    }else if ([btn.titleLabel.text isEqualToString:@"验收"])
    {
        str = @"确认验收";
        orderState = 6;
    }
    if ([str isEqualToString:@""]) {
        str = @"对达人评价";
    }
        __weak typeof(self) weakSelf = self;
        self.alert = [[TipAlertView alloc] initWithMessage:str
                                                     image:[UIImage imageNamed:@"11"]
                                              buttonTitles:@[@"取消",@"确定"]];
        
        self.alert.AcceptBlock = ^(){
            
            NSLog(@"确认",nil);
            
            if ([btn.titleLabel.text isEqualToString:@"评价"]) {
                PingjiaSViewController *PingjiaSVC = [[PingjiaSViewController alloc]init];
                PingjiaSVC.homeModel = weakSelf.Homemodel;
                PingjiaSVC.gongDanId = weakSelf.Homemodel.gongDanId;
                PingjiaSVC.dingDanId = weakSelf.Homemodel.dingDanId;
                PingjiaSVC.daRenID = weakSelf.Homemodel.daRenId;
                [weakSelf.Navi pushViewController:PingjiaSVC animated:YES];
            }else
            {
                NSString *urlStr = [NSString stringWithFormat:@"%@/Expert/MyOrder/changeTheOrderState",kPRTURL];
                
                NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(weakSelf.Homemodel.dingDanId),@"myOrderId",@(orderState),@"orderState",@(weakSelf.Homemodel.gongDanId),@"recruitInfoId", nil];
                
                [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                    NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                    ;
                    NSString *str = [responseObj valueForKey:@"message"];
                    if (result == 1) {
                        NSLog(@"成功");
                        if (orderState == 6) {
                            [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                           [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeViewControllersNotification" object:nil];
                        }else if (orderState == 2)
                        {
                            [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeViewControllersNotification" object:nil];
                            
                            
                        }else if (orderState == 3)
                        {
                            [weakSelf showRightWithTitle:@"提交成功" autoCloseTime:2];
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeViewControllersNotification" object:nil];
                        }
                    }else if (result == 2)
                    {
                        [weakSelf showInfoWithTitle:@"请勿重复提交" autoCloseTime:2];
                    }else
                    {
                         [weakSelf showErrorWithTitle:str autoCloseTime:2];
                    }
                } failure:^(NSError * _Nullable error) {
                    NSLog(@"loginError:%@",error);
                    
                }];
            }
        };
        self.alert.RefuseBlock = ^(){
            
            
        };
        [self.alert show];
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
