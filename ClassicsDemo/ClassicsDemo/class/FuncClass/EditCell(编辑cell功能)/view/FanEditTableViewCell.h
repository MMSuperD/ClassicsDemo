//
//  FanEditTableViewCell.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/2.
//

#import "FanBaseTableViewCell.h"
#import "FanEditCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FanEditTableViewCell : FanBaseTableViewCell

@property (nonatomic,strong)FanEditCellModel *model;

@property (nonatomic,assign)BOOL isSelect;

- (void)addAnimation;

@end

NS_ASSUME_NONNULL_END
