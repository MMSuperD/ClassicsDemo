//
//  FanMoreTaskConst.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import <Foundation/Foundation.h>


/************************* 下载 *************************/
UIKIT_EXTERN NSString * const FanDownloadProgressNotification;                   // 进度回调通知
UIKIT_EXTERN NSString * const FanDownloadStateChangeNotification;                // 状态改变通知
UIKIT_EXTERN NSString * const FanDownloadMaxConcurrentCountKey;                  // 最大同时下载数量key
UIKIT_EXTERN NSString * const FanDownloadMaxConcurrentCountChangeNotification;   // 最大同时下载数量改变通知
UIKIT_EXTERN NSString * const FanDownloadAllowsCellularAccessKey;                // 是否允许蜂窝网络下载key
UIKIT_EXTERN NSString * const FanDownloadAllowsCellularAccessChangeNotification; // 是否允许蜂窝网络下载改变通知

/************************* 网络 *************************/
UIKIT_EXTERN NSString * const FanNetworkingReachabilityDidChangeNotification;    // 网络改变改变通知

/************************* 后台标识 *************************/
UIKIT_EXTERN NSString * const FanDownloadBackgroundSessionIdentifier;
