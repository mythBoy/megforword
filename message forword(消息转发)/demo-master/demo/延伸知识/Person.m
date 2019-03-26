//
//  Person.m
//  demo
//
//  Created by Show on 2019/3/19.
//  Copyright © 2019 梁明哲. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person()

@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSUInteger age;

- (void)showMyself;

@end

@implementation Person

@synthesize name = _name;
@synthesize age = _age;

- (void)showMyself {
    NSLog(@"My name is %@ I am %ld years old.", self.name, self.age);
}

@end

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        //为了方便查看转写后的C语言代码，将alloc和init分两步完成
//        Person *p = [Person alloc];
//        p = [p init];
//        p.name = @"Jiaming Chen";
//        [p showMyself];
//        
//
//    }
//    return 0;
//}
//
///*===== c++ 代码*/
//
//
//static NSString * _I_Person_name(Person * self, SEL _cmd) { return (*(NSString **)((char *)self + OBJC_IVAR_$_Person$_name)); }
//extern "C" __declspec(dllimport) void objc_setProperty (id, SEL, long, id, bool, bool);
//
//static void _I_Person_setName_(Person * self, SEL _cmd, NSString *name) { objc_setProperty (self, _cmd, __OFFSETOFIVAR__(struct Person, _name), (id)name, 0, 1); }
//
//// @synthesize age = _age;
//static NSUInteger _I_Person_age(Person * self, SEL _cmd) { return (*(NSUInteger *)((char *)self + OBJC_IVAR_$_Person$_age)); }
//static void _I_Person_setAge_(Person * self, SEL _cmd, NSUInteger age) { (*(NSUInteger *)((char *)self + OBJC_IVAR_$_Person$_age)) = age; }
//
//static void _I_Person_showMyself(Person * self, SEL _cmd) {
//    NSLog((NSString *)&__NSConstantStringImpl__var_folders_1f_dz4kq57d4b19s4tfmds1mysh0000gn_T_main_f5b408_mi_0, ((NSString *(*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("name")), ((NSUInteger (*)(id, SEL))(void *)objc_msgSend)((id)self, sel_registerName("age")));
//}
//
//// @end
//
//int main(int argc, const char * argv[]) {
//    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
//        
//       
//        Person *p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("alloc")); /*Person *p = [Person alloc];*/
//        p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("init"));
//        ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)p, sel_registerName("setName:"), (NSString *)&__NSConstantStringImpl__var_folders_1f_dz4kq57d4b19s4tfmds1mysh0000gn_T_main_f5b408_mi_1);
//        ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("showMyself"));
//        
//    }
//    return 0;
//    
//}


//代码分析
//
///*
// objc_msgSend(void /* id self, SEL op, ... */ 
//
// //Person *p = [Person alloc];
//    1 获取person类 2注册消息名称alloc
//
// // p = [p init];
//   1 获取person类 2 注册消息名称init
// */
//
//
//
//
// https://blog.csdn.net/qq_27909209/article/details/74560358 文件参考
