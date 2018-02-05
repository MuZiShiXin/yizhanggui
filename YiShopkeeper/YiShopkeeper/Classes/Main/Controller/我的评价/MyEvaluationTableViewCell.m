//
//  MyEvaluationTableViewCell.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyEvaluationTableViewCell.h"
@interface MyEvaluationTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *touxiangImageView;

@property (strong, nonatomic) IBOutlet UILabel *shoucangLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shoucangImageView;
@property (strong, nonatomic) IBOutlet UIButton *shoucangButton;
@property (strong, nonatomic) IBOutlet UILabel *biaotiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *xingbieImageVIew;
@property (strong, nonatomic) IBOutlet UILabel *gonglingLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel1;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel2;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel3;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel4;
@property (strong, nonatomic) IBOutlet UILabel *zhiweiLabel5;




@property (strong, nonatomic) IBOutlet UIImageView *xingxingImageView1;
@property (strong, nonatomic) IBOutlet UIImageView *xingxingImageView2;
@property (strong, nonatomic) IBOutlet UIImageView *xingxingImageView3;
@property (strong, nonatomic) IBOutlet UIImageView *xingxingImageView4;
@property (strong, nonatomic) IBOutlet UIImageView *xingxingImageView5;
@property (strong, nonatomic) IBOutlet UIImageView *zhankaiImageView;
@property (strong, nonatomic) IBOutlet UILabel *wodepingjiaLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ZhiWeiWidth1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ZhiWeiWidth2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ZhiWeiWidth3;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ZhiWeiWidth4;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ZhiWeiWidth5;


@end

