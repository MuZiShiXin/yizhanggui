//
//  MasseaModel.h
//  UniversalApp
//
//  Created by  apple on 2018/1/19.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MasseaModel : NSObject

@property (assign ,nonatomic) NSInteger msgid;
@property (assign ,nonatomic) NSInteger userDrId;
@property (assign ,nonatomic) NSInteger userZgId;
@property (assign ,nonatomic) NSInteger statesee;
@property (assign ,nonatomic) NSInteger messagetype;
@property (strong ,nonatomic) NSString *seetime;
@property (assign ,nonatomic) NSInteger orderId;
@property (assign ,nonatomic) NSInteger userType;
@property (strong ,nonatomic) NSString *msgContent;
@property (strong ,nonatomic) NSString *msgTotal;
@property (strong ,nonatomic) NSString *sysSendType;
@property (strong ,nonatomic) NSString *workType;
@property (strong ,nonatomic) NSString *workOrderTab;
@property (strong ,nonatomic) NSString *woekDuration;
@property (strong ,nonatomic) NSString *userName;

//private Integer id;//消息id
//private Integer userDrId;//达人id
//private Integer userZgId;//掌柜id
//private Integer statesee=4444444;//是否查看
//private Integer messagetype=333333;//消息类型
//private String seetime="";//查看时间
//private Integer orderId=22222;//工单编号id
//private Integer userType=11111; //掌柜名称
//private String msgContent="";//消息内容
//private String msgTotal="";//消息标题
//private String sysSendType="";//1,全部达人2,全部掌柜/企业3,全部掌柜/达人4,部分会员
//private String workType="";//工种
//private String workOrderTab="";//工单编号
//private String woekDuration="";//工单时长

+ (instancetype)creatRankingTotalModelWith:(NSDictionary *)dict;

@end
