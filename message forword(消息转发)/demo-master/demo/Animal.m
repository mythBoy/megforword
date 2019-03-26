//
//  Animal.m
//  demo
//
//  Created by 梁明哲 on 2018/6/10.
//  Copyright © 2018年 梁明哲. All rights reserved.
//

#import "Animal.h"

#import <objc/message.h>
#import "AnimalForwardingTarget.h"
#import "AnimalForwardInvocation.h"
@implementation Animal

/*再头文件中声明了eat 函数，但是没有实现这个方法，所以有一条警告⚠️:Method definition for 'eat' not found */


/**在发生崩溃之前,会做三步处理**/
/**/

/*动态方法解析*/
/*在本类 Class Animal中寻找可以处理“eat”的方法*/

/*
 * function: resolveInstanceMethod
 * NSObject.h中声明的类方法 提供给用户向该类的动态添加selector(函数方法)的机会
 *  备注: 当调用方法没有找到实现 会调用这个方法  仅限实例方法
 *  扩展:如果 使用@dynamic 取消编译器自动生成getter/setter方法则需要在这里添加对应方法
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel{   //resolve 解析
    NSLog(@"sel = %@",NSStringFromSelector(sel));
    if (sel == @selector(eat)) {
            class_addMethod(self, sel, (IMP)eatMeat, "v@:@");
            return YES;
        }
    return [super resolveInstanceMethod:sel];
}

/*
 *function: eatMeat
 *通过resolveInstanceMethod 的IMP指向函数，
 */
void eatMeat(id self,SEL sel) {
    NSLog(@"---方法一:动态方法解析 eat meat---");
}

//如果动态方法解析无法处理(比如把上面的 resolveInstanceMethod 函数注释掉)则系统会把进入备援接收者处理该消息
/*
 *function: forwardingTargetForSelector
 *如果resolveInstanceMethod 中并没有处理 eat事件的动态方法，系统将会在进入本函数尝试在其他类中寻找实现选择子为"eat"的方法
 *本例Class Action将作为“备援接收者”处理 eat事件
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *selectorStr = NSStringFromSelector(aSelector);//获取消息的选择子
    if ([selectorStr isEqualToString:@"eat"]) {
        AnimalForwardingTarget *action = [AnimalForwardingTarget new];
        return action;
    }
    return [super forwardingTargetForSelector:aSelector];

}

/*如果没有备援接收者处理该消息时，便会进入消息重定向*/
/*调用此方法如果不能处理就会调用父类的方法，一直到NSObject，如果NSObject也无法处理，则会调用doesNotRecognizeSelector抛出异常*/
/*
 消息重定向 第一步:方法签名 参数sel
 获取
 */
- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
    NSString *selectedStr = NSStringFromSelector(aSelector); //获取消息的选择子
    if ([selectedStr isEqualToString:@"eat"]) {
        NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return sign;
    }
    NSMethodSignature *sign = [super methodSignatureForSelector:aSelector];
    return sign;
}
//修改选择子为“eatDogFood” ，此为AnimalForwardInvocation 中的方法 实现
    //转发 调用
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    anInvocation.selector = NSSelectorFromString(@"eatDogFood");//新方法
    // 1 设置 
    AnimalForwardInvocation* animal = [[AnimalForwardInvocation alloc] init];//新对象
    
    // 2 如果新对象
    if ([animal respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:animal];
    } else {
        [super forwardInvocation:anInvocation];
    }
}
/*  ================>>>  牛逼闪闪三大阶段 分析总结  <<<================  */

/*
 一 : 动态方法解析
 + (BOOL)resolveInstanceMethod:(SEL)sel  传来SEL对象
 1 class_addMethod(self, sel, (IMP)eatMeat, "v@:@"); 动态添加方法(注意这里也需要签名) 1谁调用 2调用什么方法 3imp指针找到实现 4实现方法类型
 2 实现 eatMeat 方法
 
 ps: + (BOOL)resolveClassMethod:(SEL)sel OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0, 2.0);
     如果调用的是类方法,回调用这个方法动态解析, 对象方法则会调用resolveInstanceMethod方法
 
 class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp, const char * _Nullable types)
 const char * _Nullable types:会用两个预留参数 0:self 1:selector
 "v@:@" VS void eatMeat(id self,SEL sel)  ??妈的少一个啊  v@:@: 这个比较科学啊
 
 
*/


/*
 二 :消息重定义
 - (id)forwardingTargetForSelector:(SEL)aSelector
    注意返回的id ,返回备源接受者 创建一个对象给他返回,让他去这个对象里面找 传过来的SEL方法
 
    ps: 需要在这个对象里面 先声明及其实现 ,这里eat的方法声明及实现
 */

/*
 三 : 完整消息转发 总结
  本质是通过NSIvocation 进行消息发送 两个方法,一个传入sel对象返回签名,第二个生成NSInvocation对象 发送消息
 
 1  - (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
     传来selector对象 给其方法签名
 2  - (void)forwardInvocation:(NSInvocation *)anInvocation
      将签名的方法封装为NSIvocation对象传过来, 设置invocation对象新的执行方法 绑定执行者及调用
 */

/* 引申 */
/*
 ios 三种调用方法
  1 直接调用== obj_msgsend
  2 perform
  3 NSIvocation调用
 */

@end



