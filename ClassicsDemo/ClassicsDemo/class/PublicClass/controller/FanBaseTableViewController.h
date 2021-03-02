//
//  FanBaseTableViewController.h
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "FanBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FanBaseTableViewController : FanBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

/// 默认已经添加了
- (void)addTableView;

@end

NS_ASSUME_NONNULL_END