@implementation MyEvaluationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath DDPJdic:(DDPJModel *)Model
{
    _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _shoucangButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _shoucangButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _shoucangButton.layer.masksToBounds = YES;
    
//    [_duiwodepingjiaView removeFromSuperview];
    
    [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:Model.touXiang] placeholderImage:[UIImage imageNamed:@"yg_sy_nr_tp1"]];
    [_biaotiLabel setText:Model.xingMing];
    if ([Model.xingBie isEqualToString:@"男"]) {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }else
    {
        _xingbieImageVIew.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }
    [_gonglingLabel setText:[NSString stringWithFormat:@"%ld 岁",Model.nianLing]];
    if (Model.shouCang == 1) {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    }else
    {
        [_shoucangImageView setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    if (Model.gongZhongs != nil) {
        if (Model.gongZhongs.count >= 1 && Model.gongZhongs.count > 0) {
            
            _zhiweiLabel1.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
            //设置边框宽度
            _zhiweiLabel1.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _zhiweiLabel1.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _zhiweiLabel1.layer.masksToBounds = YES;
            _zhiweiLabel1.font = [UIFont systemFontOfSize:10];
            _zhiweiLabel1.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
            [_zhiweiLabel1 setText:Model.gongZhongs[0]];
            _zhiweiLabel1.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth1 = [UILabel getWidthWithTitle:_zhiweiLabel1.text font:_zhiweiLabel1.font];
            _zhiweiLabel1.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+11, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth1+10, 15);
            self.ZhiWeiWidth1.constant = labellingwidth1+10;
            
            
        }else
        {
            [_zhiweiLabel1 removeFromSuperview];
        }
        
        if (Model.gongZhongs.count >= 2 && Model.gongZhongs.count > 1) {
            _zhiweiLabel2.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _zhiweiLabel2.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _zhiweiLabel2.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _zhiweiLabel2.layer.masksToBounds = YES;
            _zhiweiLabel2.font = [UIFont systemFontOfSize:10];
            _zhiweiLabel2.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_zhiweiLabel2 setText:Model.gongZhongs[1]];
            _zhiweiLabel2.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth2 = [UILabel getWidthWithTitle:_zhiweiLabel2.text font:_zhiweiLabel2.font];
            _zhiweiLabel2.frame = CGRectMake(CGRectGetMaxX(_touxiangImageView.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth2+10, 15);
            self.ZhiWeiWidth2.constant = labellingwidth2+10;

        }else
        {
            [_zhiweiLabel2 removeFromSuperview];
        }
        
        if (Model.gongZhongs.count >= 3 && Model.gongZhongs.count > 2) {
            _zhiweiLabel3.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _zhiweiLabel3.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _zhiweiLabel3.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _zhiweiLabel3.layer.masksToBounds = YES;
            _zhiweiLabel3.font = [UIFont systemFontOfSize:10];
            _zhiweiLabel3.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_zhiweiLabel3 setText:Model.gongZhongs[2]];
            _zhiweiLabel3.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth3 = [UILabel getWidthWithTitle:_zhiweiLabel3.text font:_zhiweiLabel3.font];
            _zhiweiLabel3.frame = CGRectMake(CGRectGetMaxX(_zhiweiLabel3.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth3+10, 15);
            self.ZhiWeiWidth3.constant = labellingwidth3+10;

        }else
        {
            [_zhiweiLabel3 removeFromSuperview];
        }
        
        if (Model.gongZhongs.count >= 4 && Model.gongZhongs.count > 3) {
            _zhiweiLabel4.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
            //设置边框宽度
            _zhiweiLabel4.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _zhiweiLabel4.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _zhiweiLabel4.layer.masksToBounds = YES;
            _zhiweiLabel4.font = [UIFont systemFontOfSize:10];
            _zhiweiLabel4.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
            [_zhiweiLabel4 setText:Model.gongZhongs[3]];
            _zhiweiLabel4.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth4 = [UILabel getWidthWithTitle:_zhiweiLabel4.text font:_zhiweiLabel4.font];
            _zhiweiLabel4.frame = CGRectMake(CGRectGetMaxX(_zhiweiLabel4.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth4+10, 15);
            self.ZhiWeiWidth4.constant = labellingwidth4+10;

        }else
        {
            [_zhiweiLabel4 removeFromSuperview];
        }
        
        if (Model.gongZhongs.count <= 5 && Model.gongZhongs.count >4) {
            _zhiweiLabel5.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
            //设置边框宽度
            _zhiweiLabel5.layer.borderWidth = 0.50f;
            //给按钮设置角的弧度
            _zhiweiLabel5.layer.cornerRadius = 4.0f;
            //设置背景颜色
            _zhiweiLabel5.layer.masksToBounds = YES;
            _zhiweiLabel5.font = [UIFont systemFontOfSize:10];
            _zhiweiLabel5.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
            [_zhiweiLabel5 setText:Model.gongZhongs[4]];
            _zhiweiLabel5.textAlignment = NSTextAlignmentCenter;
            CGFloat labellingwidth5 = [UILabel getWidthWithTitle:_zhiweiLabel5.text font:_zhiweiLabel5.font];
            _zhiweiLabel5.frame = CGRectMake(CGRectGetMaxX(_zhiweiLabel5.frame)+5, CGRectGetMaxY(_xingbieImageVIew.frame)+9.5, labellingwidth5+10, 15);
            self.ZhiWeiWidth5.constant = labellingwidth5+10;

        }else
        {
            [_zhiweiLabel5 removeFromSuperview];
        }
    }
    [self xingxing:Model.pingFen Str:nil];
    _duiwodepingjiaView.editable = YES;
    [_duiwodepingjiaView setText:Model.pingJia];
}



#pragma mark 收藏
- (IBAction)shoucangbtn {
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
}

- (void)xingxing:(double)douNumber Str:(NSString *)str
{
    //ygdr_sy_nr_tb2 半星
    //yg_sy_gdpj_nr_tb2 全星
    //yg_sy_gdpj_nr_tb3 没星
    if ((douNumber <= 0.5 && douNumber > 0.0) || (douNumber <= 1.5 && douNumber > 1.0) || (douNumber <= 2.5 && douNumber > 2.0) || (douNumber <= 3.5 && douNumber > 3.0) || (douNumber <= 4.5 && douNumber > 4.0)){
        if ((douNumber <= 0.5 && douNumber > 0.0)) {
            [_xingxingImageView1 setImage:[UIImage imageNamed:banxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
        }else if ((douNumber <= 1.5 && douNumber > 1.0))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:banxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
        }else if ((douNumber <= 2.5 && douNumber > 2.0))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:banxing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
            
        }else if ((douNumber <= 3.5 && douNumber > 3.0))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:banxing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
            
        }else if ((douNumber <= 4.5 && douNumber > 4.0))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:banxing]];
        }
    }else if ((douNumber <= 1.0 && douNumber > 0.5) || (douNumber <= 2.0 && douNumber > 1.5) || (douNumber <= 3.0 && douNumber > 2.5) || (douNumber <= 4.0 && douNumber > 3.5) || (douNumber <= 5.0 && douNumber > 4.5)){
        if ((douNumber <= 1.0 && douNumber > 0.5)) {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
        }else if ((douNumber <= 2.0 && douNumber > 1.5))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
            
        }else if ((douNumber <= 3.0 && douNumber > 2.5))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:meixing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
            
        }else if ((douNumber <= 4.0 && douNumber > 3.5))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:meixing]];
            
        }else if ((douNumber <= 5.0 && douNumber > 4.5))
        {
            [_xingxingImageView1 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView2 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView3 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView4 setImage:[UIImage imageNamed:quanxing]];
            [_xingxingImageView5 setImage:[UIImage imageNamed:quanxing]];
        }
        
    }
}





#pragma mark 展开
- (IBAction)zhankaiButton {
    
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
