//
//  FAN_StartLiveStreamingViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import "FAN_StartLiveStreamingViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>


@interface FAN_StartLiveStreamingViewController ()

// 定义 localView 变量
@property (nonatomic, strong) UIView *localView;

// 定义 agoraKit 变量
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

@end

@implementation FAN_StartLiveStreamingViewController

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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)initViews {
    
    // 初始化本地视频窗口。只有当本地用户为主播时，才会显示视频画面
    self.localView = [[UIView alloc] init];
    [self.view addSubview:self.localView];
    
    [self.localView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    // 设置用户角色为主播
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
}

- (void)setupLocalVideo {
    // 启用视频模块
    [self.agoraKit enableVideo];
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.localView;
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



@end
