//
//  dingdanxiangqingModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/22.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dingdanxiangqingModel : NSObject

@property (nonatomic, assign) NSInteger recruitInfoId;//招工信息表id
@property (nonatomic, assign) NSInteger myOrderId;//订单表id
@property (nonatomic, strong) NSString *headPicAdd;//头像地址
@property (nonatomic, strong) NSString *nick; //名字
@property (nonatomic, strong) NSString *workTotal;//工作标题
@property (nonatomic, strong) NSString *startTm;//开始时间
@property (nonatomic, assign) NSInteger woekDuration;//工作时长
@property (nonatomic, strong) NSString *workType;//工种
@property (nonatomic, assign) NSInteger recruitNum;//招工人数
@property (nonatomic, assign) NSInteger lastPeoNum;//剩余人数
@property (nonatomic, assign) double x;//x坐标
@property (nonatomic, assign) double y;//y坐标
@property (nonatomic, strong) NSString *distance;//距离
@property (nonatomic, strong) NSString *workDetail;//详细内容
@property (nonatomic, strong) NSString *workOrderTab;//工单编号
@property (nonatomic, strong) NSString *orderNum;//订单编号
@property (nonatomic, strong) NSString *applyTm;//报名时间
@property (nonatomic, strong) NSString *owberTm;//甲方确认时间
@property (nonatomic, strong) NSString *arrivalTm;//到达时间
@property (nonatomic, strong) NSString *completeTm;//完工时间
@property (nonatomic, strong) NSString *owberAccpetTm;//甲方验收时间
@property (nonatomic, assign) NSInteger orderState;//订单状态
@property (nonatomic, strong) NSString *orderStateMes;//订单状态信息
@property (nonatomic, assign) double pay;//薪资
@property (nonatomic, strong) NSString *payUtil;//薪资单位
@property (nonatomic, assign) double payAll;//薪资总数
@property (nonatomic, assign) NSInteger workNum;//工作天数
@property (nonatomic, strong) NSString *minuteAdd;//地址
@property (nonatomic, strong) NSString *remark;// 取消内容

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;
@end
