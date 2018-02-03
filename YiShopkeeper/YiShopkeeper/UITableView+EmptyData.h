//
//  UITableView+EmptyData.h
//  YiShopkeeper
//
//  Created by  apple on 2018/1/23.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (EmptyData)
- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
