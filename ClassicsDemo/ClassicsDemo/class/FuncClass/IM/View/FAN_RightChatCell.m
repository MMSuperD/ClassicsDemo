//
//  FAN_RightChatCell.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/6.
//

#import "FAN_RightChatCell.h"

@interface FAN_RightChatCell()

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *contentLabel;

@end

@implementation FAN_RightChatCell

- (void)addChildView{
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    self.titleLabel = [UILabel fan_labelWithText:@"我" font:15 textColorStr:@"0xff0000"];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentRight;

    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
    }];
    
    self.contentLabel = [UILabel fan_labelWithText:@"you are very well" font:15 textColorStr:@"0x000000"];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.textAlignment = NSTextAlignmentRight;
    self.contentLabel.backgroundColor = [UIColor greenColor];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.preferredMaxLayoutWidth = 200;

    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_greaterThanOrEqualTo(self.contentView.mas_leading).mas_offset(50);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
    }];
    
    
}

- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    self.contentLabel.text = dict[@"content"];
}


@end
