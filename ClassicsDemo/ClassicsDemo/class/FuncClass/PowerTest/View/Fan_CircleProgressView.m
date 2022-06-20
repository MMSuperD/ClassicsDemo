//
//  Fan_CircleProgressView.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/20.
//

#import "Fan_CircleProgressView.h"

@interface Fan_CircleProgressView()

@property (nonatomic,strong)CAShapeLayer *bgLayer;

@property (nonatomic,strong)CAShapeLayer *circleLayer;


@property (nonatomic,strong)CAGradientLayer *leftLayer;


@property (nonatomic,strong)CAGradientLayer *rightLayer;

@property (nonatomic,strong)UIBezierPath *circlePath;

@property (nonatomic,strong)UIBezierPath *circlePath2;


@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *valueLabel;

@end

@implementation Fan_CircleProgressView


- (void)setTileString:(NSString *)title value:(NSString *)value{
    
    self.titleLabel.text = title;
    
    self.valueLabel.text = value;
    
}

- (void)setValue:(CGFloat )value{
    _value = value;
    
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f",value];
}

- (void)addChildView{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_centerY).mas_offset(0);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_centerY).mas_offset(0);
    }];
    
}


- (void)drawRect:(CGRect)rect{
    
    //贝塞尔曲线画圆弧
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - 20)/2 startAngle: 3 * M_PI / 4 endAngle:1 * M_PI / 4 clockwise:YES];
    
    self.bgLayer.frame = self.bounds;
    self.bgLayer.fillColor = [UIColor clearColor].CGColor;//填充色 -  透明
    self.bgLayer.lineWidth = 10.f;
    self.bgLayer.strokeColor = [UIColor grayColor].CGColor;//线条颜色
    self.bgLayer.strokeStart = 0;//起始点
    self.bgLayer.strokeEnd = 1;//终点
    self.bgLayer.lineCap = kCALineCapRound;//让线两端是圆滑的状态
    self.bgLayer.path = circlePath.CGPath;//这里就是把背景的路径设为之前贝塞尔曲线的那个路径
    
    
  
    self.circleLayer.frame = self.bounds;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;//填充色 -  透明
    self.circleLayer.lineWidth = 10.f;
    self.circleLayer.strokeColor = [UIColor blueColor].CGColor;//线条颜色
    self.circleLayer.strokeStart = 0;//起始点
    self.circleLayer.strokeEnd = 1;//终点
    self.circleLayer.lineCap = kCALineCapRound;//让线两端是圆滑的状态
    self.circleLayer.path = [self createPathStartAngle:3 * M_PI / 4 endAngle:[self endAngle]].CGPath;//这里就是把背景的路径设为之前贝塞尔曲线的那个路径
    
    //ZCCRGBColor是我自定义的宏
#define RGBColor(a,b,c,al) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:al]
    [self.leftLayer setColors:[NSArray arrayWithObjects:(id)RGBColor(255, 255, 0, 1).CGColor, (id)RGBColor(255, 0, 0, 1).CGColor, nil]];
    [self.leftLayer setLocations:@[@0,@(1)]];
   //下面这两个就是渐变色方向Y越大就是越下面 所以是从下到上从黄到红渐变
    [self.leftLayer setStartPoint:CGPointMake(0, 1)];
    [self.leftLayer setEndPoint:CGPointMake(1, 0)];
    self.leftLayer.frame = CGRectMake(0, 0, self.width, self.height);
    
    
    [self.leftLayer setMask:self.circleLayer];

}

- (CGFloat)endAngle{
    
    return (M_PI + M_PI_2) / 100.0 * self.value +(3 * M_PI / 4);
    
}


- (UIBezierPath *)createPathStartAngle:(CGFloat)starAngle endAngle:(CGFloat)endAngle {
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - 20)/2 startAngle: starAngle endAngle:endAngle clockwise:YES];
    
    return circlePath;
}

- (CAShapeLayer *)bgLayer{
    
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_bgLayer];

    }
    return _bgLayer;
}

- (CAShapeLayer *)circleLayer{
    
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_circleLayer];

    }
    return _circleLayer;
}

- (CAGradientLayer *)leftLayer{
    
    if (!_leftLayer) {
        _leftLayer = [CAGradientLayer layer];
        [self.layer addSublayer:_leftLayer];

    }
    return _leftLayer;
}

- (CAGradientLayer *)rightLayer{
    
    if (!_rightLayer) {
        _rightLayer = [CAGradientLayer layer];
        [self.layer addSublayer:_rightLayer];
    }
    return _rightLayer;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel fan_labelWithText:@"CPU" font:15 textColorStr:@"#000000"];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel fan_labelWithText:@"13%" font:15 textColorStr:@"#ff0000"];
        [self addSubview:_valueLabel];

    }
    return _valueLabel;
}

@end
