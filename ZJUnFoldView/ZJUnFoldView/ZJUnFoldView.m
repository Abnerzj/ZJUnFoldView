//
//  ZJUnFoldView.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ZJUnFoldView.h"
#import "ZJUnFoldView+Untils.h"
#import "ZJUnFoldAttributedString.h"
#import "ZJUnFoldParagraphStyle.h"

@implementation ZJUnFoldLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfLines = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface ZJUnFoldButton ()

/** 属性字符串 */
@property (nonatomic, strong) NSAttributedString *attributedString;

@end

@implementation ZJUnFoldButton

- (void)setAttributedString:(NSAttributedString *)attributedString
{
    _attributedString = attributedString;
    
    NSRange range = NSMakeRange(0, attributedString.length);
    NSDictionary *attrDict = [attributedString attributesAtIndex:0 effectiveRange:&range];
    [self setTitle:attributedString.string forState:UIControlStateNormal];
    [self setTitleColor:[attrDict objectForKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [self setTitleColor:[attrDict objectForKey:NSForegroundColorAttributeName] forState:UIControlStateHighlighted];
    [self.titleLabel setFont:[attrDict objectForKey:NSFontAttributeName]];
    
    [self layoutIfNeeded];
}

@end

@interface ZJUnFoldView ()
{
    ZJUnFoldLabel *_unFoldLabel;        /**< 内容标签 */
    ZJUnFoldButton *_unFoldButton;      /**< 展开/折叠按钮 */
    
    BOOL _isUnFold;                     /**< 是否展开，YES展开，NO收回 */
    BOOL _isMutilLine;                  /**< 是否有多行 */
    BOOL _isSurpassFoldLine;            /**< 内容行数是否超过折叠时显示的行数 */
    BOOL _isAddOneLine;                 /**< 是否添加一行用于显示展开按钮 */
    BOOL _isFoldLinesMoreOne;           /**< 折叠时显示行数是否大于一行 */
    CGFloat _foldLabelH;                /**< 折叠时Label高度 */
    CGFloat _foldLabelW;                /**< 折叠时Label宽度 */
    CGFloat _unFoldLabelH;              /**< 展开时Label高度 */
    CGFloat _unFoldLabelW;              /**< 展开时Label宽度 */
    CGFloat _foldButtonX;               /**< 折叠时Button位置X */
    CGFloat _foldButtonY;               /**< 折叠时Button位置Y */
    CGFloat _foldButtonW;               /**< 折叠时Button宽度 */
    CGFloat _foldButtonH;               /**< 折叠时Button高度 */
    CGFloat _unFoldButtonX;             /**< 展开时Button位置X */
    CGFloat _unFoldButtonY;             /**< 展开时Button位置Y */
    CGFloat _unFoldButtonW;             /**< 展开时Button宽度 */
    CGFloat _unFoldButtonH;             /**< 展开时Button高度 */
    CGFloat _lineSpacing;               /**< 段落间距 */
    CGFloat _maxWidth;                  /**< 最大宽度 */
    
    NSAttributedString *_buttonFoldAttributedString;     /**< 展开按钮：折叠时的属性字符串 */
    NSAttributedString *_buttonUnFoldAttributedString;   /**< 展开按钮：展开时的属性字符串 */
    NSAttributedString *_labelFoldLinesMoreOneAttrStr;   /**< 内容：折叠时显示行数大于一行时处理过的属性字符串 */
    NSAttributedString *_labelUnFoldAllLinesAttrStr;     /**< 内容：展开时所有行的属性字符串 */
}

@end

@implementation ZJUnFoldView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isUnFold = NO;
        _isMutilLine = NO;
        _isSurpassFoldLine = NO;
        _isAddOneLine = NO;
        _isFoldLinesMoreOne = NO;
        _foldLabelH = 0.0f;
        _foldLabelW = 0.0f;
        _unFoldLabelH = 0.0f;
        _unFoldLabelW = 0.0f;
        _foldButtonX = 0.0f;
        _foldButtonY = 0.0f;
        _foldButtonW = 0.0f;
        _foldButtonH = 0.0f;
        _unFoldButtonX = 0.0f;
        _unFoldButtonY = 0.0f;
        _unFoldButtonW = 0.0f;
        _unFoldButtonH = 0.0f;
        _lineSpacing = 0.0f;
        _maxWidth = 0.0f;
        _buttonFoldAttributedString = nil;
        _buttonUnFoldAttributedString = nil;
        _labelFoldLinesMoreOneAttrStr = nil;
        _labelUnFoldAllLinesAttrStr = nil;
    }
    return self;
}

/**
 * 添加子视图
 */
