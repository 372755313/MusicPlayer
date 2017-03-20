//
//  ZYBaseViewController.m
//  ziyun
//
//  Created by ziyun on 16/3/26.
//  Copyright © 2016年 zy. All rights reserved.
//

#import "ZYBaseViewController.h"
//#import "zy.pch"

@interface ZYBaseViewController ()

@end

@implementation ZYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:HWColor(242, 242, 242)];

//    __weak __typeof(&*self)weakSelf = self;
//    [self hw_registerNotification:[kUserDataLogOut UTF8String] block:^(NSNotification *notification) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//        });
//    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [MobClick beginLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];

}


- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeBottom|UIRectEdgeLeft|UIRectEdgeRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
