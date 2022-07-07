//
//  FAN_TestLiveStreamingViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import "FAN_TestLiveStreamingViewController.h"
#import "FAN_StartLiveStreamingViewController.h"
#import "FAN_LookLiveStreamingViewController.h"

@interface FAN_TestLiveStreamingViewController ()

// 这个是观看直播
@property (nonatomic,strong)UIButton *lookLiveBtn;

// 这个是 开始直播
@property (nonatomic,strong)UIButton *startLiveBtn;


@end

@implementation FAN_TestLiveStreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildSubview];
}

- (void)addChildSubview{
    
    [self.view addSubview:self.lookLiveBtn];
    self.lookLiveBtn.frame = CGRectMake(50, 200, 100, 40);
    [self.lookLiveBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.lookLiveBtn.tag = 100;
    
    [self.view addSubview:self.startLiveBtn];
    self.startLiveBtn.frame = CGRectMake(200, 200, 100, 40);
    [self.startLiveBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.startLiveBtn.tag = 101;


}

- (void)actionBtn:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
        {
            // 观看直播
            FAN_LookLiveStreamingViewController *vc = [FAN_LookLiveStreamingViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
            
            break;
        }
            
        case 101:
        {
            // 开始直播
            FAN_StartLiveStreamingViewController *vc = [FAN_StartLiveStreamingViewController new];
            vc.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:vc animated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark lazy

- (UIButton *)lookLiveBtn{
    
    if (!_lookLiveBtn) {
        _lookLiveBtn = [UIButton buttonWithType:0];
        [_lookLiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_lookLiveBtn setBackgroundColor:[UIColor grayColor]];
        [_lookLiveBtn setTitle:@"观看直播" forState:UIControlStateNormal];
    }
    return _lookLiveBtn;
    
}

- (UIButton *)startLiveBtn{
    
    if (!_startLiveBtn) {
        _startLiveBtn = [UIButton buttonWithType:0];
        [_startLiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_startLiveBtn setBackgroundColor:[UIColor grayColor]];
        [_startLiveBtn setTitle:@"开始直播" forState:UIControlStateNormal];
    }
    return _startLiveBtn;
    
}





@end
