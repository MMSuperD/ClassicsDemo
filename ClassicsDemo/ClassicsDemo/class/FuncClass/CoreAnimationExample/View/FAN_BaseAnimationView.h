//
//  FAN_BaseAnimationView.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/19.
//

#import <FANOCBaseConfig/FANOCBaseConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAN_BaseAnimationView : FAN_BaseView


+ (FAN_BaseAnimationView *)animationView;

- (void)stopAnimation;

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
