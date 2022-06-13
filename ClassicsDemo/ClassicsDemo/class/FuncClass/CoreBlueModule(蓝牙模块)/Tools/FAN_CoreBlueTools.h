//
//  FAN_CoreBlueTools.h
//  ClassicsDemo
//
//  Created by xzmac on 2022/5/11.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FAN_CoreBlueToolsDelegate <NSObject>

// 这里是设备数据
- (void)coreBuleCBPeripheralArray:(NSArray<CBPeripheral *> *)cbPeripheralArray;

@end

@interface FAN_CoreBlueTools : NSObject

@property (nonatomic,weak)id<FAN_CoreBlueToolsDelegate> delegate;

/**
 当前连接的蓝牙设备
 */
@property (nonatomic,weak,readonly)CBPeripheral *currentConnectPeripheral;



// 这个是配置全局的
+ (void)configCBUUIDDataArray:(NSArray<NSString *> *)cbuuidArray;

// 这个是配置当前的
- (void)configCBUUIDDataArray:(NSArray<NSString *> *)cbuuidArray;


#pragma mark  设备
// 开始扫描蓝牙设备
- (void)scanForPeripheralsWithServices:(nullable NSArray<CBUUID *> *)serviceUUIDs options:(nullable NSDictionary<NSString *, id> *)options;

// 停止扫描蓝牙设备
- (void)stopScan;

// 断开蓝牙设备
- (void)disconnect;

// 连接设备
- (void)connectPeripheral:(CBPeripheral *)peripheral options:(nullable NSDictionary<NSString *, id> *)options;


#pragma mark  服务
// 扫描 服务
- (void)discoverServices:(nullable NSArray<CBUUID *> *)serviceUUIDs;

#pragma mark 特征
- (void)discoverCharacteristics:(nullable NSArray<CBUUID *> *)characteristicUUIDs forService:(CBService *)service;

@end

NS_ASSUME_NONNULL_END
