//
//  UILabel+FanExtension.h
//  ModuleTest_Example
//
//  Created by xzmac on 2021/2/26.
//  Copyright © 2021 王丹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FanExtension)

+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font;
+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font textColor:(UIColor *)color;
+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font hexColor:(uint32_t)hexColor;
+ (instancetype)fan_labelWithText:(NSString *)text font:(CGFloat)font textColorStr:(NSString *)colorStr;
+ (instancetype)fan_labelWithText:( NSString * __nullable)text font:( CGFloat)font textColor:(UIColor * __nullable)color typeFace:(NSString * __nullable)typeFaceName textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
