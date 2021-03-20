//
//  FanMoreTaskDownloadCell.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import "FanMoreTaskDownloadCell.h"
#import "FanDownloadManager.h"
@interface FanMoreTaskDownloadCell()

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *networkSpeedLabel;

@property (nonatomic,strong)UILabel *progressLabel;

@property (nonatomic,strong)UIButton *downloadBtn;

@end

@implementation FanMoreTaskDownloadCell

- (void)addChildView{
    
    self.titleLabel = [UILabel fan_labelWithText:@"网络视频文件01" font:15 textColorStr:@"0x333333"];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).mas_offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
    }];
    
    self.networkSpeedLabel = [UILabel fan_labelWithText:@"123Kb/s" font:15 textColorStr:@"0x333333"];
    [self.contentView addSubview:self.networkSpeedLabel];
    [self.networkSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(8);
    }];
    
    self.progressLabel = [UILabel fan_labelWithText:@"13.5M/100M" font:15 textColorStr:@"0x333333"];
    [self.contentView addSubview:self.progressLabel];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(8);
        make.leading.mas_equalTo(self.networkSpeedLabel.mas_trailing).mas_offset(50);
    }];
    
    self.downloadBtn = [UIButton buttonWithType:0];
    [self.contentView addSubview:self.downloadBtn];
    [self.downloadBtn setTitle:@"download" forState:UIControlStateNormal];
    [self.downloadBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(actionDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView.mas_trailing).mas_offset(-15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)setModel:(FanDownLoadModel *)model{
    _model = model;
    self.titleLabel.text = model.fileName;
    
    self.networkSpeedLabel.text = [NSString stringWithFormat:@"%zd Kb/s",model.speed];
    
    self.progressLabel.text = [NSString stringWithFormat:@"%.2fM/%.2fM",model.tmpFileSize * 1.0/1000000 ,model.totalFileSize * 1.0/1000000];
    
    
}

#pragma 下载按钮点击事件

- (void)actionDownloadBtn:(UIButton *)sender {
    
    [[FanDownloadManager shareManager] startDownloadTask:self.model];
}

@end
