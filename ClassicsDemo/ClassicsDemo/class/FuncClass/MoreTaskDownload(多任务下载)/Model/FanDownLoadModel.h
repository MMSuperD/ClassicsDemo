//
//  FanDownLoadModel.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import "FanBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FanDownLoadModel : FanBaseModel

@property (nonatomic, copy) NSString *vid;                  // 文件唯一id标识
@property (nonatomic, copy) NSString *fileName;             // 文件名
@property (nonatomic, copy) NSString *url;                  // url

@end

NS_ASSUME_NONNULL_END
