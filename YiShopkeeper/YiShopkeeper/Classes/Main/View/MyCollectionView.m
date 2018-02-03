//
//  MyCollectionView.m
//  YiShopkeeper
//
//  Created by  apple on 2017/11/24.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import "MyCollectionView.h"

@implementation MyCollectionView

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array{
    
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < array.count; i ++)
        {
            NSString *name = array[i];
            static UIButton *recordBtn =nil;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.enabled = YES;
            CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
            
            CGFloat BtnW = rect.size.width+10;
            CGFloat BtnH = rect.size.height;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 4;
            if (i == 0)
            {
                btn.frame =CGRectMake(0, 0, BtnW, BtnH);
            }
            else{
                
                CGFloat yuWidth = self.frame.size.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                    
                    btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 5, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    
                    btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+5, BtnW, BtnH);
                }
                
            }
            //            btn.backgroundColor = [UIColor yellowColor];
            btn.layer.borderWidth = 1.0;
            btn.layer.cornerRadius = 4;
            if (i == 0) {
                btn.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"589daf"].CGColor;
                [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"589daf"] forState:UIControlStateNormal];
            }else if (i == 1)
            {
                btn.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"].CGColor;
                [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] forState:UIControlStateNormal];
            }else if (i==2)
            {
                btn.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"589daf"].CGColor;
                [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"589daf"] forState:UIControlStateNormal];
            }else if (i==3)
            {
                btn.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"ff9f0f"].CGColor;
                [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"ff9f0f"] forState:UIControlStateNormal];
            }else if (i==4)
            {
                btn.layer.borderColor = [UIColor hx_colorWithHexRGBAString:@"589daf"].CGColor;
                [btn setTitleColor:[UIColor hx_colorWithHexRGBAString:@"589daf"] forState:UIControlStateNormal];
            }
            
            [btn setTitle:name forState:UIControlStateNormal];
            btn.layer.masksToBounds = YES;
            [self addSubview:btn];
            
            NSLog(@"btn.frame.origin.y  %f", btn.frame.origin.y);
            self.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20,CGRectGetMaxY(btn.frame)+10);
            recordBtn = btn;
            
            btn.tag = 100 + i;
            
            //            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    return self;
    
}

-(void) BtnClick:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.tag);
    }
    
}

-(void) btnClickBlock:(BtnBlock)btnBlock{
    
    self.btnBlock = btnBlock;
    
}

@end
