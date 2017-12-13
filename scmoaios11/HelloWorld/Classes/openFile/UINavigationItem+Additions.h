//
//  UINavigationItem+Additions.h
//  EaseChat
//
//  Created by 陈 胜 on 15/5/5.
//  Copyright (c) 2015年 陈 胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Additions)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
                      spacer:(CGFloat)spacer;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
                       spacer:(CGFloat)spacer;

@end
