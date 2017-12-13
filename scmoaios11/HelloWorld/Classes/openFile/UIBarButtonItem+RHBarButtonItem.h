//
//  UIBarButtonItem+RHCalendarBarItem.h
//  EaseChat
//
//  Created by liangju on 11/16/16.
//  Copyright © 2016 liangju. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RHBarButtonItemPosition) {
    RHBarButtonItemPosition_Left = 1 << 0,   // 左侧
    RHBarButtonItemPosition_Right = 1 << 1     // 右侧
};

@interface UIBarButtonItem (RHBarButtonItem)

+ (UIBarButtonItem *)customRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)customRightItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)customLeftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)customLeftItemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)customLeftItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)customDoubleItemWithImage:(NSString *)image highImage:(NSString *)highImage  barButtonItemPosition:(RHBarButtonItemPosition)position target:(id)target action:(SEL)action;

@end
