//
//  gongdanxiangqingView.m
//  YiShopkeeper
//
//  Created by  apple on 2017/12/5.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "gongdanxiangqingView.h"
#import "UIView+UIViewController.h"
@implementation gongdanxiangqingView
#pragma mark  取消工单
- (IBAction)quxiaogongdanBtn {
    NSLog(@"取消工单");
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消工单!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"action = %@", action);
        }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
            NSLog(@"action = %@", action);
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/repairordertomodify",kPRTURL];
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@(Global.userInfoId),@"userInfoId",@(_model.recruitInfoId),@"recruitInfoId",@(4) ,@"recruitType",nil];
            [BaseHttpTool POST:urlStr params:parameters success:^(id  _Nullable responseObj) {
                NSInteger result = [[responseObj valueForKey:@"result"] intValue];
                if (result == 1) {
                    [self showRightWithTitle:@"取消成功" autoCloseTime:2];
                    self.quxiaogongdan.hidden = YES;
                }else
                {
                    [self showErrorWithTitle:@"取消失败" autoCloseTime:2];
                }
            } failure:^(NSError * _Nullable error) {
                
            }];
            
            
            
        }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self.viewVC presentViewController:alert animated:YES completion:nil];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
