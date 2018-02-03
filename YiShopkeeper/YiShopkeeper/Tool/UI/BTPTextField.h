//
//  BTPTextField.h
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/11.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTPTextField : UITextField

+ (BTPTextField*)textField:(CGRect)frame placeholder:(NSString*)placeholder cornerRadius:(NSInteger)cornerRadius borderColor:(UIColor*)borderColor borderWidth:(NSInteger)borderWidth textAlignment:(NSInteger)textAlignment font:(NSInteger)font fontColor:(UIColor*)fontColor text:(NSString*)text placeholderColor:(UIColor*)placeholderColor;

@end
