//
//  ZJUnFoldView+Untils.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ZJUnFoldView+Untils.h"
#import <CoreText/CoreText.h>

@implementation ZJUnFoldView (Untils)

/**
 * 计算字符串所占大小
 */
+ (CGSize)stringSize:(NSString *)string maxWidth:(CGFloat)maxWidth
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/**
 * 计算属性字符串所占大小
 */
+ (CGSize)attributedStringSize:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth
{
    CGSize size = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

/**
 * 获取属性字符串最后一行的frame
 */
+ (CGRect)getLastLineRectFromAttrStr:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth
{
    return [self getLineNumRectFromAttrStr:attributedString lineNum:0 isLastLine:YES maxWidth:maxWidth];
}

/**
 * 获取属性字符串某一行的frame
 */
+ (CGRect)getLineNumRectFromAttrStr:(NSAttributedString *)attributedString lineNum:(NSUInteger)lineNum isLastLine:(BOOL)isLastLine maxWidth:(CGFloat)maxWidth
{
    __block CGFloat lineY = 0.0f;
    __block CGRect lineRect = CGRectZero;
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxWidth, MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    if (lines.count) {
        if (lineNum > lines.count) {
            return CGRectZero;
        }
        
        __block NSAttributedString *lineAttrStr = [[NSAttributedString alloc] init];
        NSUInteger index = isLastLine ? lines.count - 1 : lineNum - 1;
        [lines enumerateObjectsUsingBlock:^(id  _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx <= index) {
                CTLineRef lineRef = (__bridge CTLineRef )line;
                CFRange lineRange = CTLineGetStringRange(lineRef);
                NSRange range = NSMakeRange(lineRange.location, lineRange.length);
                
                lineAttrStr = [attributedString attributedSubstringFromRange:range];
                CGRect lineAttrRect = [lineAttrStr boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                
                if (idx == index) {
                    lineRect = CGRectMake(lineAttrRect.origin.x, lineY, lineAttrRect.size.width, lineAttrRect.size.height);
                    *stop = YES;
                } else {
                    lineY += lineAttrRect.size.height;
                }
            }
        }];
    }
    
    CFRelease(frameSetter);
    CFRelease(frame);
    CGPathRelease(path);

    return lineRect;
}

/**
 * 获取属性字符串某一行之前的所有字符串
 */
+ (NSMutableAttributedString *)getLineNumBeforeAttrStingFromAttrStr:(NSAttributedString *)attributedString
                                                     lineNum:(NSUInteger)lineNum
                                          deleteStringLength:(NSUInteger)deleteStringLength
                                                    maxWidth:(CGFloat)maxWidth
{
    __block NSMutableAttributedString *lineNumBeforeAttrSting = [[NSMutableAttributedString alloc] init];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxWidth, MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    if (lines.count) {
        if (lineNum > lines.count) {
            return nil;
        }
        
        __block NSAttributedString *lineAttrStr = [[NSAttributedString alloc] init];
        __block NSAttributedString *handlingLineAttrStr = [[NSAttributedString alloc] init];
        [lines enumerateObjectsUsingBlock:^(id  _Nonnull line, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx <= lineNum - 1) {
                CTLineRef lineRef = (__bridge CTLineRef )line;
                CFRange lineRange = CTLineGetStringRange(lineRef);
                NSRange range = NSMakeRange(lineRange.location, lineRange.length);
                
                lineAttrStr = [attributedString attributedSubstringFromRange:range];
                if (idx == lineNum - 1) {
                    handlingLineAttrStr = [lineAttrStr attributedSubstringFromRange:NSMakeRange(0, lineAttrStr.length - deleteStringLength)];
                    [lineNumBeforeAttrSting appendAttributedString:handlingLineAttrStr];
                    
                    NSRange appendRange = NSMakeRange(0, lineAttrStr.length);
                    NSAttributedString *appendStr = [[NSAttributedString alloc] initWithString:@"..." attributes:[attributedString attributesAtIndex:0 effectiveRange:&appendRange]];
                    [lineNumBeforeAttrSting appendAttributedString:appendStr];
                    *stop = YES;
                } else {
                    [lineNumBeforeAttrSting appendAttributedString:lineAttrStr];
                }
            }
        }];
    }
    
    CFRelease(frameSetter);
    CFRelease(frame);
    CGPathRelease(path);
    
    return lineNumBeforeAttrSting;
}

/**
 * 获取属性字符串行数
 */
+ (NSUInteger)getLineCountFromAttrStr:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth
{
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, maxWidth, MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    
    CFRelease(frameSetter);
    CFRelease(frame);
    CGPathRelease(path);
    
    return lines.count;
}

/**
 * 根据16进制字符串获取UIColor类型的颜色值
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor redColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor redColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location	= 0;
    range.length	= 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                         green		:((float)g / 255.0f)
                          blue		:((float)b / 255.0f)
                         alpha		:1.0f];
}

@end
