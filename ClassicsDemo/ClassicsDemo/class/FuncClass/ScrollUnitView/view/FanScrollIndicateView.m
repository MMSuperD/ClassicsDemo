//
//  FanScrollIndicateView.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/3.
//

#import "FanScrollIndicateView.h"

@interface FanScrollIndicateView()

@property (nonatomic,strong)UIView *backgroundLineView;

@property (nonatomic,strong)UIView *highlightLineView;

@property (nonatomic,assign)CGFloat highlightLineViewWidth;

@end

@implementation FanScrollIndicateView

- (void)addChildView{
    
    self.highlightLineViewWidth = 0;
    
    [self addSubview:self.backgroundLineView];
    [self.backgroundLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.backgroundLineView addSubview:self.highlightLineView];
    
    [self.highlightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.backgroundLineView);
        make.leading.mas_equalTo(self.backgroundLineView.mas_leading).mas_offset(0);
        make.width.mas_equalTo(50);
    }];
    
}

- (void)addAnimation{
    
    [self.highlightLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.backgroundLineView).mas_offset(self.currentIndex * self.highlightLineViewWidth);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.backgroundLineView layoutIfNeeded];
    }];

}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
  
    [self addAnimation];
}

- (void)setNum:(NSInteger)num{
    _num = num;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat hightlightViewWidth = selfWidth * 1.0 / self.num;
    self.highlightLineViewWidth = hightlightViewWidth;
    [self.highlightLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(hightlightViewWidth);
    }];
}

- (UIView *)backgroundLineView{
    if (!_backgroundLineView) {
        _backgroundLineView = [UIView new];
        _backgroundLineView.backgroundColor = [UIColor lightGrayColor];

    }
    return _backgroundLineView;
}

- (UIView *)highlightLineView{
    if (!_highlightLineView) {
        _highlightLineView = [UIView new];
        _highlightLineView.backgroundColor = [UIColor fan_colorWithHexString:@"#3389FF"];
    }
    return _highlightLineView;
}

@end
