//
//  UIBarButtonItem+RHCalendarBarItem.m
//  EaseChat
//
//  Created by liangju on 11/16/16.
//  Copyright © 2016 liangju. All rights reserved.
//

#import "UIBarButtonItem+RHBarButtonItem.h"
static const CGFloat kBackButtonHeight = 30;            // 返回按钮高度
static const CGFloat kBackButtonArrowWidth = 15;        // 返回箭头宽度
static const CGFloat kBackButtonMaxWidth = 150;         // 返回按钮最大宽度

@implementation UIBarButtonItem (RHBarButtonItem)

+ (UIBarButtonItem *)customRightItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [listButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [listButton setExclusiveTouch:YES];
    listButton.frame = CGRectMake(0, 0, 50, 30);
    UIImage *barButtonImage = [UIImage imageNamed:image];
    [listButton setImage:barButtonImage forState:UIControlStateNormal];
    [listButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    listButton.backgroundColor = RedGroubBackGroundColor;
    UIBarButtonItem *listBtnItem = [[UIBarButtonItem alloc]initWithCustomView:listButton];
    listBtnItem.width = 50;
    if (@available(iOS 11.0, *)) {
        listButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kLeftRightButtonMargin);
        listButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kLeftRightButtonMargin);
    }
    return listBtnItem;
}

+ (UIBarButtonItem *)customRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}


+ (UIBarButtonItem *)customLeftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [listButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [listButton setExclusiveTouch:YES];
    listButton.frame = CGRectMake(0, 0, 50, 30);
    listButton.titleLabel.font = [self titleFont];
    [listButton setTitle:title forState:UIControlStateNormal];
    [listButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [listButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [listButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *listBtnItem = [[UIBarButtonItem alloc]initWithCustomView:listButton];
    listBtnItem.width = 50;
    if (@available(iOS 11.0, *)) {
        listButton.contentEdgeInsets = UIEdgeInsetsMake(0, kLeftRightButtonMargin, 0, 0);
        listButton.imageEdgeInsets = UIEdgeInsetsMake(0, kLeftRightButtonMargin, 0, 0);
    }
    return listBtnItem;
}

+ (UIBarButtonItem *)customLeftItemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action {
    if (!title || title.length == 0) {
        title = @"返回";
    }
    UIButton *listButton = [self customBackButton:title];
    [listButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *listBtnItem = [[UIBarButtonItem alloc]initWithCustomView:listButton];
    listBtnItem.width = 50;
    return listBtnItem;
}

+ (UIBarButtonItem *)customLeftItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action  {
    return [self customLeftItemWithImage:image highImage:highImage title:@"" target:target action:action];
}

+ (UIBarButtonItem *)customDoubleItemWithImage:(NSString *)image highImage:(NSString *)highImage barButtonItemPosition:(RHBarButtonItemPosition)position target:(id)target action:(SEL)action {
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [listButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    if (position == RHBarButtonItemPosition_Left) {
        [listButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    [listButton setExclusiveTouch:YES];
    listButton.frame = CGRectMake(0, 0, 35, 30);
    if (image && image.length ==0) {
        UIImage *barButtonImage = [UIImage imageNamed:image];
        [listButton setImage:barButtonImage forState:UIControlStateNormal];
    }
    if (highImage && highImage.length == 0) {
        UIImage *highlightedImage = [UIImage imageNamed:highImage];
        [listButton setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    [listButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *listBtnItem = [[UIBarButtonItem alloc]initWithCustomView:listButton];
    listBtnItem.width = 40;
    if (@available(iOS 11.0, *)) {
        listButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kLeftRightButtonMargin);
        listButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kLeftRightButtonMargin);
    }
    return listBtnItem;

}

+ (UIButton *)customBackButton:(NSString *)title {
    CGSize boudingSize = [title boundingRectWithSize:CGSizeMake(kBackButtonMaxWidth, kBackButtonHeight)
                                             andFont:[self titleFont]].size;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setFrame:CGRectMake(0, 0, boudingSize.width + kBackButtonArrowWidth, kBackButtonHeight)];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backButton setExclusiveTouch:YES];
    UIImage *barButtonImage = [UIImage imageNamed:@"barbuttonicon_back"];
    [backButton setImage:barButtonImage forState:UIControlStateNormal];
    [backButton setTitle:title forState:UIControlStateNormal];
    backButton.tintColor = [self titleColor];
    [backButton setTitleColor:[self titleColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[self titleColor] forState:UIControlStateHighlighted];
    backButton.titleLabel.font = [self titleFont];
    if (@available(iOS 11.0, *)) {
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, kLeftRightButtonMargin, 0, 0);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, kLeftRightButtonMargin, 0, 0);
        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kLeftRightButtonMargin, 0, 0)];
    }
    [backButton.titleLabel sizeToFit];
    return backButton;
}

+ (UIColor *)titleColor {
    return [UIColor whiteColor];
}

+ (UIFont *)titleFont {
    return [UIFont systemFontOfSize:15];
}


@end
