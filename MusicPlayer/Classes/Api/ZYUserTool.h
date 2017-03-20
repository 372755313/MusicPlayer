//
//  KtUserTool.h
//  kuanterAuto
//
//  Created by skywakerwei on 15/6/15.
//  Copyright (c) 2015年 kuanter. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYUser;

@interface ZYUserTool : NSObject


//读取
+ (ZYUser *)loadInfo;
//登陆 退出
+ (void)logIn:(ZYUser *)userInfo;
+ (void)logOut;
//修改
+ (void)saveData:(ZYUser *)userInfo;
//不发送通知的修改
+ (void)changeData:(ZYUser *)userInfo;

//用户登录
+ (ZYUser *)loadUserData:(NSDictionary *)userData;




@end
