//
//  FanDownloadManager.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FanDownLoadModel;
typedef NS_ENUM(NSInteger, FanDownloadState) {
    FanDownloadState_Default = 0,  // 默认
    FanDownloadState_Downloading,  // 正在下载
    FanDownloadState_Waiting,      // 等待
    FanDownloadState_Paused,       // 暂停
    FanDownloadState_Finish,       // 完成
    FanDownloadState_Error,        // 错误
};

@interface FanDownloadManager : NSObject

// 最大同时下载数量 默认是 1
@property (nonatomic, assign) NSInteger maxConcurrentCount;

// 是否允许蜂窝网络下载 默认不允许 NO
@property (nonatomic, assign) BOOL allowsCellularAccess;


// 初始化下载单例，若之前程序杀死时有正在下的任务，会自动恢复下载
+ (instancetype)shareManager;

// 开始下载
- (void)startDownloadTask:(FanDownLoadModel *)model;

// 暂停下载
- (void)pauseDownloadTask:(FanDownLoadModel *)model;

// 删除下载任务及本地缓存
- (void)deleteTaskAndCache:(FanDownLoadModel *)model;

@end

NS_ASSUME_NONNULL_END
