//
//  ZJUnFoldAttributedString.h
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZJUnFoldParagraphStyle;

@interface ZJUnFoldAttributedString : NSObject

/** 内容属性字符串 */
@property (nonatomic, copy, readonly) NSAttributedString *contentAttributedString;
/** 展开属性字符串 */
@property (nonatomic, copy, readonly) NSAttributedString *unFoldAttributedString;
/** 折叠/收回属性字符串 */
@property (nonatomic, copy, readonly) NSAttributedString *foldAttributedString;
/** 段落样式 */
@property (nonatomic, copy, readonly) ZJUnFoldParagraphStyle *paragraphStyle;

/**
 快速实例化方法：默认的属性字符串配置

 @param content 内容
 @return 属性字符串
 */
+ (instancetype)defaultConficAttributedString:(NSString *)content;

/**
 根据内容、展开、折叠、行间距生成一个属性字符串
 
 @param content 内容
 @param contentFont 内容字体
 @param contentColor 内容颜色
 @param unFoldString 展开时文字
 @param foldString 折叠时文字
 @param unFoldFont 展开、折叠时字体
 @param unFoldColor 展开、折叠时颜色
 @param lineSpacing 行间距 lineSpacing >= 0.0f
 @return 属性字符串
 */
- (instancetype)initWithContent:(NSString *)content
                    contentFont:(UIFont *)contentFont
                   contentColor:(UIColor *)contentColor
                   unFoldString:(NSString *)unFoldString
                     foldString:(NSString *)foldString
                     unFoldFont:(UIFont *)unFoldFont
                    unFoldColor:(UIColor *)unFoldColor
                    lineSpacing:(CGFloat)lineSpacing;

/**
 根据内容、展开、折叠属性字符串、段落样式生成一个属性字符串
 
 @param contentAttrStr 内容属性字符串
 @param unFoldAttrStr 展开属性字符串
 @param foldAttrStr 折叠属性字符串
 @param paragraphStyle 段落样式
 @return 属性字符串
 */
- (instancetype)initWithContentAttrStr:(NSAttributedString *)contentAttrStr
                         unFoldAttrStr:(NSAttributedString *)unFoldAttrStr
                           foldAttrStr:(NSAttributedString *)foldAttrStr
                        paragraphStyle:(ZJUnFoldParagraphStyle *)paragraphStyle;
@end
