//
//  FAN_ScreenShotAnimationCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_ScreenShotAnimationCell.h"

@interface FAN_ScreenShotAnimationCell()

@property (nonatomic,strong)UIImageView *imageV;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIButton *switchBtn;


@end

@implementation FAN_ScreenShotAnimationCell


- (void)addChildView{
    
    self.contentView.backgroundColor = [UIColor fan_randomColor];
    
    self.titleLabel = [UILabel fan_labelWithText:@"截图动画" font:15 textColorStr:@"0x000000"];
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

    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(70);
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(10);
    }];
    
    self.switchBtn = [UIButton buttonWithType:0];
    [self.contentView addSubview:self.switchBtn];
    
    [self.switchBtn setTitle:@"截图" forState:UIControlStateNormal];
    [self.switchBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.switchBtn setBackgroundColor:[UIColor fan_randomColor]];
    [self.switchBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
}

- (void)actionBtn:(UIButton *)sender {
    
    [self performAnimation];
}

- (void)performAnimation{
    UIGraphicsBeginImageContextWithOptions(self.contentView.bounds.size, YES, 0.0);
    [self.contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.contentView.bounds;
    [self.contentView addSubview:coverView];
    
    //使用自定义方法得到随机颜色(切换后的颜色)
    UIColor *randomColor = [UIColor fan_randomColor];
    self.contentView.backgroundColor = randomColor;
    
    //使用UIView动画方法来代替属性动画(为了简化代码步骤)
    [UIView animateWithDuration:1 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
 }

+ (CGFloat)cellHeight{
    
    return 120;
}


@end
