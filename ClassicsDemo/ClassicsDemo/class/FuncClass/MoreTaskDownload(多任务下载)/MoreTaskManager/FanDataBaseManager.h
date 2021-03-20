//
//  FanDataBaseManager.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "FanDownLoadModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, FANDBUpdateOption) {
    FANDBUpdateOptionState         = 1 << 0,  // 更新状态
    FANDBUpdateOptionLastStateTime = 1 << 1,  // 更新状态最后改变的时间
    FANDBUpdateOptionResumeData    = 1 << 2,  // 更新下载的数据
    FANDBUpdateOptionProgressData  = 1 << 3,  // 更新进度数据（包含tmpFileSize、totalFileSize、progress、intervalFileSize、lastSpeedTime）
    FANDBUpdateOptionAllParam      = 1 << 4   // 更新全部数据
};

@interface FanDataBaseManager : NSObject

// 获取单例
+ (instancetype)shareManager;

// 插入数据
- (void)insertModel:(FanDownLoadModel *)model;

// 获取数据
- (FanDownLoadModel *)getModelWithUrl:(NSString *)url;    // 根据url获取数据
- (FanDownLoadModel *)getWaitingModel;                    // 获取第一条等待的数据
- (FanDownLoadModel *)getLastDownloadingModel;            // 获取最后一条正在下载的数据
- (NSArray<FanDownLoadModel *> *)getAllCacheData;         // 获取所有数据
- (NSArray<FanDownLoadModel *> *)getAllDownloadingData;   // 根据lastStateTime倒叙获取所有正在下载的数据
- (NSArray<FanDownLoadModel *> *)getAllDownloadedData;    // 获取所有下载完成的数据
- (NSArray<FanDownLoadModel *> *)getAllUnDownloadedData;  // 获取所有未下载完成的数据（包含正在下载、等待、暂停、错误）
- (NSArray<FanDownLoadModel *> *)getAllWaitingData;       // 获取所有等待下载的数据

// 更新数据
- (void)updateWithModel:(FanDownLoadModel *)model option:(FANDBUpdateOption)option;

// 删除数据
- (void)deleteModelWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
