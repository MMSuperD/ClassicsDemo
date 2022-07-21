//
//  FAN_BaseGroupAnimationCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/19.
//

#import "FAN_BaseGroupAnimationCell.h"

@interface FAN_BaseGroupAnimationCell()

@property (nonatomic,strong)UIImageView *imageV;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIBezierPath * path;

@end

@implementation FAN_BaseGroupAnimationCell



- (void)addChildView{
    
    self.contentView.backgroundColor = [UIColor fan_randomColor];
    
    self.titleLabel = [UILabel fan_labelWithText:@"group动画" font:15 textColorStr:@"0x000000"];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(20);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];

    
    UIImageView *imageV = [UIImageView new];
    [self.contentView addSubview:imageV];
    [imageV setImage:[UIImage imageNamed:@"icon_ heart"]];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV = imageV;
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).mas_offset(-60);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UIBezierPath * path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH_FAN/2.0, 60) radius:50 startAngle:0 endAngle:2*M_PI clockwise:1];
    self.path = path;
    
    [self addAnimation];
    
    
}

- (void)drawRect:(CGRect)rect{
    
    CAShapeLayer *layer = [CAShapeLayer new];
       
    layer.lineWidth = 5;//这里是layer的宽度
        //圆环的颜色
        layer.strokeColor = [UIColor redColor].CGColor;
        //背景填充色
        layer.fillColor = [UIColor clearColor].CGColor;
     
     
     [self.path closePath];//在下面这行代码前加这个方法是封闭的图形
       layer.path = [self.path CGPath];//把贝塞尔画的路径赋值给图形层

    //[path closePath];//这里加是开放的图形
        
    [self.contentView.layer addSublayer:layer];//添加到父图层
    
    
    
}

- (void)addAnimation{
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    
    CABasicAnimation *anim = [CABasicAnimation new];
    anim.keyPath = @"transform.rotation";
    anim.byValue =@(2*M_PI*10);
    
    
    CAKeyframeAnimation *anim1=[[CAKeyframeAnimation alloc] init];
        anim1.keyPath = @"position";
        UIBezierPath * path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH_FAN/2.0, 60) radius:50 startAngle:0 endAngle:2*M_PI clockwise:1];
        anim1.path = path.CGPath;
        group.animations=@[anim,anim1];
        group.duration = 3;
        group.repeatCount = INT_MAX; // 重复的次数
 
    [self.imageV.layer addAnimation:group forKey:nil];
}


+ (CGFloat)cellHeight{
    
    return 120;
}

- (void)dealloc{
    
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
}


@end
