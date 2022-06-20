//
//  FAN_LiveStreamingViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/16.
//

#import "FAN_LiveStreamingViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

@interface FAN_LiveStreamingViewController ()<AgoraRtcEngineDelegate>

// 定义 localView 变量
@property (nonatomic, strong) UIView *localView;
// 定义 remoteView 变量
@property (nonatomic, strong) UIView *remoteView;

// 定义 agoraKit 变量
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

@end

@implementation FAN_LiveStreamingViewController

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

// 设置视频窗口布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.remoteView.frame = self.view.bounds;
//    self.localView.frame = CGRectMake(self.view.bounds.size.width - 90, 0, 90, 160);
}
- (void)initViews {
    // 初始化远端视频窗口。只有当远端用户为主播时，才会显示视频画面
    self.remoteView = [[UIView alloc] init];
    [self.view addSubview:self.remoteView];
    // 初始化本地视频窗口。只有当本地用户为主播时，才会显示视频画面
    self.localView = [[UIView alloc] init];
    [self.view addSubview:self.localView];
    
    [self.remoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
        make.height.mas_equalTo(150);
    }];
    
    [self.localView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.remoteView.mas_bottom);
        make.height.mas_equalTo(150);
    }];

}

- (void)initializeAgoraEngine {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"c0a5f17e56514e329f0e04ece4e95797" delegate:self];
}

- (void)setChannelProfile {
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
}

- (void)setClientRole {
    // 设置用户角色为主播
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    // 设置用户角色为观众
//    AgoraClientRoleOptions *options = [AgoraClientRoleOptions alloc];
//    options.audienceLatencyLevel = AgoraAudienceLatencyLevelLowLatency;
//    [self.rtcEngineKit setClientRole:AgoraClientRoleAudience options:options];
}

- (void)setupLocalVideo {
    // 启用视频模块
   int ret = [self.agoraKit enableVideo];
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.localView;
    // 设置本地视图
    [self.agoraKit setupLocalVideo:videoCanvas];
}


- (void)joinChannel {
    // 频道内每个用户的 uid 必须是唯一的
    [self.agoraKit joinChannelByToken:@"0b6f523eaa954da7a70be7ae958259c4" channelId:@"study" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
    }];
    
}

// 监听 didJoinedOfUid 回调
// 远端主播加入频道时，会触发该回调
- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    // 设置远端视图
    [self.agoraKit setupRemoteVideo:videoCanvas];
}

- (void)leaveChannel {
    [self.agoraKit leaveChannel:nil];
}

- (void)dealloc{
    
    [AgoraRtcEngineKit destroy];
}

@end
