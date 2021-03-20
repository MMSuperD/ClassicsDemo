//
//  FanDataBaseManager.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import "FanDataBaseManager.h"
#import "FanMoreTaskTools.h"
typedef NS_ENUM(NSInteger, FANDBGetDateOption) {
    FANDBGetDateOptionAllCacheData = 0,      // 所有缓存数据
    FANDBGetDateOptionAllDownloadingData,    // 所有正在下载的数据
    FANDBGetDateOptionAllDownloadedData,     // 所有下载完成的数据
    FANDBGetDateOptionAllUnDownloadedData,   // 所有未下载完成的数据
    FANDBGetDateOptionAllWaitingData,        // 所有等待下载的数据
    FANDBGetDateOptionModelWithUrl,          // 通过url获取单条数据
    FANDBGetDateOptionWaitingModel,          // 第一条等待的数据
    FANDBGetDateOptionLastDownloadingModel,  // 最后一条正在下载的数据
};

@interface FanDataBaseManager()

@property (nonatomic,strong)FMDatabaseQueue *dbQueue;

@end

@implementation FanDataBaseManager

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
        [self createDataCachesTable];
    }
    return self;
}

#pragma mark 创建数据缓存表
- (void)createDataCachesTable{
    
    // 数据库文件路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory
                                                           , NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FANDownloadDataCaches.sqlite"];
    // 创建队列对象，内部会自动创建一个数据库, 并且自动打开
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        // 创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_videoCaches (id integer PRIMARY KEY AUTOINCREMENT, vid text, fileName text, url text, resumeData blob, totalFileSize integer, tmpFileSize integer, state integer, progress float, lastSpeedTime double, intervalFileSize integer, lastStateTime integer)"];
        
        if (result) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
        
    }];
}

// 插入数据
- (void)insertModel:(FanDownLoadModel *)model
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"INSERT INTO t_videoCaches (vid, fileName, url, resumeData, totalFileSize, tmpFileSize, state, progress, lastSpeedTime, intervalFileSize, lastStateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.vid, model.fileName, model.url, model.resumeData, [NSNumber numberWithInteger:model.totalFileSize], [NSNumber numberWithInteger:model.tmpFileSize], [NSNumber numberWithInteger:model.state], [NSNumber numberWithFloat:model.progress], [NSNumber numberWithDouble:0], [NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0]];
        if (result) {
            NSLog(@"插入成功：%@", model.fileName);
        }else {
            NSLog(@"插入失败：%@", model.fileName);
        }
    }];
}

// 根据url获取数据
- (FanDownLoadModel *)getModelWithUrl:(NSString *)url{
    
    
    // 1.根据url  查询数据库中是否已经下载了该条数据
    FanDownLoadModel *downloadModel = [self getModelWithOption:FANDBGetDateOptionModelWithUrl url:url];
    
    return downloadModel;
}



/***
 这里是根据url  获取单条数据
 */
- (FanDownLoadModel *)getModelWithOption:(FANDBGetDateOption)option url:(NSString *)url{
    
    __block  FanDownLoadModel *downloadModel = nil;
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *resultSet = nil;
        NSString *sqlString = nil;
        switch (option) {
            
                // 根据url 获取单条数据
            case FANDBGetDateOptionModelWithUrl:
            {
                sqlString = [NSString stringWithFormat:@"SELECT * FROM t_videoCaches WHERE url = '%@';",url];
                resultSet = [db executeQuery:sqlString];
                break;
            }
            default:
                break;
        }
        
        // 根据结果集转化为model
        NSMutableArray *modelArray = [self downloadModelForResultSet:resultSet];
        // 因为这个方法是只获取一条数据，所以查询出来的结果，我们只需要得到条数据。应为查询到的数据也只有一条
        downloadModel = modelArray.count > 0 ? modelArray.firstObject : nil;
    }];
    
    return downloadModel;
}


