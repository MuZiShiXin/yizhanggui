//
//  YKNodeModel.h
//  MutableLevelTableView
//
//  Created by  apple on 2017/12/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKNodeModel : NSObject

@property (nonatomic, strong) NSString *fatherWorkTypeId;

@property (nonatomic, strong) NSString *workTypeId;

@property (nonatomic, strong) NSString *workType;

@property (nonatomic, assign, getter=isExpand) BOOL expand;


@property (nonatomic, assign) NSUInteger level;// depth in the tree sturct

@property (nonatomic, assign, getter=isLeaf) BOOL leaf;

@property (nonatomic, assign, getter=isRoot) BOOL root;

/**
 *  初始化节点
 *
 *  @param parentID parent node's ID
 *  @param name       node's name
 *  @param childrenID this node's ID
 *  @param level      depth in the tree
 *  @param bol        this node's child node is expand or not
 */
+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID level:(NSUInteger)level isExpand:(BOOL)bol;

+ (instancetype)nodeWithParentID:(NSString*)parentID name:(NSString*)name childrenID:(NSString*)childrenID isExpand:(BOOL)bol;

@end
