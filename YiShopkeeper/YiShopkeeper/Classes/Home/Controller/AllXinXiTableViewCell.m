//
//  AllXinXiTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/6.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "AllXinXiTableViewCell.h"
#import "PleaseMessageViewController.h"

@implementation AllXinXiTableViewCell


- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath baomingxinxiModel:(baomingxinxiModel *)maodel nav:(UINavigationController *)Navi
{
    self.model = maodel;
    self.Navi = Navi;
    [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:maodel.touXiang] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_biaotiLabel setText:maodel.xingMing];
    [_nianlingLabel setText:[NSString stringWithFormat:@"%ld",maodel.nianLing]];
    if ([maodel.xingBie isEqualToString:@"男"]) {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }else
    {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }
    [_gonglingLabel setText:[NSString stringWithFormat:@"%ld 年",maodel.gongLing]];
    _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _shoucangButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _shoucangButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _shoucangButton.layer.masksToBounds = YES;
    
    if (maodel.shouCang == 1) {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    }else
    {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    
    if (maodel.gongZhongs != nil) {
        if (maodel.gongZhongs.count >= 1 && maodel.gongZhongs.count > 0) {
            
            _labellingView1.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
            //设置边框宽度
            _labellingView1.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView1.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView1.layer.masksToBounds = YES;
            _labellingView1.font = [UIFont systemFontOfSize:10];
            _labellingView1.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
            [_labellingView1 setText:maodel.gongZhongs[0]];
            _labellingView1.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth1 = [UILabel getWidthWithTitle:_labellingView1.text font:_labellingView1.font];
            _labellingView1.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+11, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth1+10, 15);
            _labelwidth1.constant = labellingwidth1+10;

        }else
        {
            [_labellingView1 removeFromSuperview];
        }
        
        if (maodel.gongZhongs.count >= 2 && maodel.gongZhongs.count > 1) {
            _labellingView2.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _labellingView2.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView2.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView2.layer.masksToBounds = YES;
            _labellingView2.font = [UIFont systemFontOfSize:10];
            _labellingView2.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_labellingView2 setText:maodel.gongZhongs[1]];
            _labellingView2.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth2 = [UILabel getWidthWithTitle:_labellingView2.text font:_labellingView2.font];
            _labellingView2.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth2+10, 15);
            _labelwidth2.constant = labellingwidth2+10;

        }else
        {
            [_labellingView2 removeFromSuperview];
        }
        
        if (maodel.gongZhongs.count >= 3 && maodel.gongZhongs.count > 2) {
            _labellingView3.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _labellingView3.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView3.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView3.layer.masksToBounds = YES;
            _labellingView3.font = [UIFont systemFontOfSize:10];
            _labellingView3.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_labellingView3 setText:maodel.gongZhongs[2]];
            _labellingView3.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth3 = [UILabel getWidthWithTitle:_labellingView3.text font:_labellingView3.font];
            _labellingView3.frame = CGRectMake(CGRectGetMaxX(_labellingView2.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth3+10, 15);
            _labelwidth3.constant = labellingwidth3+10;

        }else
        {
            [_labellingView3 removeFromSuperview];
        }
        
        if (maodel.gongZhongs.count >= 4 && maodel.gongZhongs.count > 3) {
            _labellingView4.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
            //设置边框宽度
            _labellingView4.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView4.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView4.layer.masksToBounds = YES;
            _labellingView4.font = [UIFont systemFontOfSize:10];
            _labellingView4.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
            [_labellingView4 setText:maodel.gongZhongs[3]];
            _labellingView4.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth4 = [UILabel getWidthWithTitle:_labellingView4.text font:_labellingView4.font];
            _labellingView4.frame = CGRectMake(CGRectGetMaxX(_labellingView3.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth4+10, 15);
            _labelwidth4.constant = labellingwidth4+10;

        }else
        {
            [_labellingView4 removeFromSuperview];
        }
        
        if (maodel.gongZhongs.count <= 5 && maodel.gongZhongs.count >4) {
            _labellingView5.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _labellingView5.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _labellingView5.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _labellingView5.layer.masksToBounds = YES;
            _labellingView5.font = [UIFont systemFontOfSize:10];
            _labellingView5.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_labellingView5 setText:maodel.gongZhongs[4]];
            _labellingView5.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth5 = [UILabel getWidthWithTitle:_labellingView5.text font:_labellingView5.font];
            _labellingView5.frame = CGRectMake(CGRectGetMaxX(_labellingView4.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth5+10, 15);
            _labelwidth5.constant = labellingwidth5+10;

        }else
        {
            [_labellingView5 removeFromSuperview];
        }
        
    }
    [_jianjieLabel setText:maodel.neiRong];
    [_juliLabel setText:[NSString stringWithFormat:@"%@km",@"12"]];
    
    [_oneButtons removeAllSubviews];
    [_twoButtons removeAllSubviews];
    if (maodel.dingDanZhuangTai == 1 || maodel.dingDanZhuangTai == 3 ||maodel.dingDanZhuangTai == 4 ) {
        _oneButtons.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
        //设置边框宽度
        _oneButtons.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _oneButtons.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _oneButtons.layer.masksToBounds = YES;
        
        _twoButtons.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
        //给按钮设置角的弧度
        _twoButtons.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _twoButtons.layer.masksToBounds = YES;
        
        if (maodel.dingDanZhuangTai == 3) {
            [_juliLabel removeFromSuperview];
            [_juliImageView removeFromSuperview];
            [_oneButtons setTitle:@"已经到达" forState:UIControlStateNormal];
            [_twoButtons setTitle:@"准时到达" forState:UIControlStateNormal];
        }else if(maodel.dingDanZhuangTai == 4)
        {
            [_juliLabel removeFromSuperview];
            [_juliImageView removeFromSuperview];
            [_oneButtons removeFromSuperview];
            [_twoButtons setTitle:@"验收" forState:UIControlStateNormal];
        }else if(maodel.dingDanZhuangTai == 1)
        {
            [_juliLabel removeFromSuperview];
            [_juliImageView removeFromSuperview];
            [_oneButtons setTitle:@"移出" forState:UIControlStateNormal];
            [_twoButtons setTitle:@"确定" forState:UIControlStateNormal];
        }else
        {
            [_oneButtons setTitle:@"邀请" forState:UIControlStateNormal];
            [_twoButtons setTitle:@"留言" forState:UIControlStateNormal];
        }
    }
}

