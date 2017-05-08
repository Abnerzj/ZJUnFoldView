//
//  ZJUnFoldParagraphStyle.h
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJUnFoldParagraphStyle : NSMutableParagraphStyle

/**
 根据行间距和行前间距设置段落样式
 
 @param lineSpacing 行间距
 @return 段落样式
 */
+ (instancetype)initWithLineSpacing:(CGFloat)lineSpacing;

@end
