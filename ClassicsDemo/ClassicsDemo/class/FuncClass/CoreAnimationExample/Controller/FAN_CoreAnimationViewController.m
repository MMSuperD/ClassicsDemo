//
//  FAN_CoreAnimationViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/19.
//

#import "FAN_CoreAnimationViewController.h"
#import "FAN_BaseAnimationHeartCell.h"
#import "FAN_BaseTransitionAnimationCell.h"
#import "FAN_BaseGroupAnimationCell.h"
#import "FAN_ScreenShotAnimationCell.h"
#import "FAN_CurveAnimationCell.h"
#import "FAN_TextLayerCell.h"
#import "FAN_StereoscopicCell.h"
#import "FAN_TransitionCell.h"
@interface FAN_CoreAnimationViewController ()

@property (nonatomic,strong)NSMutableArray<NSDictionary *> *dictArray;

@end

@implementation FAN_CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildSubview];
    
}

- (void)addChildSubview{
    
    for (int i = 0; i < self.dictArray.count; i++) {
        
        [self.tableView registerClass:NSClassFromString(self.dictArray[i][@"className"]) forCellReuseIdentifier:self.dictArray[i][@"identifier"]];
    }    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
}

#pragma mark UITableViewDelegate | UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dictArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:self.dictArray[indexPath.row][@"identifier"] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor fan_randomColor];
    
    return cell ? cell:[UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class cls = NSClassFromString(self.dictArray[indexPath.row][@"className"]);
    
    return [(UITableViewCell *)cls cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *action = self.dictArray[indexPath.row][@"cellClick"];
    
    if (action) {
       
        // 得到当前的cell
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        [cell fan_performFuncStr:action withObjects:nil];
        [cell cellClick];
    }
    
}

- (void)addHeaderRefresh{
    
}

- (void)addFooterRefresh{
    
    
}

#pragma mark Lazy

- (NSMutableArray<NSDictionary *> *)dictArray{
    if (!_dictArray) {
        _dictArray = [NSMutableArray arrayWithArray:@[
        
            @{
                @"className":@"FAN_BaseAnimationHeartCell",
                @"identifier":@"FAN_BaseAnimationHeartCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_BaseTransitionAnimationCell",
                @"identifier":@"FAN_BaseTransitionAnimationCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_BaseGroupAnimationCell",
                @"identifier":@"FAN_BaseGroupAnimationCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_ScreenShotAnimationCell",
                @"identifier":@"FAN_ScreenShotAnimationCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_CurveAnimationCell",
                @"identifier":@"FAN_CurveAnimationCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_TextLayerCell",
                @"identifier":@"FAN_TextLayerCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_StereoscopicCell",
                @"identifier":@"FAN_StereoscopicCell",
                @"cellHeightFuncName":@"cellHeight"
            },
            @{
                @"className":@"FAN_TransitionCell",
                @"identifier":@"FAN_TransitionCell",
                @"cellHeightFuncName":@"cellHeight",
                @"cellClick":@"cellClick" //这个是点击事件
            },

        ]];
    }
    return _dictArray;
}



@end
