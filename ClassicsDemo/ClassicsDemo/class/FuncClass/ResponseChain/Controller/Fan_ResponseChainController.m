//
//  Fan_ResponseChainController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/21.
//

#import "Fan_ResponseChainController.h"

@interface Fan_ResponseChainController ()

@end

@implementation Fan_ResponseChainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    FAN_BaseControl *control= [[FAN_BaseControl alloc] initWithFrame:CGRectZero];
    [self.view addSubview:control];
    control.backgroundColor = [UIColor fan_randomColor];
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    [control addTarget:self action:@selector(actionControl:) forControlEvents:UIControlEventTouchUpInside];
    
   UIButton *hh = [UIButton buttonWithType:0];
    [control addSubview:hh];
    hh.backgroundColor = [UIColor fan_randomColor];
    [hh setTitle:@"点我" forState:UIControlStateNormal];
    [hh addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [hh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(control.mas_centerX);
        make.centerY.mas_equalTo(control.mas_centerY);
    }];
    
    UILabel *hhLabel = [UILabel fan_labelWithText:@"label" font:18 textColorStr:@"#000000"];
    [control addSubview:hhLabel];
    hhLabel.backgroundColor = [UIColor fan_randomColor];
//    hhLabel.userInteractionEnabled = YES;
//    hhLabel.enabled = YES;
    
    [hhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.mas_equalTo(control);
        make.width.mas_equalTo(60);
    }];
}

- (void)actionControl:(UIControl *)control {
    
    NSLog(@"actionControl");
}

- (void)actionBtn:(UIControl *)control {
    
    NSLog(@"actionBtn");
}




@end
