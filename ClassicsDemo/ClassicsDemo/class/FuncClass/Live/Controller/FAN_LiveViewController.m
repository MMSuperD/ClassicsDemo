//
//  FAN_LiveViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import "FAN_LiveViewController.h"
#import "Fan_LiveView.h"

@interface FAN_LiveViewController ()

@end

@implementation FAN_LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildSubview];
}

- (void)addChildSubview{
    
    // 这里就需要添加直播View了
    self.nvView.backgroundColor = [UIColor clearColor];
    self.titleLabel.alpha = 0;
    
    Fan_LiveView *liveView = [[Fan_LiveView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:liveView];
    
    [liveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
}

@end