// 更新数据
- (void)updateWithModel:(FanDownLoadModel *)model option:(FANDBUpdateOption)option{
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (option & FANDBUpdateOptionState) {
            ///dwang_start
            /**
             [self postStateChangeNotificationWithFMDatabase:db model:model];
             */
            ///dwang_end
            [db executeUpdate:@"UPDATE t_videoCaches SET state = ? WHERE url = ?", [NSNumber numberWithInteger:model.state], model.url];
        }
        if (option & FANDBUpdateOptionLastStateTime) {
            [db executeUpdate:@"UPDATE t_videoCaches SET lastStateTime = ? WHERE url = ?", [NSNumber numberWithInteger:[FanMoreTaskTools getTimeStampWithDate:[NSDate date]]], model.url];
        }
        if (option & FANDBUpdateOptionResumeData) {
            [db executeUpdate:@"UPDATE t_videoCaches SET resumeData = ? WHERE url = ?", model.resumeData, model.url];
        }
        if (option & FANDBUpdateOptionProgressData) {
            [db executeUpdate:@"UPDATE t_videoCaches SET tmpFileSize = ?, totalFileSize = ?, progress = ?, lastSpeedTime = ?, intervalFileSize = ? WHERE url = ?", [NSNumber numberWithInteger:model.tmpFileSize], [NSNumber numberWithFloat:model.totalFileSize], [NSNumber numberWithFloat:model.progress], [NSNumber numberWithDouble:model.lastSpeedTime], [NSNumber numberWithInteger:model.intervalFileSize], model.url];
        }
        if (option & FANDBUpdateOptionAllParam) {
            ///dwang_start
            /**
             [self postStateChangeNotificationWithFMDatabase:db model:model];
             */
            ///dwang_end
            [db executeUpdate:@"UPDATE t_videoCaches SET resumeData = ?, totalFileSize = ?, tmpFileSize = ?, progress = ?, state = ?, lastSpeedTime = ?, intervalFileSize = ?, lastStateTime = ? WHERE url = ?", model.resumeData, [NSNumber numberWithInteger:model.totalFileSize], [NSNumber numberWithInteger:model.tmpFileSize], [NSNumber numberWithFloat:model.progress], [NSNumber numberWithInteger:model.state], [NSNumber numberWithDouble:model.lastSpeedTime], [NSNumber numberWithInteger:model.intervalFileSize], [NSNumber numberWithInteger:[FanMoreTaskTools getTimeStampWithDate:[NSDate date]]], model.url];
        }
    }];
    
}


/**
 根据结果集（FMResultSet）创建Model
 */
- (NSMutableArray<FanDownLoadModel *> *)downloadModelForResultSet:(FMResultSet *)resultSet{
    
    NSMutableArray *modelArray = [NSMutableArray array];
    while ([resultSet next]) {
       
        // 创建一个model
        FanDownLoadModel *model = [FanDownLoadModel new];
        [modelArray addObject:model];
        
        model.vid = [NSString stringWithFormat:@"%@", [resultSet objectForColumn:@"vid"]];
        model.url = [NSString stringWithFormat:@"%@", [resultSet objectForColumn:@"url"]];
        model.fileName = [NSString stringWithFormat:@"%@", [resultSet objectForColumn:@"fileName"]];
        model.totalFileSize = [[resultSet objectForColumn:@"totalFileSize"] integerValue];
        model.tmpFileSize = [[resultSet objectForColumn:@"tmpFileSize"] integerValue];
        model.progress = [[resultSet objectForColumn:@"progress"] floatValue];
        model.state = [[resultSet objectForColumn:@"state"] integerValue];
        model.lastSpeedTime = [resultSet doubleForColumn:@"lastSpeedTime"];
        model.intervalFileSize = [[resultSet objectForColumn:@"intervalFileSize"] integerValue];
        model.lastStateTime = [[resultSet objectForColumn:@"lastStateTime"] integerValue];
        model.resumeData = [resultSet dataForColumn:@"resumeData"];
    }
    
    return modelArray;
}

@end
