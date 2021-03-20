//
//  FanMoreTaskTools.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FanMoreTaskTools : NSObject


// 时间转换为时间戳，精确到微秒
+ (NSTimeInterval)getTimeStampWithDate:(NSDate *)date;

// 时间戳转换为时间
+ (NSDate *)getDateWithTimeStamp:(NSTimeInterval)timeStamp;

// 一个时间戳与当前时间的间隔（s）
+ (NSInteger)getIntervalsWithTimeStamp:(NSTimeInterval)timeStamp;

@end

NS_ASSUME_NONNULL_END
