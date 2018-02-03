//
//  BTPSearchBar.h
//  FilmBaiXiaoSheng
//
//  Created by  xiaotu on 16/10/11.
//  Copyright © 2016年 XT-Fyn-Lz-Jy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTPSearchBar : UISearchBar<UISearchBarDelegate>

- (instancetype)initWithFrame:(CGRect)frame barStyle:(UIBarStyle)barStyle placeholder:(NSString*)placeholder superView:(UIView*)superView;

@end
