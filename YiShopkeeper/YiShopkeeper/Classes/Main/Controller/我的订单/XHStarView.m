//
//  XHStarView.m
//  星星评价进阶2
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 mac.gu. All rights reserved.
//

#import "XHStarView.h"
#import "UIView+Extension.h"
@interface XHStarView ()

@property (strong, nonatomic)  UIImageView *starOne;
@property (strong, nonatomic)  UIImageView *starTwo;
@property (strong, nonatomic)  UIImageView *starThree;
@property (strong, nonatomic)  UIImageView *starFour;
@property (strong, nonatomic)  UIImageView *starFive;

@end

//判断是否添加星星
@implementation XHStarView{
    BOOL _isAddStar;
}

- (instancetype)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) {
        self.starOne = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        self.starOne.image = [UIImage imageNamed:@"yg_sy_gdpj_nr_tb3"];
        [self addSubview:self.starOne];
        
        self.starTwo = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_starOne.frame)+10, 5, 20, 20)];
        self.starTwo.image = [UIImage imageNamed:@"yg_sy_gdpj_nr_tb3"];
        [self addSubview:self.starTwo];
        
        self.starThree = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_starTwo.frame)+10, 5, 20, 20)];
        self.starThree.image = [UIImage imageNamed:@"yg_sy_gdpj_nr_tb3"];
        [self addSubview:self.starThree];
        
        self.starFour = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_starThree.frame)+10, 5, 20, 20)];
        self.starFour.image = [UIImage imageNamed:@"yg_sy_gdpj_nr_tb3"];
        [self addSubview:self.starFour];
        
        self.starFive = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_starFour.frame)+10, 5, 20, 20)];
        self.starFive.image = [UIImage imageNamed:@"yg_sy_gdpj_nr_tb3"];
        [self addSubview:self.starFive];  
    }
    return self;
}

- (void)startStar:(CGFloat)sender {

    [self setStarForegroundViewWithPoint:CGPointMake(sender *1.4, 0)];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if((point.x > self.starOne.x && point.x < (self.starFive.x + self.starFive.width))&&(point.y > self.starOne.y && point.y< self.height)){
        _isAddStar = YES;
        
    }else{
        _isAddStar = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(_isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];

    }

    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_isAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self setStarForegroundViewWithPoint:point];
    }
    _isAddStar = NO;
    return;
}

- (void)setStarForegroundViewWithPoint:(CGPoint)point{

    self.score = 0;
    self.score = self.score + [self changeImg:point.x image:self.starOne];
    self.score = self.score + [self changeImg:point.x image:self.starTwo];
    self.score = self.score + [self changeImg:point.x image:self.starThree];
    self.score = self.score + [self changeImg:point.x image:self.starFour];
    self.score = self.score + [self changeImg:point.x image:self.starFive];

    //评论最少半星
    if(self.score == 0){
        self.score = 20;
        [self.starOne setImage:[UIImage imageNamed:@"ygdr_sy_nr_tb2"]];
    }
    NSLog(@"分数 %f",self.score);
    block_(self.score);
}


- (CGFloat)changeImg:(float)x image:(UIImageView*)img{
    if(x > img.x + img.width/2){
        [img setImage:[UIImage imageNamed:@"yg_sy_gdpj_nr_tb2"]];
        return 20;
    }else if(x > img.x){
        [img setImage:[UIImage imageNamed:@"ygdr_sy_nr_tb2"]];
        return 10;
    }else{
        [img setImage:[UIImage imageNamed:@"yg_sy_gdpj_nr_tb3"]];
        return 0;
    }
}

- (void)setScore2:(CGFloat)score2{
    _score2 = score2;
    _score2 = self.score;
    NSLog(@"----分数 %f",self.score2);
    block_(self.score2);
}

- (void)alterproperty:(XHStar_ViewBlock)block{
    block_ = block;
}
@end
