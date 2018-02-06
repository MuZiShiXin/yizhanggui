//
//  MyCollectionTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyCollectionTableViewCell.h"
#import "ZYInputAlertView.h"
@interface MyCollectionTableViewCell ()
{
    NSArray *tagsArr;
}
@property (nonatomic ,strong)SCModel *scModel;
@end

@implementation MyCollectionTableViewCell

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
    self.labellingView = nil;
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
- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath dataDic:(SCModel *)Model
{
    self.scModel = Model;
    _headImageView.frame = CGRectMake(15, 10, 79, 79);
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:Model.touXiang]placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@", Model.xingMing];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    CGFloat width = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, 16, width, 20);
    
    _ageLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+7, 20, 40, 15);
    _ageLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld岁",Model.nianLing]];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"岁"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor hx_colorWithHexRGBAString:@"999999"] range:range1];
    _ageLabel.attributedText = hintString;
    
    _genderImageView.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, CGRectGetMaxY(_nameLabel.frame)+11, 16, 15);
    if ([Model.xingBie isEqualToString:@"女"]) {
        _genderImageView.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }else
    {
        _genderImageView.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }
    
    
    _lengthLabel.text = [NSString stringWithFormat:@"工龄 %ld 年",Model.gongLing];
    _lengthLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
    _lengthLabel.backgroundColor = [UIColor clearColor];
    _lengthLabel.font = [UIFont systemFontOfSize:18];
    CGFloat width1 = [UILabel getWidthWithTitle:_lengthLabel.text font:_lengthLabel.font];
    _lengthLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, 16, width1, 20);
    _lengthLabel.frame = CGRectMake(CGRectGetMaxX(_genderImageView.frame)+7, _genderImageView.frame.origin.y, width1, 15);
    
    
    
    [_labellingView removeFromSuperview];
    _labellingView = [[MyCollectionView alloc]initWithFrame:CGRectMake(kScreenWidth-75-11-30, 67, kScreenWidth-100,15) dataArr:Model.gongZhongs];
    [self.contentView addSubview:_labellingView];
    
    
    _collectButton.frame = CGRectMake(kScreenWidth-70, 21, 55, 20);
    //设置边框颜色
    _collectButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    //设置边框宽度
    _collectButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _collectButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _collectButton.layer.masksToBounds = YES;
    
    [_collectButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    
    _collectImageView.frame = CGRectMake(5, (20-11)/2, 13, 11);
    _collectImageView.image = [UIImage imageNamed:@"yg_sy_nr_tb4"];
    _collectLabel.frame = CGRectMake(CGRectGetMaxX(_collectImageView.frame)+4, 2.5, _collectButton.mj_w-4-5-13, 15);
    _collectLabel.text = @"收藏";
    _collectLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
    _collectLabel.font = [UIFont systemFontOfSize:13];

    _labellingView.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame)+11, CGRectGetMaxY(_lengthLabel.frame)+9.5, kScreenWidth - CGRectGetMaxX(_headImageView.frame)-11-15, 15);
    
    if (Model.neiRong.length == 0) {
        _confirmButton.frame = CGRectMake(kScreenWidth-95, CGRectGetMaxY(_headImageView.frame)+10, 80, 27);
        [_confirmButton setTitle:@"留言" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
        //    //设置边框宽度
        //    _confirmButton.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _confirmButton.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        _lineView2.frame = CGRectMake(0, 212-5, kScreenWidth, 5);
        _lineView2.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
    }else
    {
        _lineView.frame = CGRectMake(15, CGRectGetMaxY(_headImageView.frame)+10, kScreenWidth-15, 1);
        _lineView.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
        
        _profileLabel.text = Model.neiRong;
        _profileLabel.frame = CGRectMake(15, CGRectGetMaxY(_lineView.frame)+ 10.5, kScreenWidth-30, 33);
        _profileLabel.font = [UIFont systemFontOfSize:12];
        _profileLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        
        
        
        _lineView1.frame = CGRectMake(15, CGRectGetMaxY(_profileLabel.frame)+14.5, kScreenWidth-15, 1);
        _lineView1.backgroundColor = [UIColor hx_colorWithHexRGBAString:kBeijingColor];
        
        _confirmButton.frame = CGRectMake(kScreenWidth-95, CGRectGetMaxY(_lineView1.frame)+10, 80, 27);
        [_confirmButton setTitle:@"留言" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"27b8f3"];
        //    //设置边框宽度
        //    _confirmButton.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _confirmButton.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        _lineView2.frame = CGRectMake(0, 212-5, kScreenWidth, 5);
        _lineView2.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef1f6"];
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
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.scModel.zhangGuiId),@"zhangGuiId",@(self.scModel.daRenId),@"daRenId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
        NSInteger resultDic = [[responseObj objectForKeyWithNullDetection:@"result"] integerValue];
        if (result == 1) {
            NSLog(@"收藏成功");
            if (resultDic == 0) {
//                resultDic = 1;
                [self showRightWithTitle:@"收藏成功" autoCloseTime:2];
                
            }else
            {
//                resultDic = 0;
                [self showRightWithTitle:@"取消收藏成功" autoCloseTime:2];
                if (_block != nil) {
                    _block(@"刷新");
                }
                
            }
        }else
        {
            NSLog(@"收藏失败");
        }
    } failure:^(NSError * _Nullable error) {
        NSLog(@"loginError:%@",error);
        
    }];
    
}
//#pragma mark 移除
//- (void)remove
//{
//    NSLog(@"移除");
//}

#pragma mark 留言
- (void)confirm
{
    NSLog(@"留言");
    __weak typeof(self) weakSelf = self;
    
    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
    alertView.placeholder = @"输入想要对他说的话···";
    [alertView confirmBtnClickBlock:^(NSString *inputString) {
//        weakSelf.inputLabel.text = inputString;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/liuyan",kPRTURL];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.scModel.zhangGuiId),@"liuYanRenId",@(self.scModel.daRenId),@"beiLiuYanRenId",inputString,@"liuYan", nil];
        [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
            NSInteger result = [[responseObj objectForKeyWithNullDetection:@"result"] intValue];
            if (result == 1) {
                [weakSelf showRightWithTitle:@"留言成功" autoCloseTime:2];
            }else
            {
                [weakSelf showErrorWithTitle:@"留言失败" autoCloseTime:2];
            }
        } failure:^(NSError * _Nullable error) {
            NSLog(@"loginError:%@",error);
            
        }];
        
        
    }];
    [alertView show];
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
