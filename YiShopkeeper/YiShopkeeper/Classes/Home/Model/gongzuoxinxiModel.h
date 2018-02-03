//
//  gongzuoxinxiModel.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/18.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gongzuoxinxiModel : NSObject

@property (assign ,nonatomic) NSInteger userInfoId; //登录基础信息id
@property (assign ,nonatomic) NSInteger recruitInfoId;//招工信息表id
@property (strong ,nonatomic) NSString *headPicAdd;//头像
@property (strong ,nonatomic) NSString *workTotal;//工作标题
@property (assign ,nonatomic) NSInteger sussOrderNumber;//成单数
@property (assign ,nonatomic) NSInteger evaluateCore;//评价分
@property (assign ,nonatomic) CGFloat evaluateCorexx;//评价平均扥
@property (strong ,nonatomic) NSString *startTm;//开始时间
@property (assign ,nonatomic) NSInteger woekDuration;//工作时长
@property (strong ,nonatomic) NSString *workType;//工种
@property (assign ,nonatomic) NSInteger appliedPeoNum; //已报名人数
@property (assign ,nonatomic) NSInteger recruitNum;//招工人数
@property (assign ,nonatomic) NSInteger lastPeoNum;//剩余人数
@property (assign ,nonatomic) CGFloat pay;//薪资
@property (strong ,nonatomic) NSString *payUnit;//薪资单位
@property (assign ,nonatomic) NSInteger workNum;//工作天数
@property (strong ,nonatomic) NSString *issueTm;//发布时间
@property (strong ,nonatomic) NSString *workOrderTab;//工单编号
@property (strong ,nonatomic) NSString *workDetail;//详细内容
@property (strong ,nonatomic) NSString *minuteAdd;//地址
@property (assign ,nonatomic) CGFloat x;//x坐标
@property (assign ,nonatomic) CGFloat y;//y坐标
@property (strong ,nonatomic) NSString *distance;//距离
@property (strong ,nonatomic) NSArray *workEvnPic;//工作照片
@property (strong ,nonatomic) NSString *nick;//名称
@property (strong ,nonatomic) NSString *firmIntro;//简介
@property (strong ,nonatomic) NSString *clientType;//类型
@property (assign ,nonatomic) NSInteger zhuangTai;
+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
