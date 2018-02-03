//
//  MyEvaluationTableViewCell.h
//  YiShopkeeper
//
//  Created by  apple on 2017/12/4.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPJModel.h"
@interface MyEvaluationTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *duiwodepingjiaView;

- (void)initSubViewsWithIndexPath:(NSIndexPath *)indexPath DDPJdic:(DDPJModel *)Model;
@end
