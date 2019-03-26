//
//  BaseViewController.m
//  demo
//
//  Created by Show on 2019/3/18.
//  Copyright © 2019 梁明哲. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//学习 NSIvocation
- (void)learnInvocation
{
    //    NSInvocation 使用
    //
    //    一 包装对象 (需要签名)
    //    二 设置调用者 ps:1设置方法名 2设置参数 (切记index 从2开始 预留1 self 2 selector)
    //    三 调用
    //    四 设置变量保存返回值
    
    NSMethodSignature *singature = [NSMethodSignature signatureWithObjCTypes:"@@:@"];
    //    NSInteger argumentNum = singature.numberOfArguments;//打印参数个数
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singature];
    //设置方法 设置响应者
    invocation.selector = @selector(invocationImp:);
    invocation.target = self;
    
    //设置参数
    NSString *str = @"124";
    [invocation setArgument:&str atIndex:2];
    //设置返回
    id returnValue = nil;
    [invocation getReturnValue:&returnValue];
    
    [invocation invoke];// invoke 引用
//    self.superclass
}
- (instancetype)invocationImp:(NSString *)str
{
    NSLog(@"----%@",str);
    return [[[self class] alloc] init];
    
}
//NSIvocation 参考资料 https://www.jianshu.com/p/672c0d4f435a

@end
