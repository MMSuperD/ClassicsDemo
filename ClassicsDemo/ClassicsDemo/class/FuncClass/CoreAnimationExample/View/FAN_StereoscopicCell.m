//
//  FAN_ StereoscopicCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_StereoscopicCell.h"

@implementation FAN_StereoscopicCell

- (void)addChildView{
    
    [self transform3DDemo];
}

- (void)transform3DDemo{
    
    
    CATransformLayer *cubeLayer = [CATransformLayer layer];
    
    CATransform3D ct = CATransform3DIdentity;
    
    //1.
    ct = CATransform3DMakeTranslation(0, 0, 50);
    [cubeLayer addSublayer:[self createLayerTransfrom:ct]];
    
    //2.
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self createLayerTransfrom:ct]];
    
    //3.
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubeLayer addSublayer:[self createLayerTransfrom:ct]];
    
    //4.
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubeLayer addSublayer:[self createLayerTransfrom:ct]];
    
    //5.
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self createLayerTransfrom:ct]];
    
    //6.
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cubeLayer addSublayer:[self createLayerTransfrom:ct]];

    cubeLayer.position = CGPointMake(SCREEN_WIDTH_FAN / 2.0, 200/2.0);
    cubeLayer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0);
    
    

    [self.contentView.layer addSublayer:cubeLayer];

    
}

- (CALayer *)createLayerTransfrom:(CATransform3D)transfrom {
    
    CALayer *layer = [CALayer layer];
    
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.backgroundColor = [UIColor fan_randomColor].CGColor;
    layer.transform = transfrom;
    
    return layer;
}


+ (CGFloat)cellHeight{
    
    return 200;
}

@end
