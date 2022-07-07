//
//  FAN_SandBoxViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/7/6.
//

#import "FAN_SandBoxViewController.h"

@interface FAN_SandBoxViewController ()

@end

@implementation FAN_SandBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self sandbox_document];
    [self sandbox_library];
    [self sandbox_temp];
    [self sandbox_home];
    [self saveUserDefault];
    [self sandbox_document_writeData];
    [self sandbox_tmp_writeData];

}


- (void)sandbox_document{
    
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (documentsPathArr.count) {
        NSString *document = documentsPathArr.lastObject;
        NSLog(@"document:%@",document);
    }
    
}

- (void)sandbox_library{
   
    NSArray *cachesPathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    if (cachesPathArr.count) {
        NSString *caches = cachesPathArr.lastObject;
        NSLog(@"caches:%@",caches);
    }
}

- (void)sandbox_temp{
    
    
    NSString *tempPath = NSTemporaryDirectory();

    NSLog(@"tmp:%@", tempPath);
    
}

// 沙盒主目录
- (void)sandbox_home {
    
    NSLog(@"home:%@", NSHomeDirectory());
}


- (void)saveUserDefault{
    
    NSMutableArray *mutArr = [[NSMutableArray alloc]initWithObjects:@"1", nil];

    //存入数组并同步

    [[NSUserDefaults standardUserDefaults] setObject:mutArr forKey:@"mutableArr"];

    [[NSUserDefaults standardUserDefaults] synchronize];

    //读取存入的数组 打印

    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArr"];

    NSLog(@"%@",arr);
    
}

- (void)sandbox_document_writeData {
    
    NSString *string = [[NSBundle mainBundle] pathForResource:@"testPlist" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:string];

    NSLog(@"%@",dic);   //打印文件中的内容

    //写入plist文件内容

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);

    NSString *plistpath = [paths objectAtIndex:0];

    NSLog(@"path = %@",plistpath);

    NSString *filename=[plistpath stringByAppendingPathComponent:@"testPlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];

    [fm createFileAtPath:filename contents:nil attributes:nil];

    //写入内容

    NSDictionary *tempDict = [NSDictionary dictionaryWithDictionary:@{@"name":@"fan"}];

    [tempDict writeToFile:filename atomically:YES];

    //读文件

    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];

    NSLog(@"dic is:%@",dic2);
    
}

- (void)sandbox_tmp_writeData {
    
    NSString *string = [[NSBundle mainBundle] pathForResource:@"testPlist" ofType:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:string];

    NSLog(@"%@",dic);   //打印文件中的内容

    //写入plist文件内容


    NSString *plistpath = NSTemporaryDirectory();

    NSLog(@"path = %@",plistpath);

    NSString *filename=[plistpath stringByAppendingPathComponent:@"testPlist_tmp.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];

    [fm createFileAtPath:filename contents:nil attributes:nil];

    //写入内容

    NSDictionary *tempDict = @{@"name":@"fan"};

    [tempDict writeToFile:filename atomically:YES];

    //读文件

    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];

    NSLog(@"dic is:%@",dic2);
    
}

@end
