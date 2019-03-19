//
//  ZJUnFoldParagraphStyle.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ZJUnFoldParagraphStyle.h"

@implementation ZJUnFoldParagraphStyle

/**
 * 根据行间距和行前间距设置段落样式
 */
+ (instancetype)initWithLineSpacing:(CGFloat)lineSpacing
{
    ZJUnFoldParagraphStyle *paragraphStyle = [[ZJUnFoldParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    return paragraphStyle;
}

@end
