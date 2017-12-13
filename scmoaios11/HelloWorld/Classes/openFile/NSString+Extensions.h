//
//  NSString+Extensions.h
//  EaseChat
//
//  Created by 陈 胜 on 15/2/28.
//  Copyright (c) 2015年 Ruaho Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extensions)

/**
 *  是否为空字符
 *
 *  @return 返回判断结果
 */
- (BOOL)isBlank;

/**
 *  是否为中文
 *
 *  @return 返回判断结果
 */
- (BOOL)isChinese;

/**
 *  获取字符串指定字体的CGRect
 *
 *  @param size 范围，大小不超出该范围
 *  @param font 字体
 *
 *  @return 返回计算之后的CGRect
 */
- (CGRect)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font;

/**
 *  获取字符串指定字体的CGRect
 *
 *  @param size 范围，大小不超出该范围
 *  @param font 字体
 *  @param lineSpacing 行间距
 *
 *  @return 返回计算之后的CGRect
 */
- (CGRect)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;
/**
 *   获取字符串在指定字体和约束size以及显示行数之后的size
 *
 *  @param size        约束size
 *  @param font        字体
 *  @param lineSpacing 行高
 *  @param line        显示行数
 *
 *  @return 真是显示rect
 */
- (CGRect)boundingRectWithSize:(CGSize)size andFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing showLine:(NSInteger)line;

/**
 *  获取字符串在指定字体和约束size以及显示行数之后的size
 *
 *  @param font 字体
 *  @param size 约束size
 *  @param line 显示行数
 *
 *  @return 真实显示size
 */
- (CGSize)boundingSizeWithFont:(UIFont *)font constraintSize:(CGSize)size showLine:(NSInteger)line;


/**
 *  判断字符串是否包含子字符串
 *
 *  @param substring 子字符串
 *
 *  @return 返回判断布尔结果
 */
- (BOOL)containsSubstring:(NSString *)substring;

/**
 *  覆盖该方法iOS7里面没有该方法
 *
 *  @param string 字符串
 *
 *  @return 返回布尔结果
 */
- (BOOL)containsString:(NSString *)string;

/**
 *  对字符串编码
 *
 *  @return 返回编码之后的值
 */
- (NSString *)encode;
/**
 *  对字符串解码
 *
 *  @return 返回解码之后的值
 */
- (NSString *)decode;
/**
 *  去空格回车换行
 *
 *  @return 返回解码之后的值
 */
+(NSString *)removeSpaceAndNewline:(NSString *)str;
/**
 *  过滤掉特殊字符 //@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"
 *
 *  @return 返回过滤后的值
 */
- (NSString *)stringByTrimmingCharactersWithCustomSet;

- (NSString *)stringByReplacingOccurrencesOfSpecialChar;

@end
