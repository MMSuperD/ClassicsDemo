//
//  Fan_CommonlyAlgorithmController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/22.
//

#import "Fan_CommonlyAlgorithmController.h"

@interface Fan_CommonlyAlgorithmController ()

@property (nonatomic,strong)NSArray<NSDictionary *> *dictArray;

@end

@implementation Fan_CommonlyAlgorithmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildSubview];
}

- (void)addChildSubview{
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dictArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dictArray[indexPath.row][@"title"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *funcStr = self.dictArray[indexPath.row][@"func"];
    
    SEL sel = NSSelectorFromString(funcStr);
    
    [self fan_performSelector:sel withObjects:self.dictArray[indexPath.row][@"paramsArray"]];

    
    // 这个是没有参数的运行方案
//    IMP imp = [self methodForSelector:sel];
//
//    void (*func)(id, SEL) = (void *)imp;
//
//    func(self,sel);

}



- (NSArray<NSDictionary *> *)dictArray{
    
    if (!_dictArray) {
        _dictArray = @[
            @{
                @"title":@"字符串反转",
                @"value":@"",
                @"func":NSStringFromSelector(@selector(stringInversion))
            },
            @{
                @"title":@"多个参数的调用",
                @"value":@"",
                @"func":NSStringFromSelector(@selector(moreParamsTestForTitle:subTitle:content:isHave:object:array:)),
                @"paramsArray":@[@"小王",@"男",@"爱好写代码",@(1),@(12),@[@1,@23,@43]]
            }
        ];
    }
    return _dictArray;
}

#pragma mark 算法函数(CommonlyAlgorithm)

- (void)stringInversion{
    
    NSString *resourceStr = @"I have an apple";
    
    NSMutableString *newStr = [NSMutableString string];
    
    for (int i = (int )(resourceStr.length - 1); i >= 0; i--) {
        
        [newStr appendString:[resourceStr substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"old:%@new:%@",resourceStr,newStr);
}

- (int)moreParamsTestForTitle:(NSString *)title subTitle:(NSString *)subTitle content:(NSString *)content isHave:(BOOL)have object:(id)object array:(NSArray *)array{
    
    NSLog(@"%@",title);
    
    return 100;
}

/**
 *  @brief 根据方法名 参数 调用方法
 *  @param selector 方法名
 *  @param objects  参数数组
 *  @return 被调用的方法的返回值和参数都不支持结构体和block，仅仅支持基本数值类型和对象
 */
- (id)fan_performSelector:(SEL)selector withObjects:(NSArray *)objects
{
    
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        
        //可以抛出异常也可以不操作。
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    //获取返回类型
    const char *returnType = [signature methodReturnType];
    // 判断返回值类型 根据类型转化数据类型
    NSString *returnTypeString = [NSString stringWithUTF8String:returnType];
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (int i = 0; i < paramsCount; i++) {
        // 取出参数对象
        id obj = objects[i];
        // 判断需要设置的参数是否是NSNull, 如果是就设置为nil
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        // 获取参数类型
        const char *argumentType = [signature getArgumentTypeAtIndex:i + 2];
        
        // 判断参数类型 根据类型转化数据类型
        NSString *argumentTypeString = [NSString stringWithUTF8String:argumentType];
        
        if ([argumentTypeString isEqualToString:@"@"]) { // id
            [invocation setArgument:&obj atIndex:i + 2];
        }  else if ([argumentTypeString isEqualToString:@"B"]) { // bool
            bool objVaule = [obj boolValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"f"]) { // float
            float objVaule = [obj floatValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"d"]) { // double
            double objVaule = [obj doubleValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"c"]) { // char
            char objVaule = [obj charValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"i"]) { // int
            int objVaule = [obj intValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"I"]) { // unsigned int
            unsigned int objVaule = [obj unsignedIntValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"S"]) { // unsigned short
            unsigned short objVaule = [obj unsignedShortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"L"]) { // unsigned long
            unsigned long objVaule = [obj unsignedLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"s"]) { // shrot
            short objVaule = [obj shortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"l"]) { // long
            long objVaule = [obj longValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"q"]) { // long long
            long long objVaule = [obj longLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"C"]) { // unsigned char
            unsigned char objVaule = [obj unsignedCharValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"Q"]) { // unsigned long long
            unsigned long long objVaule = [obj unsignedLongLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"{CGRect={CGPoint=dd}{CGSize=dd}}"]) { // CGRect
            CGRect objVaule = [obj CGRectValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"{UIEdgeInsets=dddd}"]) { // UIEdgeInsets
            UIEdgeInsets objVaule = [obj UIEdgeInsetsValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
    }
    // 调用方法
    [invocation invoke];
    id result ;
    //获取返回值
    if ([returnTypeString isEqualToString:@"@"]) { // id
        void * returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= (__bridge id)returnValue;
            returnValue = nil;
            
        }else{
            result= nil;
            
        }
    }  else if ([returnTypeString isEqualToString:@"B"]) { // bool
        bool returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithBool:returnValue];
        }else{
            result= nil;
        }
    } else if ([returnTypeString isEqualToString:@"f"]) { // float
        float returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithFloat:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"d"]) { // double
        double returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithDouble:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"c"]) { // char
        char returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithChar:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"i"]) { // int
        int returnValue; if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithInt:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"I"]) { // unsigned int
        unsigned int returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithUnsignedInteger:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"S"]) { // unsigned short
        unsigned short returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithUnsignedShort:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"L"]) { // unsigned long
        unsigned long returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithUnsignedLong:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"s"]) { // shrot
        short returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithShort:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"l"]) { // long
        long returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithLong:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"q"]) { // long long
        long long returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithLongLong:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"C"]) { // unsigned char
        unsigned char returnValue;
        if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithUnsignedChar:returnValue];
            
        }else{
            result= nil;
            
        }
    } else if ([returnTypeString isEqualToString:@"Q"]) { // unsigned long long
        unsigned long long returnValue;if (signature.methodReturnLength){
            [invocation getReturnValue:&returnValue];
            result= [NSNumber numberWithUnsignedLongLong:returnValue];
            
        }else{result= nil;}
    }else if([returnTypeString isEqualToString:@"v"]){
        result= nil;
    }else{
        //        PA_THROW_EXCEPTION(@"不能识别的返回类型");
        result= nil;
    }
    signature = nil;
    invocation = nil;
    return result;
    //    else if ([returnTypeString isEqualToString:@"{CGRect={CGPoint=dd}{CGSize=dd}}"]) { // CGRect
    //        CGRect returnValue;[invocation getReturnValue:&returnValue]; return [NSValue valueWithCGRect:returnValue];
    //    } else if ([returnTypeString isEqualToString:@"{UIEdgeInsets=dddd}"]) { // UIEdgeInsets
    //        UIEdgeInsets returnValue;[invocation getReturnValue:&returnValue]; return [NSValue valueWithUIEdgeInsets:returnValue];
    //    }
    //    @"{CGPoint=dd}" @"{CGSize=dd}" @"{UIOffset=dd}"
    
}



@end
