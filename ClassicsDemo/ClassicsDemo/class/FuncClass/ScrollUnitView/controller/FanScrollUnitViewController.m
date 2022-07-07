//
//  FanScrollUnitViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/3.
//

#import "FanScrollUnitViewController.h"
#import "FanScrollUnitCell.h"

@interface FanScrollUnitViewController ()

@end

@implementation FanScrollUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildView];
}


- (void)addChildView{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
    
    [self.tableView registerClass:[FanScrollUnitCell class] forCellReuseIdentifier:@"FanScrollUnitCell"];
//    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = 100;
}

#pragma mark UITableViewDataSource,UItableViewDelegate

- (NSInteger)numrberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FanScrollUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FanScrollUnitCell" forIndexPath:indexPath];
    cell.num = 4;
    return cell;
}

@end
