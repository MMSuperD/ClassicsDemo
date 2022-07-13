//
//  ViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "ViewController.h"
#include "Fan_TestViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray<NSDictionary *> *dictArray;

@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self addChildView];
}

- (void)initData{
    
    self.title = @"常用功能列表";
    
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
    
//    Fan_TestViewController *vc = [Fan_TestViewController new];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (NSMutableArray<NSDictionary *> *)dictArray{
    if (!_dictArray) {
        _dictArray = [NSMutableArray arrayWithObject:@{
            @"title":@"EditCell(编辑Cell功能)",
            @"class":@"FanEditCellViewController"
        }];
        
        _dictArray = [NSMutableArray arrayWithObjects:
                      @{
                          @"title":@"EditCell(编辑Cell功能)",
                          @"class":@"FanEditCellViewController"
                      },
                      @{
                          @"title":@"ScrollUnitView(滚动单元View功能)",
                          @"class":@"FanScrollUnitViewController"
                      },
                      @{
                          @"title":@"蓝牙模块",
                          @"class":@"FAN_CoreBlueModuleController"
                      },
                      @{
                          @"title":@"直播模块(声网SDK)",
                          @"class":@"FAN_TestLiveStreamingViewController"
                      },
                      @{
                          @"title":@"性能检查",
                          @"class":@"Fan_PowerTestViewController"
                      },
                      @{
                          @"title":@"响应者链条测试",
                          @"class":@"Fan_ResponseChainController"
                      },
                      @{
                          @"title":@"常用算法",
                          @"class":@"Fan_CommonlyAlgorithmController"
                      },
                      @{
                          @"title":@"webView于JS交互",
                          @"class":@"FAN_webViewController"
                      },
                      @{
                          @"title":@"直播列表(RTMP + ijKPlayer + LFLiveKit)",
                          @"class":@"FAN_LiveListViewController"
                      },
                      
                      @{
                          @"title":@"即时通讯(WebSocket + SocketRocket)",
                          @"class":@"FAN_IMViewController"
                      },
                      
                      @{
                          @"title":@"沙盒的使用(sandbox)",
                          @"class":@"FAN_SandBoxViewController"
                      },
                      @{
                          @"title":@"3d模型展示(SceneKit)",
                          @"class":@"FAN_3DModelShowViewController"
                      },


                      nil];
    }
    return _dictArray;
}







@end

