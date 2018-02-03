//
//  WorkTypeSViewController.m
//  YiShopkeeper
//
//  Created by  apple on 2018/1/17.
//  Copyright © 2018年 程序员. All rights reserved.
//

#import "WorkTypeSViewController.h"
#import "YKMultiLevelTableView.h"

@interface WorkTypeSViewController ()

@end

@implementation WorkTypeSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titelLabel.text = @"选择工种";
    
//    CGRect rect = self.view.frame;
    CGRect frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64);
    YKMultiLevelTableView *mutableTable = [[YKMultiLevelTableView alloc]
        initWithFrame:frame
                nodes:[self returnData]
           rootNodeID:@""
     needPreservation:YES
          selectBlock:^(YKNodeModel *node) {
        NSLog(@"--select node name=%@", node.workType);
        if (_block != nil) {
                _block(node.workType);
        }
    [self.navigationController popViewControllerAnimated: YES];
    }];
    [self.view addSubview:mutableTable];
    
}

- (NSArray*)returnData{
//    NSArray *list = @[@{@"parentID":@"", @"name":@"Node1", @"ID":@"1"},
//                      @{@"parentID":@"1", @"name":@"Node10", @"ID":@"10"},
//                      @{@"parentID":@"1", @"name":@"Node11", @"ID":@"11"},
//                      @{@"parentID":@"10", @"name":@"Node100", @"ID":@"100"},
//                      @{@"parentID":@"10", @"name":@"Node101", @"ID":@"101"},
//                      @{@"parentID":@"11", @"name":@"Node110", @"ID":@"110"},
//                      @{@"parentID":@"11", @"name":@"Node111", @"ID":@"111"},
//                      @{@"parentID":@"111", @"name":@"Node1110", @"ID":@"1110"},
//                      @{@"parentID":@"111", @"name":@"Node1111", @"ID":@"1111"},
//                      @{@"parentID":@"", @"name":@"Node2", @"ID":@"2"},
//                      @{@"parentID":@"2", @"name":@"Node20", @"ID":@"20"},
//                      @{@"parentID":@"20", @"name":@"Node200", @"ID":@"200"},
//                      @{@"parentID":@"20", @"name":@"Node101", @"ID":@"201"},
//                      @{@"parentID":@"20", @"name":@"Node202", @"ID":@"202"},
//                      @{@"parentID":@"2", @"name":@"Node21", @"ID":@"21"},
//                      @{@"parentID":@"21", @"name":@"Node210", @"ID":@"210"},
//                      @{@"parentID":@"21", @"name":@"Node211", @"ID":@"211"},
//                      @{@"parentID":@"21", @"name":@"Node212", @"ID":@"212"},
//                      @{@"parentID":@"211", @"name":@"Node2110", @"ID":@"2110"},
//                      @{@"parentID":@"211", @"name":@"Node2111", @"ID":@"2111"},];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in _WorkTypeDate) {
        YKNodeModel *node  = [YKNodeModel nodeWithParentID:[dic objectForKeyWithSpaceDetection:@"fatherWorkTypeId"]
                              //                              dic[@"fatherWorkTypeId"]
                                                      name:
                              [dic objectForKeyWithSpaceDetection:@"workType"]
                              //                              dic[@"workType"]
                                                childrenID:[dic objectForKeyWithSpaceDetection:@"workTypeId"]
                              //                              dic[@"workTypeId"]
                                                  isExpand:NO];
        [array addObject:node];
    }
    
    return [array copy];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
