//
//  FanSelectDelecteView.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/2.
//

#import "FanSelectDelecteView.h"

@interface FanSelectDelecteView()

@property (nonatomic,strong)UIButton *allSelectBtn;

@property (nonatomic,strong)UIButton *deleteBtn;

@property (nonatomic,strong)UIView *topLineView;

@property (nonatomic,strong)UIView *lineView;

@end

@implementation FanSelectDelecteView



- (void)addChildView{
    self.backgroundColor = [UIColor whiteColor];
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.allSelectBtn,self.deleteBtn]];
    [self addSubview:stackView];
    stackView.spacing = 10;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentCenter;
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
        make.height.mas_equalTo(52);
        
    }];
    
    self.topLineView = [UIView new];
    [self addSubview:self.topLineView];
    self.topLineView.backgroundColor = [UIColor fan_colorWithHexString:@"0xE0E0E0"];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];

    
    self.lineView = [UIView new];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor = [UIColor fan_colorWithHexString:@"0xE0E0E0"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.mas_top).mas_offset(14);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-14);
    }];
    
    
}

#pragma mark 全选删除 点击事件

- (void)actionBtn:(UIButton *)sender {
    
    switch (sender.tag) {
        case ClickBtnType_delete:
        {
            
            break;

        }
        case ClickBtnType_allSelect:
        {
            sender.selected = !sender.selected;
            
            if (!sender.selected) {
                self.selectNum = 0;
                self.isAbleUserDeleteBtn = NO;
            }
            
            break;
        }
        default:
            break;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtn:currentView:)]) {
        [self.delegate clickBtn:sender currentView:self];
    }

}

- (void)setIsAbleUserDeleteBtn:(BOOL)isAbleUserDeleteBtn{
    _isAbleUserDeleteBtn = isAbleUserDeleteBtn;
    self.deleteBtn.enabled = isAbleUserDeleteBtn;
}

- (void)setSelectNum:(NSInteger)selectNum{
    _selectNum = selectNum;
    
    if (selectNum > 0) {
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%zd)",selectNum] forState:UIControlStateSelected];
        self.deleteBtn.selected = YES;
        self.deleteBtn.enabled = YES;
    } else {
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.deleteBtn.selected = NO;
        self.deleteBtn.enabled = NO;
    }
}

// 设置全选按钮选中
- (void)setAllSelectedNum:(NSInteger)selectNum{
    self.selectNum = selectNum;
    self.allSelectBtn.selected = YES;
}

// 设置没有选中全选按钮
- (void)setNoSelectAllSelectBtn {
    self.allSelectBtn.selected = NO;
}


#pragma mark -getter
- (UIButton *)allSelectBtn{
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:0];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"icon_radiobox_normal"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"icon_radiobox_select"] forState:UIControlStateSelected];
        [_allSelectBtn setTitleColor:[UIColor fan_colorWithHex:0x333333] forState:UIControlStateNormal];
        _allSelectBtn.selected = NO;
        _allSelectBtn.tag = ClickBtnType_allSelect;
        [_allSelectBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_allSelectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 4)];
    }
    return _allSelectBtn;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:0];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_deleteBtn setTitleColor:[UIColor fan_colorWithHex:0xFF6D01] forState:UIControlStateSelected];
        [_deleteBtn setTitleColor:[UIColor fan_colorWithHex:0xBABABA] forState:UIControlStateNormal];
        _deleteBtn.selected = NO;
        _deleteBtn.tag = ClickBtnType_delete;
        [_deleteBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (BOOL)isAllSellect{
    return self.allSelectBtn.selected;
}

@end
