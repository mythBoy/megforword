//
//  ViewController.m
//  demo
//
//  Created by 梁明哲 on 2018/6/10.
//  Copyright © 2018年 梁明哲. All rights reserved.
//


/*
 消息转发:messageForword  https://blog.csdn.net/qq_27909209/article/details/74560358
 消息机制: objc_msgSend()
 */

#import "ViewController.h"
#import "Animal.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    [[Animal new] eat];// 消息转发演练
//    [self learnInvocation]; //NSInvocation学习
    
    id test = [[[self class] alloc] init];
    [test substringFromIndex:0];

    
}
/*
 1 为什么要签名???
 */

- (void)test:(NSNumber *)num1 num:(NSNumber *)num2
{
    NSLog(@"----test");
}
@end


