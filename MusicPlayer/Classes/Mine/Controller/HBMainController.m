//
//  HBMainController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/22.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBMainController.h"
#import "HBMainViewController.h"
#import "HBSearchMusicController.h"
#import "JTNavigationController.h"
#import "DemoRootViewController.h"
#import "HBViewController.h"
#import "HBFilterController.h"


@interface HBMainController ()<UITabBarControllerDelegate>

@end

@implementation HBMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.delegate = self;
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    [self getUnreadCount];
    //登录通知
    __weak __typeof(&*self)weakSelf = self;
//    [self hw_registerNotification:[kCartNumChange UTF8String] block:^(NSNotification *notification) {
//        [weakSelf getUnreadCount];
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUnreadCount
{
    
//    self.cartVc.tabBarItem.badgeValue = nil;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    
//    if (self.userInfo.isLogin) {
//        if (self.userInfo.shpingCarNumber>0) {
//            self.cartVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",@(self.userInfo.shpingCarNumber)];
//            [UIApplication sharedApplication].applicationIconBadgeNumber = self.userInfo.shpingCarNumber;
//        }
//    }
    
    
}


/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    HBMainViewController *homeVc = [[HBMainViewController alloc] init];
    [self setupChildViewController:homeVc title:@"图文" imageName:@"tabBar_home" selectedImageName:@"tabBar_home_selected"];
    
//    HBSearchMusicController *searchVc = [[HBSearchMusicController alloc] init];
    HBViewController *hbVc = [[HBViewController alloc] init];
    [self setupChildViewController:hbVc title:@"胡贝贝" imageName:@"tabBar_design" selectedImageName:@"tabBar_design_selected"];
    
//    DemoRootViewController *demoRootVc = [[DemoRootViewController alloc] init];
//    [self setupChildViewController:demoRootVc title:@"图片美颜" imageName:@"tabBar_mine" selectedImageName:@"tabBar_mine_selected"];
    
    HBFilterController *filterVc = [[HBFilterController alloc] init];
    [self setupChildViewController:filterVc title:@"图片美颜" imageName:@"tabBar_mine" selectedImageName:@"tabBar_mine_selected"];
    
//    ZYHomeController *homeVC = [[ZYHomeController alloc] init];
//    [self setupChildViewController:homeVC title:@"首页" imageName:@"tabBar_home" selectedImageName:@"tabBar_home_selected"];
//    
//    
//    ZYCaseViewController *designVC = [[ZYCaseViewController alloc] init];
//    [self setupChildViewController:designVC title:@"案例" imageName:@"tabBar_design" selectedImageName:@"tabBar_design_selected"];
//    
//    ZYCartViewController *cartVC = [[ZYCartViewController alloc] init];
//    _cartVc = cartVC;
//    [self setupChildViewController:cartVC title:@"购物车" imageName:@"tabBar_cart" selectedImageName:@"tabBar_cart_selected"];
//    
//    
//    ZYMineViewController *mineVC = [[ZYMineViewController alloc] init];
//    [self setupChildViewController:mineVC title:@"我" imageName:@"tabBar_mine" selectedImageName:@"tabBar_mine_selected"];
    
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(83, 83, 83);
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = HWColor(233, 112, 81);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 2.包装一个导航控制器
    //    ZYNavigationController *nav = [[ZYNavigationController alloc] initWithRootViewController:childVc];
    //    [self addChildViewController:nav];
    
    JTNavigationController *nav = [[JTNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    
}

- (void)dealloc
{
//    [self hw_unregisterAllNotification];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.tabBar setFrame:self.tabBar.bounds];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}





@end
