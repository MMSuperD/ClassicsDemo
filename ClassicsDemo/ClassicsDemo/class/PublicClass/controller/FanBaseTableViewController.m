//
//  FanBaseTableViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "FanBaseTableViewController.h"

@interface FanBaseTableViewController ()

@end

@implementation FanBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    
}

- (void)addTableView{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark UITableViewDataSource,UItableViewDelegate

- (NSInteger)numrberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"hello word";
    return cell;
}




- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

@end
