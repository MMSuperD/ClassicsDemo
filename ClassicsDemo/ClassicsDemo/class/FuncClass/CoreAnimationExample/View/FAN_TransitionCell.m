//
//  FAN_TransitionCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_TransitionCell.h"

@implementation FAN_TransitionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}

- (void)addChildView{
    
    self.textLabel.text = @"点击就可以查阅转场动画了,转场动画看FAN_WebViewHandleDelegateObject,或者FAN_CircleTransition";
    self.textLabel.textColor = [UIColor fan_randomColor];
    self.textLabel.numberOfLines = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)cellHeight{
    return 60;
}

- (void)cellClick{
    
    //找当当前的导航控制器
    [self.currentnNavgationController pushViewController:[[NSClassFromString(@"FAN_TransitionViewController") alloc] init] animated:YES];
    
}

@end
