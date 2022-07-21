//
//  FAN_TextLayerCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_TextLayerCell.h"
#import <CoreText/CoreText.h>


@implementation FAN_TextLayerCell

- (void)addChildView{
    
    [self textLayer];
    
//    [self shapeLayer];
}

- (void)textLayer{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(100, 10, 200, 50);
    textLayer.backgroundColor = [UIColor orangeColor].CGColor;
//    textLayer.string = @"hello world";
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.fontSize = [UIFont systemFontOfSize:20.0].pointSize;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    [self.contentView.layer addSublayer:textLayer];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"hello world"];
    NSDictionary *attribs = @{(id)kCTForegroundColorAttributeName: (id)[UIColor redColor].CGColor};
    [str setAttributes:attribs range:NSMakeRange(0, 5)];
    textLayer.string = str;
    
}

// 这个是火柴人
- (void)shapeLayer{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = nil;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    [self.contentView.layer addSublayer:shapeLayer];
    
}

+ (CGFloat)cellHeight{
    
    return 120;
}

@end
