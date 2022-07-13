//
//  FAN_3DModelShowViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/11.
//

#import "FAN_3DModelShowViewController.h"
#import <SceneKit/SceneKit.h>

@interface FAN_3DModelShowViewController ()

@end

@implementation FAN_3DModelShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildSubview];
}

- (void)addChildSubview{
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:CGRectZero];
    
    SCNScene *scene = [SCNScene sceneNamed:@""];
    [self.view addSubview:scnView];
    
}

@end
