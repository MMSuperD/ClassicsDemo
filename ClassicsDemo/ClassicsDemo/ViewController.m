//
//  ViewController.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray<NSDictionary *> *dictArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSMutableArray<NSDictionary *> *)dictArray{
    if (!_dictArray) {
        _dictArray = [NSMutableArray arrayWithObject:@{
            @"title":@"EditCell(编辑Cell功能)"
        }];
    }
    return _dictArray;
}


@end
