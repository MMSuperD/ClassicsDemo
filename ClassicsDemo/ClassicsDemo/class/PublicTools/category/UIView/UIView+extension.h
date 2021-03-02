//
//  UIView+extension.h
//  ModuleTest_Example
//
//  Created by xzmac on 2021/2/7.
//  Copyright © 2021 王丹. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (extension)

/**
 View的点击事件，通过UITapGestureRecognizer 实现的
 */
- (void)tapClick:(void(^)(UIView *clickView))tapView;

@end

NS_ASSUME_NONNULL_END