- (void)dealloc
{
    self.shoucangLabel = nil;
    self.shoucangImageView = nil;
    self.shoucangButton = nil;
    self.touxiangImageView = nil;
    self.nianlingLabel = nil;
    self.biaotiLabel = nil;
    self.xingbieImageVIew = nil;
    self.gonglingLabel = nil;
    self.labellingView1 = nil;
    self.labellingView2 = nil;
    self.labellingView3 = nil;
    self.labellingView4 = nil;
    self.labellingView5 = nil;
    self.jianjieLabel = nil;
    self.oneButtons = nil;
    self.twoButtons = nil;
    self.juliImageView = nil;
    self.juliLabel = nil;
}

#pragma mark 收藏
- (IBAction)shoucangBtns {
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
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.model.zhangGuiId),@"zhangGuiId",@(self.model.daRenId),@"daRenId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        if (result == 1) {
            NSLog(@"收藏成功");
            if (self.model.shouCang == 0) {
                self.model.shouCang = 1;
                [self showRightWithTitle:@"收藏成功" autoCloseTime:2];
                
            }else
            {
                self.model.shouCang = 0;
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
#pragma mark 第一个按钮
- (IBAction)oneButton {
    NSLog(@"点击了%@",_oneButtons.titleLabel.text);
}
#pragma mark 第二个按钮
- (IBAction)TwoButton {
    NSLog(@"点击了%@",_twoButtons.titleLabel.text);
    PleaseMessageViewController *PleaseMessageVC = [[PleaseMessageViewController alloc]init];
    
    [self.Navi pushViewController:PleaseMessageVC animated:YES];
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
