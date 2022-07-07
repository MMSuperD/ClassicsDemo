//
//  FAN_LiveListViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import "FAN_LiveListViewController.h"
#import "FAN_LiveViewController.h""
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "FAN_PlayerLiveViewController.h""

@interface FAN_LiveListViewController ()

@end

@implementation FAN_LiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildSubview];
}

- (void)addChildSubview{
    
    [self.rightNvBarBtn setTitle:@"开始直播" forState:UIControlStateNormal];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
    
}

- (void)rightButtonClick:(UIButton *)sender{
    
    FAN_LiveViewController *vc = [FAN_LiveViewController new];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 这个就是接入直播的播放器
    
    NSString *url = @"rtmp://192.168.0.188:1935/live/room";
    FAN_PlayerLiveViewController *vc = [FAN_PlayerLiveViewController new];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


@end
