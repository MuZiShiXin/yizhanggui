//
//  YKMutableLevelTableView.h
//  MutableLevelTableView
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKNodeModel.h"

typedef void(^YKSelectBlock)(YKNodeModel *node);

@interface YKMultiLevelTableView : UITableView

- (id)initWithFrame:(CGRect)frame nodes:(NSArray*)nodes rootNodeID:(NSString*)rootID needPreservation:(BOOL)need selectBlock:(YKSelectBlock)block;
@end
