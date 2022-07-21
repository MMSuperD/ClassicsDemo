//
//  FAN_BaseAnimationView.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/19.
//

#import "FAN_BaseAnimationView.h"

@implementation FAN_BaseAnimationView

+ (FAN_BaseAnimationView *)animationView{
    
    FAN_BaseAnimationView *view = [[FAN_BaseAnimationView alloc] initWithFrame:CGRectZero];
    
    view.bounds = CGRectMake(0, 0, 70, 70);
    
    return view;
}


- (void)stopAnimation{
    
    
}

- (void)startAnimation{
    
    
}


- (void)addChildView{
    
    UIImageView *imageV = [UIImageView new];
    [self addSubview:imageV];
    [imageV setImage:[UIImage imageNamed:@"icon_ heart"]];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}



@end
