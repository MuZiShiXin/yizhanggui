//
//  MyCollectionDetailsViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/30.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyCollectionDetailsViewController.h"
#import "MyCollectionView.h"

@interface MyCollectionDetailsViewController ()
@property (nonatomic, strong) MyCollectionView *labellingView;
@end

@implementation MyCollectionDetailsViewController


- (void)setValueSDic:(SCModel *)dic
{
    [_touxiang sd_setImageWithURL:[NSURL URLWithString:dic.touXiang]];
    [_darenxingming setText:dic.xingMing];
    
    if (dic.shouCang == 1) {
        [_shoucangButtonTuPian setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangButtonWenZi.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
    }else
    {
        [_shoucangButtonTuPian setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangButtonWenZi.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    
    if ([dic.xingBie isEqualToString:@"男"]) {
        _xingbie.image = [UIImage imageNamed:@"yg_sy_nr_tb2"];
    }else
    {
        _xingbie.image = [UIImage imageNamed:@"yg_sy_nr_tb1"];
    }
    [_gongling setText:[NSString stringWithFormat:@"%ld年",(long) dic.gongLing]];
    
//    _labellingView = [[MyCollectionView alloc]initWithFrame:CGRectMake(kScreenWidth-75-11-30, 80, kScreenWidth-100,15) dataArr:dic.gongZhongs];
//    _labellingView.backgroundColor = [UIColor redColor];
//    [self.view1 addSubview:_labellingView];
    
//        NSArray * ary = @[@"1",@"2",@"3",@"4",@"5"];
    if (dic.gongZhongs.count >= 1 && dic.gongZhongs.count > 0) {
        _gerenbiaoqian1.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
        //设置边框宽度
        _gerenbiaoqian1.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _gerenbiaoqian1.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _gerenbiaoqian1.layer.masksToBounds = YES;
        _gerenbiaoqian1.font = [UIFont systemFontOfSize:10];
        _gerenbiaoqian1.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
        [_gerenbiaoqian1 setText:dic.gongZhongs[0]];
        _gerenbiaoqian1.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth1 = [UILabel getWidthWithTitle:_gerenbiaoqian1.text font:_gerenbiaoqian1.font];
        _gerenbiaoqian1.frame = CGRectMake(CGRectGetMaxX(_touxiang.frame)+11, CGRectGetMaxY(_gongling.frame)+9.5, labellingwidth1+10, 15);
    }else
    {
        [_gerenbiaoqian1 removeFromSuperview];
    }

    if (dic.gongZhongs.count >= 2 && dic.gongZhongs.count > 1) {
        _gerenbiaoqian2.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _gerenbiaoqian2.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _gerenbiaoqian2.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _gerenbiaoqian2.layer.masksToBounds = YES;
        _gerenbiaoqian2.font = [UIFont systemFontOfSize:10];
        _gerenbiaoqian2.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_gerenbiaoqian2 setText:dic.gongZhongs[1]];
        _gerenbiaoqian2.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth2 = [UILabel getWidthWithTitle:_gerenbiaoqian2.text font:_gerenbiaoqian2.font];
        _gerenbiaoqian2.frame = CGRectMake(CGRectGetMaxX(_gerenbiaoqian2.frame)+5, CGRectGetMaxY(_gongling.frame)+9.5, labellingwidth2+10, 15);
    }else
    {
        [_gerenbiaoqian2 removeFromSuperview];
    }

    if (dic.gongZhongs.count >= 3 && dic.gongZhongs.count > 2) {
        _gerenbiaoqian3.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _gerenbiaoqian3.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _gerenbiaoqian3.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _gerenbiaoqian3.layer.masksToBounds = YES;
        _gerenbiaoqian3.font = [UIFont systemFontOfSize:10];
        _gerenbiaoqian3.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_gerenbiaoqian3 setText:dic.gongZhongs[2]];
        _gerenbiaoqian3.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth3 = [UILabel getWidthWithTitle:_gerenbiaoqian3.text font:_gerenbiaoqian3.font];
        _gerenbiaoqian3.frame = CGRectMake(CGRectGetMaxX(_touxiang.frame)+5, CGRectGetMaxY(_gongling.frame)+9.5, labellingwidth3+10, 15);
    }else
    {
        [_gerenbiaoqian3 removeFromSuperview];
    }

    if (dic.gongZhongs.count >= 4 && dic.gongZhongs.count > 3) {
        _gerenbiaoqian4.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"589daf"] CGColor];
        //设置边框宽度
        _gerenbiaoqian4.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _gerenbiaoqian4.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _gerenbiaoqian4.layer.masksToBounds = YES;
        _gerenbiaoqian4.font = [UIFont systemFontOfSize:10];
        _gerenbiaoqian4.textColor = [UIColor hx_colorWithHexRGBAString:@"589daf"];
        [_gerenbiaoqian4 setText:dic.gongZhongs[3]];
        _gerenbiaoqian4.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth4 = [UILabel getWidthWithTitle:_gerenbiaoqian4.text font:_gerenbiaoqian4.font];
        _gerenbiaoqian4.frame = CGRectMake(CGRectGetMaxX(_touxiang.frame)+5, CGRectGetMaxY(_gongling.frame)+9.5, labellingwidth4+10, 15);
    }else
    {
        [_gerenbiaoqian4 removeFromSuperview];
    }

    if (dic.gongZhongs.count <= 5 && dic.gongZhongs.count > 4) {
        _gerenbiaoqian5.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] CGColor];
        //设置边框宽度
        _gerenbiaoqian5.layer.borderWidth = 0.50f;
        //给按钮设置角的弧度
        _gerenbiaoqian5.layer.cornerRadius = 4.0f;
        //设置背景颜色
        _gerenbiaoqian5.layer.masksToBounds = YES;
        _gerenbiaoqian5.font = [UIFont systemFontOfSize:10];
        _gerenbiaoqian5.textColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"];
        [_gerenbiaoqian5 setText:dic.gongZhongs[4]];
        _gerenbiaoqian5.textAlignment = NSTextAlignmentCenter;
        CGFloat labellingwidth5 = [UILabel getWidthWithTitle:_gerenbiaoqian5.text font:_gerenbiaoqian5.font];
        _gerenbiaoqian5.frame = CGRectMake(CGRectGetMaxX(_touxiang.frame)+5, CGRectGetMaxY(_gongling.frame)+9.5, labellingwidth5+10, 15);
    }else
    {
        [_gerenbiaoqian5 removeFromSuperview];
    }
    _gerenmiaoshu.text = dic.neiRong;
    [_jinengtupian sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"yg_sy_grxq_nr_tp3"]];
    [_wanchenggongdan setText:[NSString stringWithFormat:@"成单 %ld 单",dic.chengDanShu]];
    
    [self xingxing:dic.zhunShi Str:@"准时"];
    [self xingxing:dic.jiNeng Str:@"技能"];
    [self xingxing:dic.xiaoLv Str:@"效率"];
    [self xingxing:dic.zhiLiang Str:@"质量"];
 
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.NVBJImageView.alpha = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.titelLabel.text = @"工人详情";
    
    _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    //设置边框宽度
    _shoucangButton.layer.borderWidth = 0.50f;
    //给按钮设置角的弧度
    _shoucangButton.layer.cornerRadius = 10.0f;
    //设置背景颜色
    _shoucangButton.layer.masksToBounds = YES;
    
    _BJSceollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.view3.frame));
    [self setValueSDic:self.Model];
}
#pragma mark 收藏
- (IBAction)shoucangbtn {
    if ([_shoucangButtonTuPian.image isEqual:[UIImage imageNamed:@"yg_sy_nr_tb3"]]) {
        NSLog(@"收藏");
        [_shoucangButtonTuPian setImage:[UIImage imageNamed:@"yg_sy_nr_tb4"]];
        _shoucangButtonWenZi.textColor = [UIColor hx_colorWithHexRGBAString:@"f56165"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"f56165"] CGColor];
        
    }else {
        NSLog(@"取消收藏");
        [_shoucangButtonTuPian setImage:[UIImage imageNamed:@"yg_sy_nr_tb3"]];
        _shoucangButtonWenZi.textColor = [UIColor hx_colorWithHexRGBAString:@"999999"];
        _shoucangButton.layer.borderColor = [[UIColor hx_colorWithHexRGBAString:@"999999"] CGColor];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/ZG/shoucang",kPRTURL];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(self.Model.zhangGuiId),@"zhangGuiId",@(self.Model.daRenId),@"daRenId", nil];
    
    [BaseHttpTool GET:urlStr params:parameters success:^(id  _Nullable responseObj) {
        NSInteger result = [[responseObj valueForKey:@"result"] intValue];
//        NSArray *resultDic = [[responseObj objectForKeyWithNullDetection:@"data"] objectForKeyWithNullDetection:@"rows"];
        if (result == 1) {
            NSLog(@"收藏成功");
            if (self.Model.shouCang == 0) {
                self.Model.shouCang = 1;
                [self showRightWithTitle:@"收藏成功" autoCloseTime:2];
                
            }else
            {
                self.Model.shouCang = 0;
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
