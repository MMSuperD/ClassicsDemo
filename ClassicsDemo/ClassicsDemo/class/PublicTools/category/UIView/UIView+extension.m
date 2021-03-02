//
//  UIView+extension.m
//  ModuleTest_Example
//
//  Created by xzmac on 2021/2/7.
//  Copyright © 2021 王丹. All rights reserved.
//

#import "UIView+extension.h"
#import <objc/runtime.h>
typedef  void(^TapBlock)(UIView *tapView);

@interface UIView()

@property (nonatomic,copy)TapBlock tapBlock;

@end

@implementation UIView (extension)


- (void)tapClick:(void (^)(UIView * _Nonnull))tapBlock{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    [self addGestureRecognizer:tap];
    self.tapBlock = tapBlock;
}

- (void)actionTap:(UITapGestureRecognizer *)tap{
    UIView *tapView = tap.view;
    if (self.tapBlock) {
        self.tapBlock(tapView);
    }
}

- (void)setTapBlock:(TapBlock)tapBlock{
//    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(self), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
- (TapBlock)tapBlock{
//    return objc_getAssociatedObject(self, _cmd);
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(self));
}





@end