- (void)addSubViews
{
    // 内容标签
    _unFoldLabel = [[ZJUnFoldLabel alloc] init];
    [self addSubview:_unFoldLabel];
    
    // 多行 或者 内容行数超过折叠时显示的行数 时才添加展开按钮
    if (_isMutilLine || _isSurpassFoldLine) {
        _unFoldButton = [[ZJUnFoldButton alloc] init];
        [_unFoldButton addTarget:self action:@selector(unFoldAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_unFoldButton];
    }
}

/**
 * 根据属性字符串和最大宽度获取展开视图，此构造方法适用于纯代码实例化场景
 */
- (instancetype)initWithAttributedString:(ZJUnFoldAttributedString *)unFoldAttrStr
                                maxWidth:(CGFloat)maxWidth
                         isDefaultUnFold:(BOOL)isDefaultUnFold
                             foldLines:(NSUInteger)foldLines
                                location:(UnFoldButtonLocation)location
{
    self = [super init];
    if (self) {
        [self addSubViewsAndPackSetAttributes:unFoldAttrStr maxWidth:maxWidth isDefaultUnFold:isDefaultUnFold foldLines:foldLines location:location];
    }
    return self;
}

/**
 * 添加子控件并包装设置属性，此方法适用于用xib和storyboard实例化场景
 */
- (void)addSubViewsAndPackSetAttributes:(ZJUnFoldAttributedString *)unFoldAttrStr
                               maxWidth:(CGFloat)maxWidth
                        isDefaultUnFold:(BOOL)isDefaultUnFold
                            foldLines:(NSUInteger)foldLines
                               location:(UnFoldButtonLocation)location
{
    // 1.Assert
    NSParameterAssert(unFoldAttrStr);
    NSParameterAssert(maxWidth > 0.0f);
    NSParameterAssert(foldLines > 0);
    
    // 2.Mark variable
    _maxWidth = maxWidth;
    _isUnFold = !isDefaultUnFold;  // 取反，后面主动调用一次展开按钮
    _lineSpacing = unFoldAttrStr.paragraphStyle.lineSpacing;
    _isFoldLinesMoreOne = (foldLines > 1);
    
    // 3.Get Temp AttributedString Variable
    // 内容属性字符串
    NSAttributedString *contentAttributedString = [unFoldAttrStr.contentAttributedString copy];
    // 展开按钮（展开时）属性字符串
    _buttonUnFoldAttributedString = [unFoldAttrStr.unFoldAttributedString copy];
    // 展开按钮（折叠时）属性字符串
    _buttonFoldAttributedString = [unFoldAttrStr.foldAttributedString copy];
    // 临时内容属性字符串
    NSMutableAttributedString *tempContentAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:contentAttributedString];
    
    // 4.行数
    NSUInteger lineCount = [ZJUnFoldView getLineCountFromAttrStr:contentAttributedString maxWidth:maxWidth];
    _isMutilLine = (lineCount > 1);
    if (_isMutilLine) { // 4.1 有多行
        
        // 4.1.1 添加段落样式
        if (unFoldAttrStr.paragraphStyle) {
            [tempContentAttributedString addAttribute:NSParagraphStyleAttributeName value:unFoldAttrStr.paragraphStyle range:NSMakeRange(0, [tempContentAttributedString length])];
        }
        
        // 4.1.2 内容行数超过折叠时显示的行数
        _isSurpassFoldLine = (lineCount > foldLines);
        if (_isSurpassFoldLine)
        {
            // 4.1.2.1 展开、折叠按钮的Size
            CGSize unFoldBtnSize = [ZJUnFoldView attributedStringSize:_buttonUnFoldAttributedString maxWidth:maxWidth];
            CGSize foldBtnSize = [ZJUnFoldView attributedStringSize:_buttonFoldAttributedString maxWidth:maxWidth];
            _unFoldButtonW = unFoldBtnSize.width;
            _unFoldButtonH = unFoldBtnSize.height;
            _foldButtonW = foldBtnSize.width;
            _foldButtonH = foldBtnSize.height;

            // 4.1.2.2 折叠时显示行数的label的Frame
            CGRect foldLineRect = [ZJUnFoldView getLineNumRectFromAttrStr:contentAttributedString lineNum:foldLines isLastLine:NO maxWidth:maxWidth];
            _foldLabelH = CGRectGetMaxY(foldLineRect) + (unFoldAttrStr.paragraphStyle ? _isFoldLinesMoreOne ? (foldLines - 1) * _lineSpacing : _lineSpacing : 0.0f);
            
            // 4.1.2.3 展开时label的Frame
            CGRect unFoldLineRect = [ZJUnFoldView getLastLineRectFromAttrStr:contentAttributedString maxWidth:maxWidth];
            _unFoldLabelH = CGRectGetMaxY(unFoldLineRect) + (unFoldAttrStr.paragraphStyle ? (lineCount - 1) * _lineSpacing : 0.0f);
            
            // 4.1.2.4 宽度
            _foldLabelW = _isFoldLinesMoreOne ? maxWidth : maxWidth - _unFoldButtonW;
            _unFoldLabelW = maxWidth;
            
            // 4.1.2.5 展开、折叠按钮的位置
            _unFoldButtonX = maxWidth - _unFoldButtonW;
            _unFoldButtonY = _isFoldLinesMoreOne ? _foldLabelH - _unFoldButtonH : fabs(_foldLabelH - _unFoldButtonH) * 0.5;
            
            // 4.1.2.6 是否需要添加一行用于显示折叠按钮
            _isAddOneLine = unFoldLineRect.size.width + _foldButtonW > maxWidth;
            if (_isAddOneLine) {
                if (location == UnFoldButtonLocationRight) {
                    _foldButtonX = maxWidth - _foldButtonW;
                } else if (location == UnFoldButtonLocationMiddle) {
                    _foldButtonX = (maxWidth - _foldButtonW) * 0.5;
                } else {
                    _foldButtonX = 0.0f;
                }
                _foldButtonY = _unFoldLabelH + _lineSpacing;
            } else {
                _foldButtonX = unFoldLineRect.size.width;
                _foldButtonY = _unFoldLabelH - _foldButtonH;
            }
            
            // 4.1.2.7 记录展开时所有行的属性字符串
            _labelUnFoldAllLinesAttrStr = [tempContentAttributedString copy];
            
            // 4.1.2.8 处理折叠时最后一行
            if (_isFoldLinesMoreOne) {
                tempContentAttributedString = [ZJUnFoldView getLineNumBeforeAttrStingFromAttrStr:contentAttributedString lineNum:foldLines deleteStringLength:unFoldAttrStr.unFoldAttributedString.length maxWidth:maxWidth];
                if (unFoldAttrStr.paragraphStyle) {
                    [tempContentAttributedString addAttribute:NSParagraphStyleAttributeName value:unFoldAttrStr.paragraphStyle range:NSMakeRange(0, [tempContentAttributedString length])];
                }
                _labelFoldLinesMoreOneAttrStr = [tempContentAttributedString copy];
            }
        }
        else // 4.1.3 内容行数不超过折叠时显示的行数
        {
            // 4.1.3.1 展开的Size
            CGSize unFoldSize = [ZJUnFoldView attributedStringSize:contentAttributedString maxWidth:maxWidth];
            
            // 4.1.3.3 增加(lineCount - 1)个间距高度
            _foldLabelH = unFoldAttrStr.paragraphStyle ? (unFoldSize.height + (lineCount - 1) * _lineSpacing) : unFoldSize.height;
            _unFoldLabelH = _foldLabelH;
            
            // 4.1.3.4 宽度（用最大宽度）
            _foldLabelW = maxWidth;
            _unFoldLabelW = maxWidth;
            
            // 4.1.3.5 记录展开时所有行的属性字符串
            _labelUnFoldAllLinesAttrStr = [tempContentAttributedString copy];
        }
    }
    else // 4.2 只有一行
    {
        // 4.2.1 展开的Frame
        CGRect unFoldLineRect = [ZJUnFoldView getLastLineRectFromAttrStr:contentAttributedString maxWidth:maxWidth];
        
        // 4.2.2 宽度（用最后一行的宽度）
        _foldLabelW = unFoldLineRect.size.width;
        _unFoldLabelW = _foldLabelW;
        
        // 4.2.3 高度
        _foldLabelH = unFoldAttrStr.paragraphStyle ? (unFoldLineRect.size.height + _lineSpacing) : unFoldLineRect.size.height;
        _unFoldLabelH = _foldLabelH;
        
        // 4.2.4 记录展开时所有行的属性字符串
        _labelUnFoldAllLinesAttrStr = [tempContentAttributedString copy];
    }
    
    // 5.添加子视图
    [self addSubViews];
    
    // 6.默认点击一次展开按钮
    [self unFoldAction];
}

