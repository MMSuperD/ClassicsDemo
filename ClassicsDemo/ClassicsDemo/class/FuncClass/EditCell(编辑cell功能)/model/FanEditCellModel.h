//
//  FanEditCellModel.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "FanBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FanEditCellModel : FanBaseModel

@property (nonatomic,assign)BOOL isSelect;

@property (nonatomic,strong)NSString *content;

/// YES :表示现在显示管理   NO:表示现在显示完成
@property (nonatomic,assign)BOOL isEditStatu;

@end

NS_ASSUME_NONNULL_END
