//
//  KtUserTool.m
//  kuanterAuto
//
//  Created by skywakerwei on 15/6/15.
//  Copyright (c) 2015年 kuanter. All rights reserved.
//

#import "ZYUserTool.h"
#import "ZYUser.h"
#import "HWTool.h"
//#import "ZYDBTool.h"

#define kUserDataPath           [kDirDoc stringByAppendingPathComponent:@"userdata.archiver"]

@implementation ZYUserTool

//登录
+ (void)logIn:(ZYUser *)userInfo
{
   
    [NSKeyedArchiver archiveRootObject:userInfo toFile:kUserDataPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserDataLogIn object:userInfo userInfo:@{@"info":userInfo}];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCartNumChange object:nil userInfo:nil];
    
    
}

//注销登录
+ (void)logOut
{
    ZYUser *userInfo = [ZYUser sharedZYUser];
    if (userInfo.isLogin) {
        userInfo.isLogin = NO;
        userInfo.token = nil;
        userInfo = nil;
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:kUserDataPath error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserDataLogOut object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kCartNumChange object:nil userInfo:nil];
        }
    }
   

//修改数据
+ (void)saveData:(ZYUser *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:kUserDataPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserDataChange object:userInfo userInfo:@{@"info":userInfo}];
    
}

//不发送通知的修改
+ (void)changeData:(ZYUser *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:kUserDataPath];
}


//读取数据
+ (ZYUser *)loadInfo
{
    ZYUser *userInfo = [ZYUser sharedZYUser];
    if(userInfo.isLogin){
        return userInfo;
    }else{
        return (ZYUser *)[NSKeyedUnarchiver unarchiveObjectWithFile:kUserDataPath];
    }
    
}


//用户登录
+ (ZYUser *)loadUserData:(NSDictionary *)userData
{
    
    ZYUser *userInfo        = [[ZYUser alloc]init];
    userInfo.token          = [userData hw_safeObjectForKey:@"token"];
    userInfo.ticket         = [userData hw_safeObjectForKey:@"ticket"];
    userInfo.isLogin        = YES;
    userInfo.disCount       = 1.0; //默认
    userInfo.userAccount    = [NSString stringWithFormat:@"%@",[userData hw_safeObjectForKey:@"userAccount"]];
    userInfo.userId         = [NSString stringWithFormat:@"%@",[userData hw_safeObjectForKey:@"memberId"]];
    userInfo.userName       = [userData hw_safeObjectForKey:@"name"];
    userInfo.userType       = [[userData hw_safeObjectForKey:@"userType"] integerValue];
    
    userInfo.userMobile = @"";
    if ([userData hw_safeObjectForKey:@"mobile"]) {
        userInfo.userMobile     = [NSString stringWithFormat:@"%@",[userData hw_safeObjectForKey:@"mobile"]];
    }
    
    userInfo.address = @"";
    userInfo.zipCode = @"";
    if ([userData hw_safeObjectForKey:@"addr"]) {
        userInfo.address        = [NSString stringWithFormat:@"%@",[userData hw_safeObjectForKey:@"addr"]];
     }
    if ([userData hw_safeObjectForKey:@"zip"]) {
        userInfo.zipCode        = [NSString stringWithFormat:@"%@",[userData hw_safeObjectForKey:@"zip"]];
    }
    userInfo.memberLv       = [userData hw_safeObjectForKey:@"memberLv"];
    
    switch (userInfo.userType) {
        case 0:
        {
            userInfo.userTypeStr = @"一般用户";
        }
            break;
        case 1:
        {
            userInfo.userTypeStr = @"图文店用户";
        }
            break;
        case 2:
        {
            userInfo.userTypeStr = @"企业用户";
        }
            break;
        case 3:
        {
            userInfo.userTypeStr = @"设计师";
        }
            break;
        case 4:
        {
            userInfo.userTypeStr = @"供应商";
        }
            break;
            
        default:
        {
            userInfo.userTypeStr = @"一般用户";
        }
            break;
    }
    
  
    return userInfo;
    
    
}



@end
