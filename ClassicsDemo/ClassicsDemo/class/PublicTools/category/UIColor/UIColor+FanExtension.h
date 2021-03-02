//
//  UIColor+FanExtension.h
//  ModuleTest_Example
//
//  Created by xzmac on 2021/2/26.
//  Copyright © 2021 王丹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FanExtension)

+ (instancetype)fan_colorWithHex:(uint32_t)hex;
+ (instancetype)fan_colorWithR:(int)red G:(int)green B:(int)blue alpha:(float)alpha;
+ (instancetype)fan_randomColor;
+ (instancetype)fan_colorWithHexString: (NSString *)color;

@end

NS_ASSUME_NONNULL_END
