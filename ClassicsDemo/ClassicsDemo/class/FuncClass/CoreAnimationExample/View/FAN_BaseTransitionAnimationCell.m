//
//  FAN_BaseTransitionAnimationCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/19.
//

#import "FAN_BaseTransitionAnimationCell.h"

@interface FAN_BaseTransitionAnimationCell()

@property (nonatomic,strong)UIImageView *imageV;

@property (nonatomic,strong)UILabel *titleLabel;


@property (nonatomic,strong)UIButton *switchBtn;


@end

@implementation FAN_BaseTransitionAnimationCell


- (void)addChildView{
    
    self.contentView.backgroundColor = [UIColor fan_randomColor];
    
    self.titleLabel = [UILabel fan_labelWithText:@"转场动画" font:15 textColorStr:@"0x000000"];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(20);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];

    
    UIImageView *imageV = [UIImageView new];
    [self.contentView addSubview:imageV];
    [imageV setImage:[UIImage imageNamed:@"icon_1"]];
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
    
    [self.switchBtn setTitle:@"切换" forState:UIControlStateNormal];
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
    
    static int name = 1;
    name++;
       if (name == 4) {
           name = 1;
       }
       NSString *imgName = [NSString stringWithFormat:@"icon_%d",name];
       self.imageV.image = [UIImage imageNamed:imgName];
       
       CATransition *anima = [CATransition animation];
       anima.duration = 1.0;
       /** 动画效果有:
        @"fade":交叉淡化过渡
        @"push":推动效果
        @"moveIn":移动效果
        @"cube":立体翻滚
        @"oglFlip":上下左右翻滚
        @"suckEffect":收缩效果，被抽走
        @"rippleEffect":水滴效果
        @"pageCurl":向上翻页
        @"pageUnCurl":向下翻页
        @"cameraIrisHollowOpen":相机镜头打开效果
        @"cameraIrisHollowClose":相机镜头关闭效果
        */
       
       anima.type = @"cube";
       //    //设置动画的起始位置
       //    anim.startProgress = 0.3;
       //    //设置动画的结束位置
       //    anim.endProgress = 0.5;
       
       [self.imageV.layer addAnimation:anima forKey:nil];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}

+ (CGFloat)cellHeight{
    
    return 120;
}

@end
