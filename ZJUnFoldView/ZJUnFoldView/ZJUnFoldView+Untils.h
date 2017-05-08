//
//  ZJUnFoldView+Untils.h
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ZJUnFoldView.h"

@interface ZJUnFoldView (Untils)

/**
 计算字符串所占大小
 
 @param string 字符串
 @param maxWidth 最大宽度
 @return 字符串尺寸大小
 */
+ (CGSize)stringSize:(NSString *)string maxWidth:(CGFloat)maxWidth;

/**
 计算属性字符串所占大小
 
 @param attributedString 属性字符串
 @param maxWidth 最大宽度
 @return 属性字符串尺寸大小
 */
+ (CGSize)attributedStringSize:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth;

/**
 获取属性字符串最后一行的frame
 
 @param attributedString 属性字符串
 @param maxWidth 最大宽度
 @return 获取属性字符串最后一行的frame
 */
+ (CGRect)getLastLineRectFromAttrStr:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth;

/**
 获取属性字符串某一行的frame
 
 @param attributedString 属性字符串
 @param lineNum 行数（0~count-1）
 @param isLastLine 是否获取最后一行
 @param maxWidth 最大宽度
 @return 获取属性字符串某一行的frame
 */
+ (CGRect)getLineNumRectFromAttrStr:(NSAttributedString *)attributedString lineNum:(NSUInteger)lineNum isLastLine:(BOOL)isLastLine maxWidth:(CGFloat)maxWidth;

/**
 获取属性字符串某一行之前的所有字符串
 @param attributedString 属性字符串
 @param lineNum 行数（0~count-1）
 @param deleteStringLength 要删除的字符长度
 @param maxWidth 最大宽度
 @return 属性字符串
 */
+ (NSMutableAttributedString *)getLineNumBeforeAttrStingFromAttrStr:(NSAttributedString *)attributedString
                                                     lineNum:(NSUInteger)lineNum
                                          deleteStringLength:(NSUInteger)deleteStringLength
                                                    maxWidth:(CGFloat)maxWidth;
/**
 获取属性字符串行数

 @param attributedString 属性字符串
 @param maxWidth 最大宽度
 @return 行数
 */
+ (NSUInteger)getLineCountFromAttrStr:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth;

/**
 根据16进制字符串获取UIColor类型的颜色值
 
 @param stringToConvert 16进制字符串
 @return UIColor类型颜色值
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
