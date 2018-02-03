//
//  PhotoModel.h
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/8/24.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) UIImage* image;
@property (nonatomic) NSInteger tag;//-1 ： 添加图片+号 -2 ：点击加号之后添加的图片

@end
