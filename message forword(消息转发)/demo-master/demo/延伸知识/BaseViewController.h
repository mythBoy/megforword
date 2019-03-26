//
//  BaseViewController.h
//  demo
//
//  Created by Show on 2019/3/18.
//  Copyright © 2019 梁明哲. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef struct ParameterStruct{
    int a;
    int b;
}MyStruct;
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
- (void)learnInvocation;//学习NSIvocation
@end

NS_ASSUME_NONNULL_END
