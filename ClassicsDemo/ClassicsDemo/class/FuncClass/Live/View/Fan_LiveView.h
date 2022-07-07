//
//  Fan_LiveView.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/4.
//

#import <FANOCBaseConfig/FANOCBaseConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fan_LiveView : FAN_BaseView


@property (nonatomic,strong)void(^closeBlock)(void);


@end

NS_ASSUME_NONNULL_END
