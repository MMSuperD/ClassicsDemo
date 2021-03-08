//
//  FanDownloadManager.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import "FanDownloadManager.h"

@interface FanDownloadManager()<NSURLSessionDelegate>

// 当前正在下载的个数
@property (nonatomic, assign) NSInteger currentCount;

// 同时下载多个文件，需要创建多个NSURLSessionDownloadTask，用该字典来存储
@property (nonatomic, strong) NSMutableDictionary *dataTaskDic;

// 记录任务调用startDownloadTask:方法时间，禁止同一任务极短时间重复调用，防止状态显示错误
@property (nonatomic, strong) NSMutableDictionary *downloadTaskDic;

// NSURLSession
@property (nonatomic, strong) NSURLSession *session;



@end

@implementation FanDownloadManager

+ (instancetype)shareManager{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.maxConcurrentCount = [[NSUserDefaults standardUserDefaults] integerForKey:FanDownloadMaxConcurrentCountKey];
        
        self.currentCount = 0;
        
        self.allowsCellularAccess = [[NSUserDefaults standardUserDefaults] boolForKey:FanDownloadAllowsCellularAccessKey];
        
        self.dataTaskDic = [NSMutableDictionary dictionary];
       
        self.downloadTaskDic = [NSMutableDictionary dictionary];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        
        // 后台下载标识
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:FanDownloadBackgroundSessionIdentifier];
        // 允许蜂窝网络下载，默认为YES，这里开启，我们添加了一个变量去控制用户切换选择
        configuration.allowsCellularAccess = YES;
        
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
        
        // 最大下载并发数变更通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadMaxConcurrentCountChange:) name:FanDownloadMaxConcurrentCountChangeNotification object:nil];
        // 是否允许蜂窝网络下载改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAllowsCellularAccessChange:) name:FanDownloadAllowsCellularAccessChangeNotification object:nil];
        // 网路改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkingReachabilityDidChange:) name:FanNetworkingReachabilityDidChangeNotification object:nil];
        

    }
    return self;
}

#pragma mark NSURLSessionDelegate


#pragma mark 通知监听
/// 最大并发数改变的通知
- (void)downloadMaxConcurrentCountChange:(NSNotification *)notification{
    
}

/// 是否允许蜂窝网络下载改变的通知
- (void)downloadAllowsCellularAccessChange:(NSNotification *)notification{
    
}

/// 网络改变通知
- (void)networkingReachabilityDidChange:(NSNotification *)notification{
    
}



// 开始下载
- (void)startDownloadTask:(FanDownLoadModel *)model{
    
}

// 暂停下载
- (void)pauseDownloadTask:(FanDownLoadModel *)model{
    
}

// 删除下载任务及本地缓存
- (void)deleteTaskAndCache:(FanDownLoadModel *)model{
    
}


@end
