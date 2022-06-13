//
//  FAN_CoreBlueTools.m
//  ClassicsDemo
//
//  Created by xzmac on 2022/5/11.
//

#import "FAN_CoreBlueTools.h"

@interface FAN_CoreBlueTools()<
CBCentralManagerDelegate,
CBPeripheralDelegate
>

// 中心管理者(管理设备的扫描和连接)
@property (nonatomic, strong) CBCentralManager *centralManager;

// 存储的设备
@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *peripherals;

// 扫描到的设备
@property (nonatomic, strong) CBPeripheral *cbPeripheral;

// 扫描到的服务
@property (nonatomic, strong) CBService *cbService;

// 扫描到的特征
@property (nonatomic, strong) CBCharacteristic *cbCharacteristic;

// 外设状态
@property (nonatomic, assign) CBManagerState peripheralState;

//设备名 + mac地址
@property (nonatomic, strong) NSString *name;

//用来读取信息的特征 0xFFB1
@property (nonatomic, strong) CBCharacteristic *readCharacteristic;

@property (nonatomic,copy)NSArray<NSString *> *cbuuidArray;


@end

@implementation FAN_CoreBlueTools

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    
    [self centralManager];
    
    
}




#pragma mark action  设备 服务 特征

// 开始扫描蓝牙设备
- (void)scanForPeripheralsWithServices:(NSArray<CBUUID *> *)serviceUUIDs options:(NSDictionary<NSString *,id> *)options{
    
    if (self.peripheralState == CBManagerStatePoweredOn) {
        [self.centralManager scanForPeripheralsWithServices:serviceUUIDs options:options];
    }
    
}

// 停止扫描蓝牙设备
- (void)stopScan{
    
    if (self.peripheralState == CBManagerStatePoweredOn) {
        [self.centralManager stopScan];
    }
}

// 断开蓝牙设备
- (void)disconnect{
    
    
}

//服务
- (void)discoverServices:(nullable NSArray<CBUUID *> *)serviceUUIDs{
    
    if (self.cbPeripheral) {
       
        self.cbPeripheral.delegate = self;
        
        [self.cbPeripheral discoverServices:serviceUUIDs];
    }
}

// 连接设备
- (void)connectPeripheral:(CBPeripheral *)peripheral options:(nullable NSDictionary<NSString *, id> *)options{
    [self.centralManager connectPeripheral:peripheral options:options];
}

//特征
- (void)discoverCharacteristics:(nullable NSArray<CBUUID *> *)characteristicUUIDs forService:(CBService *)service{
    
    NSLog(@"开始扫描%@服务的特征",self.cbService.UUID.UUIDString);

    if (self.cbPeripheral) {
        [self.cbPeripheral discoverCharacteristics:characteristicUUIDs forService:service];
    }
}

// 订阅特征
- (void)subscribCharacteristics{
    
    if (self.cbPeripheral && self.cbCharacteristic) {
        [self.cbPeripheral readValueForCharacteristic:self.cbCharacteristic];
        [self.cbPeripheral setNotifyValue:YES forCharacteristic:self.cbCharacteristic];
    }
}

#pragma mark CBCentralManagerDelegate
#pragma mark -------------device(设备)

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    switch (central.state) {
        case CBManagerStateUnknown:{
            NSLog(@"为知状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateResetting:
        {
            NSLog(@"重置状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"不支持的状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateUnauthorized:
        {
            NSLog(@"未授权的状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"关闭状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStatePoweredOn:
        {
            NSLog(@"开启状态－可用状态");
            self.peripheralState = central.state;
            NSLog(@"%ld",(long)self.peripheralState);
        }
            break;
        default:
            break;
    }
    
}


/**
 扫描到设备
 @param central 中心管理者
 @param peripheral 扫描到的设备
 @param advertisementData 广告信息
 @param RSSI 信号强度
 */

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    if (peripheral.name) {
        
        [self.peripherals addObject:peripheral];
        
        NSData *adata = advertisementData[@"kCBAdvDataManufacturerData"];
        
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[adata length]];
        [adata enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
            unsigned char *dataBytes = (unsigned char*)bytes;
            for (NSInteger i = 0; i < byteRange.length; i++) {
                NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
                if ([hexStr length] == 2) {
                    [string appendString:hexStr];
                } else {
                    [string appendFormat:@"0%@", hexStr];
                }
            }
        }];
        
        if (string.length > 16) {
            NSLog(@"广播包：%@",string);

            NSString *macStr = [string substringWithRange:NSMakeRange(4, 12)];
            NSLog(@"MAC地址：%@",macStr);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(coreBuleCBPeripheralArray:)]) {
            [self.delegate coreBuleCBPeripheralArray:self.peripherals];
        }
    }
    
}

/**
 连接成功
 
 @param central 中心管理者
 @param peripheral 连接成功的设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接设备:%@成功",peripheral.name);
    self.cbPeripheral = peripheral;
}

/**
 连接失败
 @param central 中心管理者
 @param peripheral 连接失败的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@",@"连接失败");
}



#pragma mark CBPeripheralDelegate

#pragma mark -------------server(服务)
/**
 扫描到服务
 @param peripheral 服务对应的设备
 @param error 扫描错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 遍历所有的服务
    for (CBService *service in peripheral.services)
    {
        NSLog(@"服务:%@",service.UUID.UUIDString);
    }

}


#pragma mark -------------characteristic(特征)
/**
 扫描到对应的特征
 @param peripheral 设备
 @param service 特征对应的服务
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        NSLog(@">>>服务:%@ 的 特征: %@",service.UUID,characteristic.UUID);
        
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFB1"]) {
            self.readCharacteristic = characteristic;
        }
    }
    
    //得到一个特征,订阅特征
    [self subscribCharacteristics];
}

/**
 根据特征读到数据
 @param peripheral 读取到数据对应的设备
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
//    NSData *data = characteristic.value;
    //    NSLog(@"%@",data);
    //接收蓝牙发来的数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
    if (characteristic.value.length >= 12) {
        NSString *str = [self convertDataToHexStr:characteristic.value];
        
        NSString *circleStr = [str substringWithRange:NSMakeRange(6, 8)];
        NSString *timeStr = [str substringWithRange:NSMakeRange(14, 8)];
        
        NSString *circle10 = [NSString stringWithFormat:@"%lu",strtoul([circleStr UTF8String],0,16)];
        NSString *time10 = [NSString stringWithFormat:@"%lu",strtoul([timeStr UTF8String],0,16)];
        
        NSLog(@"圈数：%@ 时间：%@",circle10,time10);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    } else {
//        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
//        NSLog(@"%@", characteristic);
//        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}

#pragma mark 配置方法
// 这个是配置全局的
+ (void)configCBUUIDDataArray:(NSArray<NSString *> *)cbuuidArray{
    
    
    
    
}

// 这个是配置当前的
- (void)configCBUUIDDataArray:(NSArray<NSString *> *)cbuuidArray{
    self.cbuuidArray = cbuuidArray;
}

- (CBPeripheral *)currentConnectPeripheral{
    return self.cbPeripheral;
}

#pragma mark lazy

- (CBCentralManager *)centralManager{
    if (!_centralManager) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

- (NSMutableArray *)peripherals {
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}

- (NSArray<NSString *> *)cbuuidArray{
    if (!_cbuuidArray) {
        
        // 这里就需要读取本地的全局配置数据,如果有数据的话,就读取出来,赋值,没有就是nil
        
    }
    return _cbuuidArray;
}

#pragma mark 公共方法
- (NSString *)convertDataToHexStr:(NSData *)adata{
    if (!adata || [adata length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[adata length]];
    
    [adata enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


@end
