//
//  Fan_TestViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2022/6/2.
//

#import "Fan_TestViewController.h"

@interface Fan_TestViewController ()

@end

@implementation Fan_TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [UIButton buttonWithType:0];
    
    [self.view addSubview:btn];
    [btn setTitle:@"弹起" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.tag = 100;

    
    [btn setFrame:CGRectMake(100, 100, 50, 50)];
    
    UIButton *disBtn = [UIButton buttonWithType:0];
    
    [self.view addSubview:disBtn];
    disBtn.tag = 101;
    [disBtn setTitle:@"消失" forState:UIControlStateNormal];
    [disBtn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [disBtn setBackgroundColor:[UIColor redColor]];
    
    [disBtn setFrame:CGRectMake(200, 100, 50, 50)];
}


- (void)actionBtn:(UIButton *)sender {
    
    static int title = 0;
    switch (sender.tag) {
        case 100:
        {
            Fan_TestViewController *vc = [Fan_TestViewController new];
            vc.title = @(title).description;
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
            break;
        }
            
        case 101:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            
            break;
        }
            
        default:
            break;
    }
    
    
}


@end
