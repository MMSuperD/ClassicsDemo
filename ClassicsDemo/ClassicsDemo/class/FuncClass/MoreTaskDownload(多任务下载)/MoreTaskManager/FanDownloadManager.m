//
//  FanDownloadManager.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import "FanDownloadManager.h"
#import "FanMoreTaskTools.h"
@interface FanDownloadManager()<NSURLSessionDownloadDelegate>

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
        
//        self.maxConcurrentCount = [[NSUserDefaults standardUserDefaults] integerForKey:FanDownloadMaxConcurrentCountKey];
        
        self.maxConcurrentCount = 1;

        
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

#pragma mark NSURLSessionDownloadDelegate
/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
// 这个是下载完成，我们需要移动下载完成的文件 到相应的位置
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    // 获取模型
    FanDownLoadModel *downloadModel = [[FanDataBaseManager shareManager] getModelWithUrl:downloadTask.taskDescription];
    
    // 移动下载的数据到相应的位置
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtPath:[location path] toPath:[downloadModel localPath] error:&error];
    
    if (error) {
        NSLog(@"移动失败");
    } else {
        NSLog(@"文件:%@\n源路径：%@\n移动后的路:%@",downloadModel.fileName,[location path],[downloadModel localPath]);
    }
    
}


/* Sent periodically to notify the delegate of download progress. */
// 这里是进度
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
        totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    // 获取模型数据
    FanDownLoadModel *downloadModel = [[FanDataBaseManager shareManager] getModelWithUrl:downloadTask.taskDescription];
    
    // 当前下载的大小
    downloadModel.tmpFileSize = totalBytesWritten;
    downloadModel.totalFileSize = totalBytesExpectedToWrite;
    
    // 文件时间内下载的文件大小
    downloadModel.intervalFileSize = bytesWritten;
    
    NSInteger intervals = [FanMoreTaskTools getIntervalsWithTimeStamp:downloadModel.lastStateTime];
    
    // 这个网速刷新，需要一秒钟刷新一哈
    if (intervals >= 1) {
        
        // 速度
        downloadModel.speed = downloadModel.intervalFileSize * 1.0 / intervals;
        
        //更新最后时间
        downloadModel.lastSpeedTime = [FanMoreTaskTools getTimeStampWithDate:[NSDate date]];
    }
    
    // 计算进度
    downloadModel.progress = downloadModel.tmpFileSize * 1.0 / downloadModel.totalFileSize;
    
    //更新数据库
    [[FanDataBaseManager shareManager] updateWithModel:downloadModel option:FANDBUpdateOptionState];
    
    // 现在就是进度通知
    [[NSNotificationCenter defaultCenter] postNotificationName:FanDownloadProgressNotification object:downloadModel];
    
    NSLog(@"下载进度为：%.8f",downloadModel.progress * 100);
    
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    
}

#pragma mark NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    
    if (error  && [error.localizedDescription isEqualToString:@"cancelled"]) {
        return;
    }
    
    // 这里表示下载完成
    FanDownLoadModel *downloadModel = [[FanDataBaseManager shareManager] getModelWithUrl:task.taskDescription];
    
    downloadModel.state = FANDownloadState_Finish;
    
    [[FanDataBaseManager shareManager] updateWithModel:downloadModel option:FANDBUpdateOptionState];
    
    [self.dataTaskDic removeObjectForKey:downloadModel.url];
    self.currentCount = self.currentCount - 1;
    
    // 继续开始下载正在等待中的任务
    
    
}

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
    
    
    // 根据model 的url  获取数据库中url 所对应的模型数据
    FanDownLoadModel *downloadModel = [[FanDataBaseManager shareManager] getModelWithUrl:model.url];
    
    // 判断数据库中是否存在这个downloadModel 如果不存在就需要插入
    if (!downloadModel) {
        downloadModel = model;
        [[FanDataBaseManager shareManager] insertModel:downloadModel];
    }
    
    // 修改downloadModel 状态为等在下载
    downloadModel.state = FANDownloadState_Waiting;
    
    // 更新数据库的数据
    [[FanDataBaseManager shareManager] updateWithModel:downloadModel option:FANDBUpdateOptionState | FANDBUpdateOptionLastStateTime];
    
    
    // 判断当前下载数量 是否 在可以下载的范围
    if (self.currentCount < self.maxConcurrentCount) {
        [self downloadwithModel:downloadModel];
    }
    
}


// 开始下载
- (void)downloadwithModel:(FanDownLoadModel *)model{
    
    // 来到这个方法，证明需要开始下载了
    
    self.currentCount = self.currentCount + 1;
    
    FanDownLoadModel *downloadModel = [[FanDataBaseManager shareManager] getModelWithUrl:model.url];
    
    // 修改model 的状态
    downloadModel.state = FANDownloadState_Downloading;
    
    // 更新数据库
    [[FanDataBaseManager shareManager] updateWithModel:downloadModel option:FANDBUpdateOptionState];
    
    
    // 开始下载
    NSURLSessionDownloadTask *downloadTask;
    
    if (downloadModel.resumeData) {
        // 这里是继续下载
        downloadTask = [self.session downloadTaskWithResumeData:model.resumeData];
    } else {
        // 这里是开始下载
        downloadTask = [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:downloadModel.url]]];
    }
    
    downloadTask.taskDescription = downloadModel.url;
    
    // 更新存储的对象
    self.dataTaskDic[downloadModel.url] = downloadTask;
    
    
    // 启动下载
    [downloadTask resume];
    
    
}

// 暂停下载
- (void)pauseDownloadTask:(FanDownLoadModel *)model{
    
}

// 删除下载任务及本地缓存
- (void)deleteTaskAndCache:(FanDownLoadModel *)model{
    
}


@end
