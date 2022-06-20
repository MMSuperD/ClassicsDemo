//
//  Fan_CircleProgressView.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/20.
//

#import <FANOCBaseConfig/FANOCBaseConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fan_CircleProgressView : FAN_BaseView

@property (nonatomic,assign)CGFloat value;



- (void)setTileString:(NSString *)title  value:(NSString *)value;


@end

NS_ASSUME_NONNULL_END
