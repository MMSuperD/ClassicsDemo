//
//  FanEditCellViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "FanEditCellViewController.h"
#import "FanEditCellModel.h"
#import "FanSelectDelecteView.h"
#import "FanEditTableViewCell.h"
@interface FanEditCellViewController ()<FanSelectDelecteViewDelegate>

@property (nonatomic,strong)NSMutableArray<FanEditCellModel *> *modelArray;

@property (nonatomic,strong)UIBarButtonItem *rightItem;

@property (nonatomic,strong)FanSelectDelecteView *selectDeleteView;

@property (nonatomic,strong)NSMutableArray<FanEditCellModel *> *selectModelArray;

/// YES :表示现在显示管理   NO:表示现在显示完成
@property (nonatomic,assign)BOOL isManagerStatu;


@end

@implementation FanEditCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildView];
    [self initData];
    [self loadData];
}

- (void)addChildView{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(actionRightItem:)];
    self.rightItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.tableView registerClass:[FanEditTableViewCell class] forCellReuseIdentifier:@"FanEditTableViewCell"];
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.selectDeleteView];
    [self.selectDeleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(52);
    }];
    
    
}

- (void)refreshUI {
    
    self.selectDeleteView.selectNum = self.selectModelArray.count;
    if (self.selectModelArray.count == self.modelArray.count) {
        [self.selectDeleteView setAllSelectedNum:self.selectModelArray.count];
    } else {
        [self.selectDeleteView setNoSelectAllSelectBtn];
    }
    
    if (!self.modelArray.count) {
        self.navigationItem.rightBarButtonItem = nil;
        [self hiddenAllSelectView];
    }
}

- (void)initData{
    self.isManagerStatu = NO;
    [self.rightItem setTitle:@"编辑"];;
}

- (void)loadData{
    int i = 20;
    while (i > 0) {
        
        FanEditCellModel *model = [FanEditCellModel new];
        model.isSelect = NO;
        model.content = [NSString stringWithFormat:@"%d 非常好",i];
        [self.modelArray addObject:model];
        i--;
    }
    
    [self refreshData];
}

- (void)refreshData{
  
    for (FanEditCellModel *model in self.modelArray) {
        model.isEditStatu = self.isManagerStatu;
        model.isSelect = self.selectDeleteView.isAllSellect;
    }
    [self.tableView reloadData];
    [self refreshUI];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FanEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FanEditTableViewCell" forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isManagerStatu) {
        self.modelArray[indexPath.row].isSelect = !self.modelArray[indexPath.row].isSelect;
        // 得到cell
        FanEditTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelect = self.modelArray[indexPath.row].isSelect;
        [self refreshUI];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

#pragma mark - FanSelectDelecteViewDelegate
- (void)clickBtn:(UIButton *)sender currentView:(FanSelectDelecteView *)currentView {
    
    switch (sender.tag) {
        case ClickBtnType_delete:
        {
            // 这里是点击删除按钮
//            [NSObject tipIngContent:@"Cleaning up..."];
            
            //得到需要删除的indexPathArray
            NSArray *indexPathArray = [self getIndexPathArray:self.selectModelArray];
            // 删除数据
            [self.modelArray removeObjectsInArray:self.selectModelArray];
            
            [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationMiddle];
            [self refreshUI];
//            [self refreshData];
//            [NSObject tipSuccessContent:@"删除成功"];

            break;
        }
        case ClickBtnType_allSelect:
        {
            NSLog(@"++是否全选：%d",currentView.isAllSellect);
            
            [self refreshData];
            
            break;
        }
        default:
            break;
    }

}

- (NSArray<NSIndexPath *> *)getIndexPathArray:(NSArray<FanEditCellModel *> *)deleteModelArray{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (FanEditCellModel *model in deleteModelArray) {
        NSInteger tempIndex = [self.modelArray indexOfObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tempIndex inSection:0];
        [tempArray addObject:indexPath];
    }
    
    return tempArray.copy;
    
    
}

#pragma mark 管理 完成的点击事件

- (void)actionRightItem:(UIBarButtonItem *)item{
    
    item.enabled = NO;
    self.isManagerStatu = !self.isManagerStatu;
    if (self.isManagerStatu) {
        [item setTitle:@"完成"];
        [self showAllSelectView];
    }else {
        [item setTitle:@"编辑"];
        [self hiddenAllSelectView];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        item.enabled = YES;
    });
    
    [self refreshData];
 
}

- (void)showAllSelectView{
        
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 52, 0);
    [self.selectDeleteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(52 + self.view.safeAreaInsets.bottom);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];

}

- (void)hiddenAllSelectView{
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.selectDeleteView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(52 + self.view.safeAreaInsets.bottom);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];

}


#pragma mark getter

- (FanSelectDelecteView *)selectDeleteView{
    if (!_selectDeleteView) {
        _selectDeleteView = [[FanSelectDelecteView alloc] initWithFrame:CGRectZero];
        _selectDeleteView.delegate = self;
    }
    return _selectDeleteView;
}

- (NSMutableArray<FanEditCellModel *> *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray<FanEditCellModel *> *)selectModelArray{
    _selectModelArray = [NSMutableArray array];
    for (FanEditCellModel *model in self.modelArray) {
        if (model.isSelect) {
            [_selectModelArray addObject:model];
        }
    }
    return _selectModelArray;
}

- (UIBarButtonItem *)rightItem{
    if (!_rightItem) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:@selector(actionRightItem:)];
        _rightItem = rightItem;
        [rightItem setTintColor:[UIColor fan_colorWithHexString:@"#494949"]];
        [_rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor fan_colorWithHexString:@"#494949"]} forState:UIControlStateNormal];
        [_rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor fan_colorWithHexString:@"#494949"]} forState:UIControlStateDisabled];
    }
    return _rightItem;
}

@end
