//
//  FAN_IMViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/6.
//

#import "FAN_IMViewController.h"
#import "FAN_WebSocket.h"
#import "FAN_LeftChatCell.h"
#import "FAN_RightChatCell.h"


@interface FAN_IMViewController ()<FAN_WebSocketDelegate>


@property (nonatomic,strong)UITextField *inputTextFiled;

@property (nonatomic,strong)UIButton *sendBtn;


@property (nonatomic,strong)UIButton *closeConnectBtn;

@property (nonatomic,strong)UIButton *connectBtn;

@property (nonatomic,strong)UILabel *connectStateLabel;

@property (nonatomic,strong)FAN_WebSocket *webSocket;

@property (nonatomic,strong)NSMutableArray<NSDictionary *> *messageArray;

@end

@implementation FAN_IMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self addChildSubview];
    
    [self initData];


}

- (void)addFooterRefresh{
    
    
}

- (void)addHeaderRefresh{
    
    
}

- (void)initData{
    
    [self.tableView registerClass:[FAN_LeftChatCell class] forCellReuseIdentifier:@"FAN_LeftChatCell"];
    [self.tableView registerClass:[FAN_RightChatCell class] forCellReuseIdentifier:@"FAN_RightChatCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
}

- (void)addChildSubview{
    

    self.tableView.backgroundColor = [UIColor fan_colorWithHexString:@"0xf1fdf2"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
    
    [self.view addSubview:self.connectStateLabel];
    [self.connectStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.tableView.mas_trailing);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.nvView.mas_bottom).mas_offset(20);
    }];

    
    [self.view addSubview:self.inputTextFiled];
    [self.inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.tableView.mas_trailing);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.connectStateLabel.mas_bottom).mas_offset(20);
    }];
    
    
    [self.view addSubview:self.connectBtn];
    [self.connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.tableView.mas_trailing);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.inputTextFiled.mas_bottom).mas_offset(20);
    }];
    
    
    [self.view addSubview:self.closeConnectBtn];
    [self.closeConnectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.tableView.mas_trailing);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.connectBtn.mas_bottom).mas_offset(20);
    }];
    
    [self.view addSubview:self.sendBtn];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.mas_equalTo(self.tableView.mas_trailing);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.closeConnectBtn.mas_bottom).mas_offset(20);
    }];
    
    

}

#pragma mark 刷新tableview

- (void)refreshTableView{
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

#pragma mark action

- (void)actionBtn:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:// 链接
        {
            [self.webSocket connectWebSocket];
            
            
            NSLog(@"链接");
            break;

        }
        case 101:// 断开链接
        {
            
            [self.webSocket closeWebSocket];
            NSLog(@"断开链接");
            break;

        }

        case 102:// 发送消息
        {
            NSString *str = self.inputTextFiled.text;
            
//            [self.webSocket sendMsg:str];
            
            if ([self.webSocket sendMessage:str]) {
                [self.messageArray addObject:@{
                    @"type":@"client",
                    @"content":str
                }];
               
                [self refreshTableView];
            }
            
            NSLog(@"发送消息");
            break;
        }

                        
        default:
            break;
    }
}

#pragma mark UITableViewDelegate,UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.messageArray[indexPath.row];
    
    if ([dict[@"type"] isEqualToString:@"server"]) {
        
        FAN_LeftChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAN_LeftChatCell" forIndexPath:indexPath];
        cell.dict = dict;
        return cell;
    } else {
        
        FAN_RightChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAN_RightChatCell" forIndexPath:indexPath];
        cell.dict = dict;
        return cell;


    }
    
    return [UITableViewCell new];
}




#pragma mark FAN_WebSocketDelegate
- (void)fan_webSocketDidReceiveMessage:(NSString *)message{
    
    if (message) {
       
        [self.messageArray addObject:@{
            @"type":@"server",
            @"content":message
        }];
        
        [self refreshTableView];
    }
    
}

- (void)fan_webSocketConnectedSuccess:(FAN_ReadyState)state{
    /**
     typedef NS_ENUM(NSInteger, FAN_ReadyState) {
         FAN_CONNECTING   = 0,// 制动连接中
         FAN_OPEN         = 1, //链接成功
         FAN_CLOSING      = 2, //正在关闭链接
         FAN_CLOSED       = 3, // 已经关闭链接
     };

     */
    
    switch (state) {
        case FAN_OPEN:
        {
            self.connectStateLabel.text = @"已经链接";
            
            break;
        }
        case FAN_CONNECTING:
        {
            self.connectStateLabel.text = @"链接中...";

            break;

        }
        case FAN_CLOSING:
        {
            self.connectStateLabel.text = @"关闭中...";

            break;

        }

        case FAN_CLOSED:
        {
            self.connectStateLabel.text = @"已经关闭";

            break;
        }

        default:
            break;
    }
    
}

#pragma mark lazy

- (UILabel *)connectStateLabel{
    if (!_connectStateLabel) {
        _connectStateLabel = [UILabel fan_labelWithText:@"未连接" font:12 textColorStr:@"0x000000"];
    }
    return _connectStateLabel;
}


- (UITextField *)inputTextFiled{
    if (!_inputTextFiled) {
        _inputTextFiled = [UITextField new];
        _inputTextFiled.placeholder = @"input text";
        _inputTextFiled.backgroundColor = [UIColor grayColor];
        _inputTextFiled.text = @"I am very well";
        _inputTextFiled.radius = 8;
    }
    return _inputTextFiled;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:0];
        [_sendBtn setTitle:@"send message" forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[UIColor redColor]];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendBtn.tag = 102;
        [_sendBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIButton *)closeConnectBtn{
    
    if (!_closeConnectBtn) {
        _closeConnectBtn = [UIButton buttonWithType:0];
        [_closeConnectBtn setTitle:@"close socket" forState:UIControlStateNormal];
        [_closeConnectBtn setBackgroundColor:[UIColor redColor]];
        [_closeConnectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeConnectBtn.tag = 101;
        [_closeConnectBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeConnectBtn;
}

- (UIButton *)connectBtn{
    
    if (!_connectBtn) {
        _connectBtn = [UIButton buttonWithType:0];
        [_connectBtn setTitle:@"connect socket" forState:UIControlStateNormal];
        [_connectBtn setBackgroundColor:[UIColor redColor]];
        [_connectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _connectBtn.tag = 100;
        [_connectBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectBtn;
    
}

- (FAN_WebSocket *)webSocket{
    if (!_webSocket) {
        _webSocket = [[FAN_WebSocket alloc] initWithServerIp:@"ws://192.168.0.188:8088"];
        _webSocket.delegate = self;
//        _webSocket = [[FAN_WebSocket alloc] initWithServerIp:@"ws://180.101.49.12:80"];

    }
    return _webSocket;
}

- (NSMutableArray<NSDictionary *> *)messageArray {
    
    if (!_messageArray) {
        _messageArray = [NSMutableArray arrayWithArray:@[
            @{
                @"type":@"server",
                @"content":@"I am very well"
            },
            @{
                @"type":@"server",
                @"content":@"I am very well"
            },
            @{
                @"type":@"client",
                @"content":@"I am very well"
            },
            @{
                @"type":@"server",
                @"content":@"I am very well"
            },  @{
                @"type":@"server",
                @"content":@"I am very well"
            },
            @{
                @"type":@"client",
                @"content":@"I am very well"
            },
            @{
                @"type":@"server",
                @"content":@"I am very well"
            },
            @{
                @"type":@"server",
                @"content":@"I am very well"
            }
        ]];
    }
    return _messageArray;
}

@end
