//
//  FanSelectDelecteView.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/2.
//

#import "FanBaseView.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ClickBtnType) {
    ClickBtnType_allSelect = 200, //全选
    ClickBtnType_delete = 201 //删除
};

@class FanSelectDelecteView;

@protocol FanSelectDelecteViewDelegate <NSObject>

- (void)clickBtn:(UIButton *)sender currentView:(FanSelectDelecteView *)currentView;

@end

@interface FanSelectDelecteView : FanBaseView
/**
 删除按钮能够使用
 */
@property (nonatomic,assign)BOOL isAbleUserDeleteBtn;


@property (nonatomic,weak)id<FanSelectDelecteViewDelegate> delegate;

/**
 删除的个数
 */
@property (nonatomic,assign)NSInteger selectNum;

/**
 是否全选
 */
@property (nonatomic,assign,readonly)BOOL isAllSellect;

// 设置全选按钮选中
- (void)setAllSelectedNum:(NSInteger)selectNum;

// 设置没有选中全选按钮
- (void)setNoSelectAllSelectBtn;

@end

NS_ASSUME_NONNULL_END
