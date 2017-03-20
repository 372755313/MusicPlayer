//
//  HBFilterController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/12/19.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBFilterController.h"
#import "DemoRootViewController.h"

@interface HBFilterController ()

@end

@implementation HBFilterController

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithString:@"滤镜" target:self action:@selector(btnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;

}

- (void)btnAction
{
    DemoRootViewController *rootVc = [[DemoRootViewController alloc] init];
    [self.navigationController pushViewController:rootVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
