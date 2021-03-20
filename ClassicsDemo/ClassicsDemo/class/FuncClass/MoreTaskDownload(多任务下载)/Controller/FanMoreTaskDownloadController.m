//
//  FanMoreTaskDownloadController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/8.
//

#import "FanMoreTaskDownloadController.h"
#import "FanMoreTaskDownloadCell.h"
#import "FanDownLoadModel.h"

@interface FanMoreTaskDownloadController ()

@property (nonatomic,strong)NSArray<FanDownLoadModel *> *downloadModelArray;

@end

@implementation FanMoreTaskDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNotification];
    [self initData];
    [self addChildView];
    [self loadData];
}

- (void)initNotification{
    
    //监听进度通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionFanDownloadProgressNotification:) name:FanDownloadProgressNotification object:nil];
}


- (void)initData{
    self.title = @"多任务下载";
}

- (void)addChildView{
    
    [self.tableView registerClass:[FanMoreTaskDownloadCell class] forCellReuseIdentifier:@"FanMoreTaskDownloadCell"];
    self.tableView.rowHeight = 80;
}

- (void)loadData{
    
    // 模拟网络数据
    NSArray *testData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testData.plist" ofType:nil]];
    // 转模型
    self.downloadModelArray = [NSArray yy_modelArrayWithClass:[FanDownLoadModel class] json:testData];
    
    [self.tableView reloadData];
    
}

#pragma mark 监听通知的变化

- (void)actionFanDownloadProgressNotification:(NSNotification *)sender {
    
    
    @synchronized (self) {
        FanDownLoadModel *downloadModel = sender.object;
        [self.downloadModelArray enumerateObjectsUsingBlock:^(FanDownLoadModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.url isEqualToString:downloadModel.url]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    FanMoreTaskDownloadCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
                    if (cell) {
                        //这里需要刷新cell
                        cell.model = downloadModel;
                    }
                });
                // 这里得到了index
            
                *stop = YES;
                return;
            }
        } ];
    }
}


#pragma mark UITableViewDataSource,UItableViewDelegate

- (NSInteger)numrberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.downloadModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FanMoreTaskDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FanMoreTaskDownloadCell" forIndexPath:indexPath];
    cell.model = self.downloadModelArray[indexPath.row];
    return cell;
}

#pragma mark getter

- (NSArray<FanDownLoadModel *> *)downloadModelArray{
    if (!_downloadModelArray) {
        _downloadModelArray = [NSArray array];
    }
    return _downloadModelArray;
}



@end
