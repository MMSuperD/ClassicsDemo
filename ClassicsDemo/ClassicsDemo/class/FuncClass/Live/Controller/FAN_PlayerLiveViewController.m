//
//  FAN_PlayerLiveViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import "FAN_PlayerLiveViewController.h"
#import "FAN_PlayerView.h"

@interface FAN_PlayerLiveViewController ()

@property (nonatomic,strong)Fan_PlayerView *playerView;

@end

@implementation FAN_PlayerLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildSubview];
}


- (void)addChildSubview{
    
    self.nvView.backgroundColor = [UIColor clearColor];
    self.titleLabel.alpha = 0;

    
    self.playerView = [[Fan_PlayerView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.playerView];
    self.playerView.url = self.url;
    
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.leftNvBarBtn removeFromSuperview];
    [self.view insertSubview:self.leftNvBarBtn aboveSubview:self.playerView];
    [self.leftNvBarBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    

    
}


- (void)dealloc{
    
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
}





@end
