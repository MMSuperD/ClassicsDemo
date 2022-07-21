//
//  FAN_CurveAnimationCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_CurveAnimationCell.h"

@implementation FAN_CurveAnimationCell


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
}


- (void)addChildView{
    
    [self test];
}

- (void)test{
   
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 60)];
    /**
     endPoint
     The end point of the curve.

     controlPoint1
     The first control point to use when computing the curve.

     controlPoint2
     The second control point to use when computing the curve.

     */
    [path addCurveToPoint:CGPointMake(SCREEN_WIDTH_FAN - 60, 60) controlPoint1:CGPointMake(100, 20) controlPoint2:CGPointMake(SCREEN_WIDTH_FAN / 2  + 50, 100)];
    
    CAShapeLayer *shapeLyaer = [CAShapeLayer layer];
    shapeLyaer.path = path.CGPath;
    shapeLyaer.fillColor = nil;
    shapeLyaer.strokeColor = [UIColor redColor].CGColor;
    [self.contentView.layer addSublayer:shapeLyaer];
    
    CALayer *carLayer = [CALayer layer];
    carLayer.frame = CGRectMake(15, 50, 36, 36);
    carLayer.contents = (id)[UIImage imageNamed:@"car"].CGImage;
    carLayer.anchorPoint = CGPointMake(0.5, 0.8);
    [self.contentView.layer addSublayer:carLayer];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.duration = 4.0;
    anim.rotationMode = kCAAnimationRotateAuto;
    [carLayer addAnimation:anim forKey:nil];
}

+ (CGFloat)cellHeight{
    
    return 120;
}


@end
