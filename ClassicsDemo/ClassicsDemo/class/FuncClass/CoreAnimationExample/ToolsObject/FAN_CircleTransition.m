//
//  FAN_CircleTransition.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_CircleTransition.h"
#import "FAN_TransitionView2Controller.h"

@interface FAN_CircleTransition()<CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> context;


@end

@implementation FAN_CircleTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.context = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //添加动画
    FAN_TransitionViewController *VC1 = nil,*VC2 = nil;
    UIButton *btn = nil;
    if (_isPush) {
        VC1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        VC2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = VC1.circleBtn;

    }else{
        VC2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        VC1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = VC2.circleBtn;

    }
    
    [containerView addSubview:VC1.view];
    [containerView addSubview:VC2.view];
        
    // 这个是小圆
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CGPoint centerP;
    centerP = btn.center;
    
    
    //画大圆
    CGFloat radius = sqrtf(SCREEN_WIDTH_FAN * SCREEN_WIDTH_FAN + SCREEN_HEIGHT_FAN * SCREEN_HEIGHT_FAN);
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    if (_isPush) {
        shapeLayer.path = bigPath.CGPath;

    }else{
        shapeLayer.path = smallPath.CGPath;

    }
    
    
    //9.添加蒙板
    UIViewController *VC;
    if (_isPush) {
        VC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }else{
        VC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    VC.view.layer.mask = shapeLayer;
    
    
    //10.给layer添加动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    if (_isPush) {
        anim.fromValue = (id)smallPath.CGPath;

    }else{
        anim.fromValue = (id)bigPath.CGPath;

    }
    anim.duration = [self transitionDuration:transitionContext];
    anim.delegate = self;
    
    [shapeLayer addAnimation:anim forKey:nil];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 1;
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
    if (_isPush) {
        UIViewController *tovc = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
        tovc.view.layer.mask = nil;
    }else{
        UIViewController *tovc = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        tovc.view.layer.mask = nil;
    }
   
}

@end
