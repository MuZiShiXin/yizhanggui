//
//  FirstViewController.m
//  decorateaSmallTwo
//
//  Created by  apple on 2017/9/8.
//  Copyright © 2017年 程序员. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TAAbstractDotView : UIView


/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;


@end

