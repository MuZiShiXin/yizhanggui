//
//  YKNodeModel.m
//  MutableLevelTableView
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "YKNodeModel.h"

@implementation YKNodeModel

+ (instancetype)nodeWithParentID:(NSString *)parentID name:(NSString *)name childrenID:(NSString *)childrenID isExpand:(BOOL)bol{
    return [self nodeWithParentID:parentID name:name childrenID:childrenID level:-1 isExpand:bol];
}

+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID level:(NSUInteger)level isExpand:(BOOL)bol{
    
    YKNodeModel *node = [[YKNodeModel alloc] init];
    node.fatherWorkTypeId = parentID;
    node.workType = name;
    node.workTypeId = childrenID;
    node.level = level;
    node.expand = bol;
    
    return node;
}

@end
