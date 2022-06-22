//
//  NSObject+addFunc.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (addFunc)

/**
 *  @brief 根据方法名 参数 调用方法
 *  @param selector 方法名
 *  @param objects  参数数组
 *  @return 被调用的方法的返回值和参数都不支持结构体和block，仅仅支持基本数值类型和对象
 */
- (id)fan_performSelector:(SEL)selector withObjects:(NSArray *)objects;

/**
 *  @brief 根据方法名 参数 调用方法
 *  @param funcStr 方法名
 *  @param objects  参数数组
 *  @return 被调用的方法的返回值和参数都不支持结构体和block，仅仅支持基本数值类型和对象
 */
- (id)fan_performFuncStr:(NSString *)funcStr withObjects:(NSArray *)objects;

@end

NS_ASSUME_NONNULL_END
