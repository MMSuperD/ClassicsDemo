//
//  FAN_TransitionView2Controller.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/20.
//

#import "FAN_TransitionView2Controller.h"

@interface FAN_TransitionView2Controller ()

@end

@implementation FAN_TransitionView2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"转场控制器2";
    
//    self.view.backgroundColor = [UIColor fan_randomColor];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor fan_randomColor];


}

- (void)actionBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

////告诉nav，我想自己自定义一个转场
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    if (operation == UINavigationControllerOperationPop) {
//        FAN_CircleTransition *trans = [FAN_CircleTransition new];
//        trans.isPush = NO;
//        return trans;
//    }else{
//        return nil;
//    }
//}


@end
