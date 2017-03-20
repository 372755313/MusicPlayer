//
//  HWTool.h
//  tg
//  tool帮助
//  Created by skywakerwei on 14/11/25.
//  Copyright (c) 2014年 skywakerwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCommon : NSObject

//取目录内容大小
+ (float)dirTotalSize:(NSString *)DirPath;
+ (void)clearCache;
+ (void)removeDir:(NSString *)DirPath;
//创建文件夹
+ (BOOL)createDir:(NSString *)dirName;
+ (BOOL)createDocDir:(NSString *)dirName;
//图片下载到本地目录内
+ (BOOL)downLoadWebImage:(NSString *)imgUrl toDir:(NSString *)path fileName:(NSString *)fileName;
+ (void)downLoadWebImage:(NSString *)imgUrl toDir:(NSString *)path fileName:(NSString *)fileName completion:(void (^)(void))completion;
//删除
+ (void)removePlist:(NSString *)plistPath;
+ (NSString *)formartNum:(NSNumber *)num;

//字典转url
+ (NSString *)NSDictionaryToUrlData:(NSDictionary *)dic;

//转json
+ (NSString *)TurnToJsonData:(id)data;


//格式化json传过来的数据
+ (id)retrunJsonData:(id)jsonData replace:(id)result;

//电话中间四位加星
+ (NSString *)getPhone:(NSString *)phoneNum;

//时间戳
+ (NSString *)getTimeStamp;
+ (NSInteger)getTimeStampInt;
//时间戳转换时间字符串
+ (NSString *)getTimeStr:(NSNumber *)timeStamp;

+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString;
//提示
+ (void)showTopMsg:(NSString *)msg withVC:(UIViewController *)vc;

#pragma mark 获取系统版本
+ (NSString *)getCurrentShortVersion;
+ (NSString *)getCurrentVersion;
+ (BOOL)isValidateEmail:(NSString *)email;

//utf－8 转 unicode
+(NSString *)utf8ToUnicode:(NSString *)string;

#pragma mark 检查手机号码的有效性
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (void)openApplicationSettings;

+ (NSString *)sortedDic:(NSDictionary *)dict;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
