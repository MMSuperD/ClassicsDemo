//
//  FAN_CoreBlueModuleController.m
//  ClassicsDemo
//
//  Created by xzmac on 2022/5/11.
//

#import "FAN_CoreBlueModuleController.h"

#import "FAN_CoreBlueTools.h"

@interface FAN_CoreBlueModuleController ()<
FAN_CoreBlueToolsDelegate
>

@property (nonatomic,strong)FAN_CoreBlueTools* coreblueTools;

@property (nonatomic,strong)NSArray *dataArray;


@end

@implementation FAN_CoreBlueModuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self addChildSubview];

}


- (void)initData{
    self.coreblueTools = [FAN_CoreBlueTools new];
    self.coreblueTools.delegate = self;
    
}

- (void)addChildSubview{
    
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:stackView];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 10;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.backgroundColor = [UIColor redColor];
    
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
        make.height.mas_equalTo(200);
    }];
    
    
    UIButton *scanbtn = [UIButton buttonWithType:0];
    [scanbtn setTitle:@"扫描设备" forState:UIControlStateNormal];
    [scanbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stackView addArrangedSubview:scanbtn];
    [scanbtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    scanbtn.tag = 1;
    scanbtn.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *scanServer = [UIButton buttonWithType:0];
    [scanServer setTitle:@"扫描服务" forState:UIControlStateNormal];
    [scanServer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stackView addArrangedSubview:scanServer];
    [scanServer addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    scanServer.tag = 2;
    scanServer.backgroundColor = [UIColor whiteColor];

    
    UIButton *scanCharac= [UIButton buttonWithType:0];
    [scanCharac setTitle:@"扫描特征" forState:UIControlStateNormal];
    [scanCharac setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stackView addArrangedSubview:scanCharac];
    [scanCharac addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    scanCharac.tag = 3;
    scanCharac.backgroundColor = [UIColor whiteColor];

    
    UIButton *writeDataBtn = [UIButton buttonWithType:0];
    [writeDataBtn setTitle:@"写入数据" forState:UIControlStateNormal];
    [writeDataBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stackView addArrangedSubview:writeDataBtn];
    [writeDataBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    writeDataBtn.tag = 4;
    writeDataBtn.backgroundColor = [UIColor whiteColor];

    
    UIButton *disConnectBtn = [UIButton buttonWithType:0];
    [disConnectBtn setTitle:@"断开连接" forState:UIControlStateNormal];
    [disConnectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stackView addArrangedSubview:disConnectBtn];
    [disConnectBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    disConnectBtn.tag = 4;
    disConnectBtn.backgroundColor = [UIColor whiteColor];

    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(stackView.mas_bottom);
    }];
    
}

#pragma mark  点击事件
- (void)actionBtn:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
        {
            [self.coreblueTools scanForPeripheralsWithServices:nil options:nil];
            
            break;
        }
        case 2:
        {
            break;

        }
        case 3:
        {
            break;

        }
        case 4:
        {
            break;

        }
        case 5:
        {
            break;

        }
            
        default:
            break;
    }
    
}

#pragma mark FAN_CoreBlueToolsDelegate

- (void)coreBuleCBPeripheralArray:(NSArray<CBPeripheral *> *)cbPeripheralArray{
    
    self.dataArray = cbPeripheralArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (indexPath.row < self.dataArray.count) {
        
        if ([self.dataArray[indexPath.row] isKindOfClass:[CBPeripheral class]]) {
            CBPeripheral *peripheral = self.dataArray[indexPath.row];
            cell.textLabel.text = peripheral.name;
        }
        
        if ([self.dataArray[indexPath.row] isKindOfClass:[CBService class]]) {
            CBService *service = self.dataArray[indexPath.row];
            cell.textLabel.text = service.UUID.UUIDString;
        }
        
        if ([self.dataArray[indexPath.row] isKindOfClass:[CBCharacteristic class]]) {
            CBCharacteristic *characteristic = self.dataArray[indexPath.row];
            cell.textLabel.text = characteristic.UUID.UUIDString;
        }
    }

    return cell;
}

- (void)dealloc{
    
}




@end
