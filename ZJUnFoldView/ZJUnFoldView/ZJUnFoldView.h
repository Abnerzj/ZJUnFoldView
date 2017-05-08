//
//  ZJUnFoldView.h
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJUnFoldAttributedString.h"

@interface ZJUnFoldLabel : UILabel
@end

@interface ZJUnFoldButton : UIButton
@end

/**
 * 展开按钮展开后位置
 * @discussion
 * 1.文字处于收回状态时，展开按钮处于最后一行的右侧
 * 2.文字处于展开状态时，默认情况展开按钮紧跟文字最后一个字符的右侧位置，如果该行显示不下，则展开按钮放到文字最后一行下一行的位置
 */
typedef enum : NSUInteger {
    UnFoldButtonLocationLeft,         /**< 左边 */
    UnFoldButtonLocationMiddle,       /**< 中间 */
    UnFoldButtonLocationRight,        /**< 右边 */
} UnFoldButtonLocation;

@interface ZJUnFoldView : UIView

/** 展开/收回操作 */
@property (nonatomic, copy) void(^unFoldActionBlock)(BOOL isUnFold);

/**
 根据属性字符串和最大宽度获取展开视图，此构造方法适用于纯代码实例化场景
 
 @param unFoldAttrStr 属性字符串
 @param maxWidth 最大宽度
 @param isDefaultUnFold 是否默认展开
 @param foldLines 未展开时多少行
 @param location 展开按钮展开后位置
 @return 展开视图
 */
- (instancetype)initWithAttributedString:(ZJUnFoldAttributedString *)unFoldAttrStr
                                maxWidth:(CGFloat)maxWidth
                         isDefaultUnFold:(BOOL)isDefaultUnFold
                               foldLines:(NSUInteger)foldLines
                                location:(UnFoldButtonLocation)location;

/**
 添加子控件并包装设置属性，此方法适用于用xib和storyboard实例化场景
 
 @param unFoldAttrStr 属性字符串
 @param maxWidth 最大宽度
 @param isDefaultUnFold 是否默认展开
 @param foldLines 未展开时最多展示多少行（比如有5行不展开是最多只展示3行）
 @param location 展开按钮展开后位置
 */
- (void)addSubViewsAndPackSetAttributes:(ZJUnFoldAttributedString *)unFoldAttrStr
                               maxWidth:(CGFloat)maxWidth
                        isDefaultUnFold:(BOOL)isDefaultUnFold
                              foldLines:(NSUInteger)foldLines
                               location:(UnFoldButtonLocation)location;

@end
