//
//  FanMoreTaskTools.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/17.
//

#import "FanMoreTaskTools.h"

@implementation FanMoreTaskTools

// 时间转换为时间戳，精确到微秒
+ (NSTimeInterval)getTimeStampWithDate:(NSDate *)date
{
    return [[NSNumber numberWithDouble:[date timeIntervalSince1970] * 1000 * 1000] longLongValue];
}

// 时间戳转换为时间
+ (NSDate *)getDateWithTimeStamp:(NSTimeInterval)timeStamp
{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp * 0.001 * 0.001];
}

// 一个时间戳与当前时间的间隔（s）
+ (NSInteger)getIntervalsWithTimeStamp:(NSTimeInterval)timeStamp{
    
    return [[NSDate date] timeIntervalSinceDate:[self getDateWithTimeStamp:timeStamp]];
}

@end
