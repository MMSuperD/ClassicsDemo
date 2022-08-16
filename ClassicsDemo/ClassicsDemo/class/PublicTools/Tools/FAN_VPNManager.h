//
//  FAN_VPNManager.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAN_VPNManager : NSObject

+ (instancetype)sharedThread;

- (BOOL)isProxyOpened;
- (BOOL)isVPNOn;



@end

NS_ASSUME_NONNULL_END
