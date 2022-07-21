//
//  FAN_TransitionViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_TransitionViewController.h"
@interface FAN_TransitionViewController ()

@end

@implementation FAN_TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildSubview];
    
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    // 这句话必须放在 viewWillAppear 方法里面,不然,当控制器回来的时候,delegate 就变为nil 了
//    self.navigationController.delegate = self;

    
    self.view.backgroundColor = [UIColor blueColor];


}

- (void)addChildSubview{
    
    self.title = @"转场控制器";
    
    
    UIButton *btn = [UIButton buttonWithType:0];;
    [self.view addSubview:btn];
    [btn setTitle:@"转场" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor fan_randomColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor fan_randomColor]];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.circleBtn = btn;
    btn.radius = 30;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-20);
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(-20);
        make.size.mas_equalTo(60);
    }];
    

}

- (void)actionBtn:(UIButton *)sender{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"FAN_TransitionView2Controller") alloc] init] animated:YES];
}


////告诉nav，我想自己自定义一个转场
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    if (operation == UINavigationControllerOperationPush) {
//        FAN_CircleTransition *trans = [FAN_CircleTransition new];
//        trans.isPush = YES;
//        return trans;
//    }else{
//        return nil;
//    }
//}
@end
