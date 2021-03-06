//
//  FanScrollUnitView.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/3.
//

#import "FanScrollUnitView.h"

@interface FanScrollUnitView()

@property (nonatomic,strong)UIImageView *iconImageV;

@property (nonatomic,strong)UILabel *bottomTitleLabel;

@property (nonatomic,strong)UIImageView *tipImageV;

@end

@implementation FanScrollUnitView


- (void)addChildView{
    
    self.iconImageV = [UIImageView new];
    [self addSubview:self.iconImageV];
    [self.iconImageV setImage:[UIImage imageNamed:@"icon_beauty"]];
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(56);
        make.centerX.mas_equalTo(self);
    }];
    
    self.bottomTitleLabel = [UILabel fan_labelWithText:@"大美女" font:12 textColorStr:@"#333333"];
    [self addSubview:self.bottomTitleLabel];
    
    [self.bottomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.iconImageV.mas_bottom).mas_offset(4);
    }];
    
    self.tipImageV = [UIImageView new];
    [self addSubview:self.tipImageV];
    
    [self.tipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.iconImageV.mas_trailing).mas_offset(4);
        make.top.mas_equalTo(self.iconImageV.mas_top).mas_offset(-4);
    }];
}


@end
