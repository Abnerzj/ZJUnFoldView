//
//  ZJUnFoldAttributedString.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ZJUnFoldAttributedString.h"
#import "ZJUnFoldParagraphStyle.h"
#import "ZJUnFoldView+Untils.h"

#define kDefalutUnFoldString         @"[展开]"
#define kDefalutFoldString           @"[收回]"
#define kDefalutAttributedStringFont [UIFont systemFontOfSize:12.0f]
#define kDefalutContentColor         [ZJUnFoldView colorWithHexString:@"#8b8b8b"]
#define kDefalutUnFoldColor          [ZJUnFoldView colorWithHexString:@"#dd4991"]
#define kDefalutLineSpacing          7.0f

@interface ZJUnFoldAttributedString ()

@end

@implementation ZJUnFoldAttributedString

/**
 * 快速实例化方法：默认的属性字符串配置
 */
+ (instancetype)defaultConficAttributedString:(NSString *)content
{
    return [[ZJUnFoldAttributedString alloc] initWithContent:content contentFont:kDefalutAttributedStringFont contentColor:kDefalutContentColor unFoldString:kDefalutUnFoldString foldString:kDefalutFoldString unFoldFont:kDefalutAttributedStringFont unFoldColor:kDefalutUnFoldColor lineSpacing:kDefalutLineSpacing];
}

/**
 * 根据内容、展开、折叠、行间距生成一个属性字符串
 */
- (instancetype)initWithContent:(NSString *)content
                    contentFont:(UIFont *)contentFont
                   contentColor:(UIColor *)contentColor
                   unFoldString:(NSString *)unFoldString
                     foldString:(NSString *)foldString
                     unFoldFont:(UIFont *)unFoldFont
                    unFoldColor:(UIColor *)unFoldColor
                    lineSpacing:(CGFloat)lineSpacing
{
    // Assert
    NSParameterAssert(content);
    NSParameterAssert(contentFont);
    NSParameterAssert(contentColor);
    NSParameterAssert(unFoldString);
    NSParameterAssert(foldString);
    NSParameterAssert(unFoldFont);
    NSParameterAssert(unFoldColor);
    NSParameterAssert(lineSpacing >= 0.0f);
    
    // 内容
    NSAttributedString *contentAttrStr = [[NSAttributedString alloc] initWithString:content attributes:@{NSFontAttributeName : contentFont, NSForegroundColorAttributeName : contentColor}];
    // 展开
    NSAttributedString *unFoldAttrStr = [[NSMutableAttributedString alloc] initWithString:unFoldString attributes:@{NSFontAttributeName : unFoldFont, NSForegroundColorAttributeName : unFoldColor}];
    // 折叠
    NSAttributedString *foldAttrStr = [[NSMutableAttributedString alloc] initWithString:foldString attributes:@{NSFontAttributeName : unFoldFont, NSForegroundColorAttributeName : unFoldColor}];
    
    // 样式
    ZJUnFoldParagraphStyle *paragraphStyle = (lineSpacing > 0.0f) ? [ZJUnFoldParagraphStyle initWithLineSpacing:lineSpacing] : nil;
    
    return [self initWithContentAttrStr:contentAttrStr unFoldAttrStr:unFoldAttrStr foldAttrStr:foldAttrStr paragraphStyle:paragraphStyle];
}

/**
 * 根据内容、展开、折叠属性字符串、段落样式生成一个属性字符串
 */
- (instancetype)initWithContentAttrStr:(NSAttributedString *)contentAttrStr
                         unFoldAttrStr:(NSAttributedString *)unFoldAttrStr
                           foldAttrStr:(NSAttributedString *)foldAttrStr
                        paragraphStyle:(ZJUnFoldParagraphStyle *)paragraphStyle
{
    NSParameterAssert(contentAttrStr);
    NSParameterAssert(unFoldAttrStr);
    NSParameterAssert(foldAttrStr);
    
    self = [super init];
    if (self) {
        _contentAttributedString = [contentAttrStr copy];
        _unFoldAttributedString = [unFoldAttrStr copy];
        _foldAttributedString = [foldAttrStr copy];
        _paragraphStyle = [paragraphStyle copy];
    }
    return self;
}

@end
