//
//  FAN_TransitionViewController.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import <FANOCBaseConfig/FANOCBaseConfig.h>
#import "FAN_CircleTransition.h"


NS_ASSUME_NONNULL_BEGIN

@interface FAN_TransitionViewController : FAN_BaseViewController<UINavigationControllerDelegate>

@property (nonatomic,strong)UIButton *circleBtn;

- (void)actionBtn:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
