//
//  FAN_BaseAnimationCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/19.
//

#import "FAN_BaseAnimationHeartCell.h"

@interface FAN_BaseAnimationHeartCell()

@property (nonatomic,strong)UIImageView *imageV;

@property (nonatomic,strong)UIImageView *shakeImageV;

@property (nonatomic,strong)UILabel *titleLabel;



@end

@implementation FAN_BaseAnimationHeartCell


- (void)addChildView{
    
    self.contentView.backgroundColor = [UIColor fan_randomColor];
    
    self.titleLabel = [UILabel fan_labelWithText:@"基础动画" font:15 textColorStr:@"0x000000"];
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
    [self heartAnimation];
    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(70);
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(10);
    }];
    
    
    UIImageView *shakeImageV = [UIImageView new];
    [self.contentView addSubview:shakeImageV];
    [shakeImageV setImage:[UIImage imageNamed:@"icon_ heart"]];
    shakeImageV.contentMode = UIViewContentModeScaleAspectFit;
    self.shakeImageV = shakeImageV;
    
    [self imgaeShake];
    
    [self.shakeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(70);
        make.leading.mas_equalTo(self.imageV.mas_trailing).mas_offset(10);
    }];
}

- (void)heartAnimation{
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.scale";
    anima.toValue = @0.5;
    anima.repeatCount = MAXFLOAT;
    anima.duration = 0.3;
    anima.autoreverses = YES;
    [self.imageV.layer addAnimation:anima forKey:nil];
}

#define angleValue(angle) ((angle) * M_PI / 180.0)//角度数值转换宏
- (void)imgaeShake{
   
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.values = @[@(angleValue(-5)),@(angleValue(5)),@(angleValue(-5))];
    anima.repeatCount = MAXFLOAT;
    [self.shakeImageV.layer addAnimation:anima forKey:nil];
}

+ (CGFloat)cellHeight{
    
    return 120;
}



@end
