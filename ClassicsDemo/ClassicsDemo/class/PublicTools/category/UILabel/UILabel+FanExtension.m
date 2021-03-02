//
//  UILabel+FanExtension.m
//  ModuleTest_Example
//
//  Created by xzmac on 2021/2/26.
//  Copyright © 2021 王丹. All rights reserved.
//

#import "UILabel+FanExtension.h"
#import "UIColor+FanExtension.h"

@implementation UILabel (FanExtension)

+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font{
    return [self fan_labelWithText:text font:font textColor:nil typeFace:nil textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)color{
    return [self fan_labelWithText:text font:font textColor:color typeFace:nil textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font hexColor:(uint32_t)hexColor{
    UIColor *color = [UIColor fan_colorWithHex:hexColor];
    return [self fan_labelWithText:text font:font textColor:color typeFace:nil textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font textColorStr:(NSString *)colorStr{
    UIColor *color = [UIColor fan_colorWithHexString:colorStr];
    return [self fan_labelWithText:text font:font textColor:color typeFace:nil textAlignment:NSTextAlignmentLeft];
}

+ (instancetype)fan_labelWithText:( NSString * __nullable)text font:( CGFloat)font textColor:(UIColor * __nullable)color typeFace:(NSString * __nullable)typeFaceName textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [UILabel new];
    
    if (text) {
        label.text = text;
    } else{
        label.text = @"等待初始化中...";
    }
    
    if (font > 0) {
        label.font = [UIFont systemFontOfSize:font];
    } else {
        label.font = [UIFont systemFontOfSize:12];
    }
    
    if (color) {
        label.textColor = color;
    } else {
        label.textColor = [UIColor blackColor];
    }
    
    if (font > 0 && typeFaceName) {
        [label setFont:[UIFont fontWithName:typeFaceName size:font]];
    } else{
        [label setFont:[UIFont fontWithName:@"MicrosoftYaHei" size:12]]; //兰亭雅黑
    }

    if (textAlignment) {
        label.textAlignment = textAlignment;
    } else {
        label.textAlignment = NSTextAlignmentCenter;
    }
    return label;
}

@end
