//
//  FanScrollCollectionCell.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/3.
//

#import "FanScrollCollectionCell.h"
#import "FanScrollUnitView.h"

@interface FanScrollCollectionCell()
@property (nonatomic,strong)NSMutableArray<FanScrollUnitView *> *unitViewArray;

//@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation FanScrollCollectionCell

- (void)addChildView{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setNum:(NSInteger)num{
    _num = num;    
    // 清空数据
    for (UIView *tempView in self.unitViewArray) {
        [tempView removeFromSuperview];
    }
    [self.unitViewArray removeAllObjects];
    
    // 添加数据
    for (int i = 0; i < num; i++) {
        FanScrollUnitView *tempView = [FanScrollUnitView new];
        [self.unitViewArray addObject:tempView];
        [self.contentView addSubview:tempView];
    }
    
    // 设置约束
    
    CGFloat unitWidth = ([UIScreen mainScreen].bounds.size.width - 40) * 1.0 / 4;
    
    for (int i = 0; i < self.unitViewArray.count; i++) {
        
        [self.unitViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (i == 0) {
                make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(20);
            } else {
                make.leading.mas_equalTo(self.unitViewArray[i - 1].mas_trailing);
            }
            
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(16);
            make.width.mas_equalTo(unitWidth);
            make.height.mas_equalTo(100);
        }];
        
    }

}

- (NSMutableArray<FanScrollUnitView *> *)unitViewArray{
    if (!_unitViewArray) {
        _unitViewArray = [NSMutableArray array];
    }
    return _unitViewArray;
}


@end
