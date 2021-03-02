//
//  FanEditTableViewCell.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/2.
//

#import "FanEditTableViewCell.h"

@interface FanEditTableViewCell()

@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong)UILabel *contentLabel;

@property (nonatomic,strong)UIView *bottomLineView;

@end

@implementation FanEditTableViewCell


- (void)addChildView{
    
    [self.contentView addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.selectBtn.mas_trailing).mas_offset(2);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(20);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-20);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.contentView layoutIfNeeded];

    
}

- (void)setModel:(FanEditCellModel *)model{
    _model = model;
    
    if (model.isEditStatu) {
        self.selectBtn.hidden = NO;
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.selectBtn.mas_trailing).mas_offset(4);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
        }];
        
    } else{
        self.selectBtn.hidden = YES;
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(20);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
        }];
    }
    
    self.selectBtn.selected = model.isSelect;
    self.contentLabel.text = model.content;
    
    [self addAnimation];
}



- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    
    self.selectBtn.selected = isSelect;
    
}

- (void)addAnimation{
    [UIView animateWithDuration:0.25 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

#pragma mark getter

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:0];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_radiobox_normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_radiobox_select"] forState:UIControlStateSelected];
        _selectBtn.selected = NO;
        _selectBtn.userInteractionEnabled = NO;
    }
    return _selectBtn;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"我就是这么帅气";
        _contentLabel.numberOfLines = 2;
        [_contentLabel setFont:[UIFont systemFontOfSize:16]];
        _contentLabel.textColor = [UIColor fan_colorWithHexString:@"0x494949"];
    }
    return _contentLabel;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor fan_colorWithHexString:@"0xE0E0E0"];
    }
    return _bottomLineView;
}

@end
