//
//  XZUnifiedorderModel.m
//  YeQ
//
//  Created by  apple on 2016/12/17.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "XZUnifiedorderModel.h"

@implementation XZUnifiedorderModel
- (instancetype)initWithUnifiedorderModel:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.appid = [dic objectForKeyWithSpaceDetection:@"appid"];
        self.partnerid = [dic objectForKeyWithSpaceDetection:@"partnerid"];
        self.prepayid = [dic objectForKeyWithSpaceDetection:@"prepayid"];
        self.packages = [dic objectForKeyWithSpaceDetection:@"packages"];
        self.noncestr =[dic objectForKeyWithSpaceDetection:@"noncestr"];
        self.timestamp = [dic objectForKeyWithSpaceDetection:@"timestamp"];
        self.sign = [dic objectForKeyWithSpaceDetection:@"sign"];
        self.return_msg = [dic objectForKeyWithSpaceDetection:@"return_msg"];
    }
    return self;
}
+ (instancetype)MolelWithUnifiedorder:(NSDictionary *)dic
{
    return [[self alloc]initWithUnifiedorderModel:dic];
}
@end
