//
//  BTPTableView.m
//  YeQ
//
//  Created by  xiaotu on 16/10/29.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BTPTableView.h"

@interface BTPTableView()

@property (nonatomic,strong) NSArray *datasArray;
@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组
@property (nonatomic,strong) NSTimer *timer;//模拟数据刷新需要的时间控制器
@property (nonatomic,assign) int time;

@end

@implementation BTPTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [header setImages:self.refreshImages duration:1 forState:MJRefreshStateRefreshing];
        [header setImages:self.normalImages duration:1 forState:MJRefreshStateIdle];
        [header setImages:self.refreshImages duration:1 forState:MJRefreshStatePulling];
        header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
        header.stateLabel.hidden = YES;
        self.mj_header = header;
    }
    return self;
}

- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i<=2; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%ld",i]];
            [self.normalImages addObject:image];
        }
    }
    return _normalImages;
}
//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        //				循环添加图片
        for (NSUInteger i = 0; i<=7; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%ld", i]];
            [self.refreshImages addObject:image];
        }
    }
    return _refreshImages;
}

-(void)loadNewData {
    //模拟刷新的时间
    self.timer  =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    self.time = 3;
}
-(void)timeAction {
    self.time --;
    NSLog(@"%d",self.time);
    if (self.time == 0) {
        //		刷新数据
        [self reloadData];
        //		停止刷新
        [self.mj_header endRefreshing];
        [self.timer invalidate];
    }
}
@end
