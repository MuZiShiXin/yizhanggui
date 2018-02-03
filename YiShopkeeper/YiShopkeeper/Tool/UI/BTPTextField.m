//
//  BTPTextField.m
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/11.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import "BTPTextField.h"

@implementation BTPTextField

+ (BTPTextField*)textField:(CGRect)frame placeholder:(NSString*)placeholder cornerRadius:(NSInteger)cornerRadius borderColor:(UIColor*)borderColor borderWidth:(NSInteger)borderWidth textAlignment:(NSInteger)textAlignment font:(NSInteger)font fontColor:(UIColor*)fontColor text:(NSString*)text placeholderColor:(UIColor*)placeholderColor{
    BTPTextField* textField = [[self alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    if (borderWidth != 0) {
        textField.layer.borderWidth = borderWidth;
    }
    if (cornerRadius != 0) {
        textField.layer.cornerRadius = cornerRadius;
    }
    if (borderColor != nil) {
        textField.layer.borderColor = borderColor.CGColor;
    }
    if (textAlignment == 0) {
        textField.textAlignment = NSTextAlignmentLeft;
    }else if (textAlignment == 1){
        textField.textAlignment = NSTextAlignmentCenter;
    }else if (textAlignment == 2){
        textField.textAlignment = NSTextAlignmentRight;
    }
    textField.font = [UIFont systemFontOfSize:font];
    if (fontColor != nil) {
        textField.textColor = fontColor;
    }
    textField.text = text;
    if (placeholderColor != nil) {
        [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
//        [textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return textField;

}

@end
