//
//  AppDelegate.m
//  MusicPlayer-B
//
//  Created by lanou on 15/7/8.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicDetailViewController.h"
//#import "HBMainViewController.h"
#import "IQKeyboardManager.h"
#import "HBMainController.h"
#import "TuSDKFramework.h"
//#import "ZYOpenURLTool.h"
#import "UMessage.h"
//#import "ZYUMessageTool.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"

#import "HWHTTPSessionManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "AmapSlampLocationTool.h"

@interface AppDelegate ()
{
    UIBackgroundTaskIdentifier bgTaskId;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadBaseData];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    // 可选: 设置日志输出级别 (默认不输出)
    [TuSDK setLogLevel:lsqLogLevelDEBUG];
    // 初始化SDK (请前往 http://tusdk.com 申请秘钥)
    [TuSDK initSdkWithAppKey:@"76d11e44b5ab72d5-01-xnvzn1"];
    // 需要指定开发模式 需要与lsq_tusdk_configs.json中masters.key匹配， 如果找不到devType将默认读取master字段
    // [TuSDK initSdkWithAppKey:@"828d700d182dd469-04-ewdjn1" devType:@"debug"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HBMainController *mainVc = [[HBMainController alloc] init];
    self.window.rootViewController = mainVc;
    [self.window makeKeyAndVisible];
    
    [NSThread sleepForTimeInterval:3.5];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self initializePlat:application launchOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

    UIDevice* device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)])
    {
        if(device.multitaskingSupported)
        {
            if (bgTaskId == UIBackgroundTaskInvalid)
            {
                bgTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
            }
        }
    }

    
    
}

//-(BOOL)application:(UIApplication *)app
//           openURL:(NSURL *)url
//           options:(NSDictionary<NSString *,id> *)options
//{
//    [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//    return [ZYOpenURLTool openURL:url];
//}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
    
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [application beginBackgroundTaskWithExpirationHandler:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//
//    if (bgTaskId != UIBackgroundTaskInvalid)
//    {
//        [[UIApplication sharedApplication] endBackgroundTask:bgTaskId];
//        bgTaskId = UIBackgroundTaskInvalid;
//    }
//
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark  基础数据
- (void)loadBaseData
{
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = KSDKlbsKey;
    [ZYUserDefaults setObject:@(1) forKey:KZYLocation];
    [AmapSlampLocationTool getLocationCoordinate:^(NSDictionary *locDict, BOOL isNew) {
    } error:^(NSError *error) {
        
    }];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[HWHTTPSessionManager shareedHTTPSessionManager] netStatusChange:^(kNetState status) {
        [ZYUserDefaults setInteger:status forKey:kZYNetState];
    }];
}

#pragma mark   配置数据
- (void)initializePlat:(UIApplication *)application
         launchOptions:(NSDictionary *)launchOptions
{
    //消息注册
//    [ZYRemoteNotificationsTool registerForRemoteNotifications:application];
//    //获取基本配置
//    [ZYConfigTool getBaseData];
//    //微信
//    [WXApi registerApp:kSDKWeiXinAppKey withDescription:kSDKWeiXinBundleID];
//    //统计
//    UMConfigInstance.appKey = kUMAnalyticsAppKey;
//    [MobClick setAppVersion:XcodeAppVersion];
//    [MobClick startWithConfigure:UMConfigInstance];
    //消息推送
    [UMessage registerForRemoteNotifications];
    //    [UMessage setLogEnabled:YES];
    [UMessage startWithAppkey:kUMAnalyticsAppKey launchOptions:launchOptions];
    //环信登录
    //    [ZYIMTool loginAccount:nil];
    
    [UMSocialData setAppKey:kUMAnalyticsAppKey];
    
    [UMSocialQQHandler setQQWithAppId: kSDKQQAppID
                               appKey: kSDKQQAppKey
                                  url:@"http://www.umeng.com/social"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kSDKSinaAppKey
                                              secret:kSDKSinaSecret
                                         RedirectURL:KZIYUN];
    
    [UMSocialWechatHandler setWXAppId:kSDKWeiXinAppKey
                            appSecret:kSDKWeiXinAppSecret
                                  url:nil];
    
}
@end
