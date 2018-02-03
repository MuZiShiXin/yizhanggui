//
//  XZUnifiedorderModel.h
//  YeQ
//
//  Created by  apple on 2016/12/17.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZUnifiedorderModel : NSObject
/** 应用ID */
@property (nonatomic,copy) NSString *appid;
/** 商户号 */
@property (nonatomic,copy) NSString *partnerid;
/** 预支付交易会话ID */
@property (nonatomic,copy) NSString *prepayid;
/** 扩展字段 微信预留的 */
@property (nonatomic,copy) NSString *packages;
/** 随机串，防重发 */
@property (nonatomic,copy) NSString *noncestr;
/** 时间戳 */
@property (nonatomic,copy) NSString *timestamp;
/** 签名 */
@property (nonatomic,copy) NSString *sign;

@property (nonatomic,copy) NSString *return_msg;



- (instancetype)initWithUnifiedorderModel:(NSDictionary *)dic;
+ (instancetype)MolelWithUnifiedorder:(NSDictionary *)dic;


@end
