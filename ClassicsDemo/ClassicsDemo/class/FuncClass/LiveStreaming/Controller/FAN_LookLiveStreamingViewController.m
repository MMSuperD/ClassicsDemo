//
//  FAN_LookLiveStreamingViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import "FAN_LookLiveStreamingViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface FAN_LookLiveStreamingViewController ()<AgoraRtcEngineDelegate>

// 定义 remoteView 变量
@property (nonatomic, strong) UIView *remoteView;

// 定义 agoraKit 变量
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

@property (nonatomic,strong)UILabel *tipLabel;



@end

@implementation FAN_LookLiveStreamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 调用初始化视频窗口函数
    [self initViews];
    // 后续步骤调用 Agora API 使用的函数
    [self initializeAgoraEngine];
    [self setChannelProfile];
    [self setClientRole];
    [self setupLocalVideo];
    [self joinChannel];
}

- (void)leftButtonClick:(UIButton *)sender{
    
    // 这里就是主播要下播了
    [self leaveChannel];
    
    [AgoraRtcEngineKit destroy];
    
    [super leftButtonClick:sender];
}




- (void)initViews {
    
    self.remoteView = [[UIView alloc] init];
    [self.view addSubview:self.remoteView];
    
    [self.remoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
}

- (void)initializeAgoraEngine {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"c8b5dae237684da7a39919e180bceac4" delegate:self];
}

- (void)setChannelProfile {
    
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
}

// ViewController.m
- (void)setClientRole {
    // 设置用户角色为观众
    AgoraClientRoleOptions *options = [AgoraClientRoleOptions alloc];
    options.audienceLatencyLevel = AgoraAudienceLatencyLevelLowLatency;
    [self.agoraKit setClientRole:AgoraClientRoleAudience options:options];
}

- (void)setupLocalVideo {
    // 启用视频模块
    [self.agoraKit enableVideo];
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    // 设置本地视图
    [self.agoraKit setupLocalVideo:videoCanvas];
}

- (void)joinChannel {
    // 频道内每个用户的 uid 必须是唯一的
    [self.agoraKit joinChannelByToken:@"006c8b5dae237684da7a39919e180bceac4IAAHdRHyMLn/E5RHoWfdZH0tEGD7jb+RsXtUtyoTdDeNncoxwiUAAAAAEADldWoA6/vDYgEAAQDq+8Ni" channelId:@"mmd" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        
        NSLog(@"%@",channel);
    }];
}

- (void)leaveChannel {
    [self.agoraKit leaveChannel:nil];
}

// 远端主播加入频道时，会触发该回调
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
  
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    // 设置远端视图
    [self.agoraKit setupRemoteVideo:videoCanvas];
    
    [self hiddenTipLabel];
}

// 远程主播 已经下线了
- (void)rtcEngine:(AgoraRtcEngineKit* _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason NS_SWIFT_NAME(rtcEngine(_:didOfflineOfUid:reason:)){
    
    //
    
    [self showTipLabel];
    
}

#pragma mark lazy


- (void)showTipLabel {
    
    self.tipLabel.alpha = 1;
}

- (void)hiddenTipLabel {
    
    self.tipLabel.alpha = 0;
}

- (UILabel *)tipLabel{
    
    if (!_tipLabel) {
        _tipLabel = [UILabel fan_labelWithText:@"主播已经下线,你可以休息会了" font:18 textColorStr:@"#ff0000"];
        [self.view addSubview:_tipLabel];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
        }];
    }
    return _tipLabel;
}

@end
