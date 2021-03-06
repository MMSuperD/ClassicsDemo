//
//  FanScrollUnitCell.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/3.
//

#import "FanScrollUnitCell.h"
#import "FanScrollUnitView.h"
#import "FanScrollCollectionCell.h"
#import "FanScrollIndicateView.h"

@interface FanScrollUnitCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSMutableArray<FanScrollUnitView *> *unitViewArray;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)FanScrollIndicateView *indicateView;

@end

@implementation FanScrollUnitCell


- (void)addChildView{
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self.collectionView registerClass:[FanScrollCollectionCell class] forCellWithReuseIdentifier:@"FanScrollCollectionCell"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.indicateView];
    
    
}

- (void)setNum:(NSInteger)num{
    _num = num;
    num = 0;
    
    // 清空数据
    for (UIView *tempView in self.unitViewArray) {
        [tempView removeFromSuperview];
    }
    [self.unitViewArray removeAllObjects];
    
    // 添加数据
    for (int i = 0; i < num; i++) {
        FanScrollUnitView *tempView = [FanScrollUnitView new];
        [self.unitViewArray addObject:tempView];
        [self addSubview:tempView];
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
    self.indicateView.num = [self collectionView:nil numberOfItemsInSection:nil];
    [self.indicateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        make.height.mas_equalTo(4);
        make.width.mas_equalTo(12 * self.indicateView.num);
    }];

}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FanScrollCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FanScrollCollectionCell" forIndexPath:indexPath];
    cell.num = indexPath.row % 2 == 0 ? 4:2;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.indicateView.currentIndex = indexPath.row;
    
}





- (NSMutableArray<FanScrollUnitView *> *)unitViewArray{
    if (!_unitViewArray) {
        _unitViewArray = [NSMutableArray array];
    }
    return _unitViewArray;
}

- (FanScrollIndicateView *)indicateView{
    if (!_indicateView) {
        _indicateView = [FanScrollIndicateView new];
    }
    return _indicateView;
}


@end
