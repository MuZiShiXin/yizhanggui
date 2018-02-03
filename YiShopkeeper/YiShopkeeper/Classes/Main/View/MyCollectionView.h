//
//  MyCollectionView.h
//  YiShopkeeper
//
//  Created by  apple on 2017/11/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BtnBlock)(NSInteger index);

@interface MyCollectionView : UIView

@property (nonatomic,weak) BtnBlock btnBlock;

-(void) btnClickBlock:(BtnBlock) btnBlock;

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array;
@end
