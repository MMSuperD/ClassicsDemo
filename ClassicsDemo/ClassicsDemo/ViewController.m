//
//  ViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray<NSDictionary *> *dictArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildView];
}

- (void)addChildView {
    
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    tableView.rowHeight = 44;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

}

#pragma mark UITableViewDelegate,UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dictArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dictArray[indexPath.row][@"title"];
    [cell.textLabel setTextColor:[UIColor redColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *classString = self.dictArray[indexPath.row][@"class"];
    
    UIViewController * vc = [[NSClassFromString(classString) alloc] init];
    vc.title = self.dictArray[indexPath.row][@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray<NSDictionary *> *)dictArray{
    if (!_dictArray) {
        _dictArray = [NSMutableArray arrayWithObject:@{
            @"title":@"EditCell(编辑Cell功能)",
            @"class":@"FanEditCellViewController"
        }];
    }
    return _dictArray;
}


@end