#pragma mark 展开/收回操作
- (void)unFoldAction
{
    _isUnFold = !_isUnFold;
    
    if (_unFoldActionBlock) {
        _unFoldActionBlock(_isUnFold);
    }
    
    _unFoldButton.attributedString = _isUnFold ? _buttonFoldAttributedString : _buttonUnFoldAttributedString;
    _unFoldLabel.attributedText = (!_isUnFold && _isSurpassFoldLine && _isFoldLinesMoreOne) ? _labelFoldLinesMoreOneAttrStr : _labelUnFoldAllLinesAttrStr;
    
    [self updateUnFoldViewFrame];
}

- (void)updateUnFoldViewFrame
{
    CGFloat selfH = 0.0f;
    if (_isUnFold) {
        _unFoldLabel.frame = CGRectMake(0, 0, _unFoldLabelW, _unFoldLabelH);
        _unFoldButton.frame = CGRectMake(_foldButtonX, _foldButtonY, _foldButtonW, _foldButtonH);
        selfH = _isAddOneLine ? CGRectGetMaxY(_unFoldButton.frame) : CGRectGetMaxY(_unFoldLabel.frame);
    } else {
        _unFoldLabel.frame = CGRectMake(0, 0, _foldLabelW, _foldLabelH);
        _unFoldButton.frame = CGRectMake(_unFoldButtonX, _unFoldButtonY, _unFoldButtonW, _unFoldButtonH);
        selfH = CGRectGetMaxY(_unFoldLabel.frame);
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _maxWidth, selfH);
}

@end
