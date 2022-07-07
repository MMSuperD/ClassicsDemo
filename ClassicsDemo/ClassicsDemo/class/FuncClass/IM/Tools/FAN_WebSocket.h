//
//  FAN_WebSocket.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FAN_ReadyState) {
    FAN_CONNECTING   = 0,// 制动连接中
    FAN_OPEN         = 1, //链接成功
    FAN_CLOSING      = 2, //正在关闭链接
    FAN_CLOSED       = 3, // 已经关闭链接
};


@protocol FAN_WebSocketDelegate <NSObject>

- (void)fan_webSocketDidReceiveMessage:(NSString *)message;

- (void)fan_webSocketConnectedSuccess:(FAN_ReadyState)state;

@end

@interface FAN_WebSocket : NSObject


@property (nonatomic,weak)id<FAN_WebSocketDelegate> delegate;


- (instancetype)initWithServerIp:(NSString *)serverIp;

- (void)connectWebSocket;

- (void)closeWebSocket;

- (void)sendMsg:(NSString *)msg;

- (BOOL)sendMessage:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
