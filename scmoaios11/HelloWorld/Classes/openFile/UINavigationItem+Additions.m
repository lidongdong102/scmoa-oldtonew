//
//  UINavigationItem+Additions.m
//  EaseChat
//
//  Created by 陈 胜 on 15/5/5.
//  Copyright (c) 2015年 陈 胜. All rights reserved.
//

#import "UINavigationItem+Additions.h"

@implementation UINavigationItem (CorrectOffset)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (leftBarButtonItem.title) { // 纯文字按钮
        [self setLeftBarButtonItem:leftBarButtonItem];
    } else {
        [self addLeftBarButtonItem:leftBarButtonItem spacer:-6.5];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    if (rightBarButtonItem.title) { // 纯文字按钮
        [self setRightBarButtonItem:rightBarButtonItem];
    } else {
        [self addRightBarButtonItem:rightBarButtonItem spacer:-6.5];
    }
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem spacer:(CGFloat)spacer {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = spacer;
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:leftBarButtonItem, nil]];
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem spacer:(CGFloat)spacer {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = spacer;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setRightBarButtonItems:[NSArray arrayWithObjects: rightBarButtonItem, nil]];
        });
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self setRightBarButtonItem:rightBarButtonItem];
    }
}

@end
