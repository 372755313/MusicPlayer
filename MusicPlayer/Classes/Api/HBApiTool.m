//
//  HBApiTool.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/16.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBApiTool.h"
#import <AFNetworking.h>
#import "HBApiTool+music.h"

@implementation HBApiTool

#pragma mark 线下体验店
+ (void)ZYgetOfflineExperienceStore:(NSString *)latitude
                          longitude:(NSString *)longitude
                            Success:(void(^)(NSArray *array))success
                            failure:(void (^)(NSString *error))fail
{
    NSDictionary *parmes ;
    if (latitude.length != 0 && ![latitude isEqualToString:@"(null)"]) {
        parmes = @{@"latitude":latitude,
                   @"longitude":longitude};
    }
    [HBApiTool ZYPost:@"basic/case/getOfflineExperienceStore"
              parameters:parmes
           netIdentifier:@"getOfflineExperienceStore"
                progress:nil
                 success:^(ZYJsonData *data) {
                     success(data.data);
                 } failure:^(NSString *msg) {
                     fail(msg);
                 }];
}

#pragma mark post 方法
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(NSDictionary *))success
     failure:(void (^)(NSError *))failure;
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10se
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送POST请求
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark get 方法
#pragma mark get 方法
+  (void)get:(NSInteger )urlNum
     success:(void (^)(NSDictionary *))success
     failure:(void (^)(NSError *))failure;
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送GET请求
    [mgr GET:[self ZYPostUrl:urlNum]
  parameters:nil
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];

        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)picBrowseGet:(NSInteger )urlNum
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送GET请求
    [mgr GET:[self ZYPicBrowsePostUrl:urlNum]
  parameters:nil
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

#pragma mark get 其他的个体方法
+  (void)hbGet:(NSString *)string
       success:(void (^)(NSDictionary *))success
       failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送GET请求
    [mgr GET:[self HBSearchPostUrl:string]
  parameters:nil
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+  (void)hbMusicGet:(NSString *)string
            success:(void (^)(NSDictionary *))success
            failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送GET请求
    [mgr GET:[self HBMusicPostUrl:string]
  parameters:nil
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark- get播放音乐图片显示
+ (void)hbMusicPicGet:(NSString *)string
              success:(void (^)(NSDictionary *))success
              failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.申明返回的结果是text/html类型
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 3.设置超时时间为10s
    mgr.requestSerializer.timeoutInterval = 10;
    // 4.发送GET请求
    [mgr GET:[self HBMusicPicPostUrl:string]
  parameters:nil
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if (success) {
            success(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}



+ (NSString *)ZYPostUrl:(NSInteger )num
{
    return [NSString stringWithFormat:@"%@p%ld.html",@"http://dili.bdatu.com/jiekou/main/",num];
}

+ (NSString *)ZYPicBrowsePostUrl:(NSInteger )num
{
    return [NSString stringWithFormat:@"%@%ld.html",PICIDAPIURL,num];
}

+ (NSString *)HBSearchPostUrl:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:@"%@%@",MUSICAPIURL,string];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//汉子转换字母的方法
    
}

+ (NSString *)HBMusicPostUrl:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:@"%@%@",MUSICLISTURL,string];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//汉子转换字母的方法
}

+ (NSString *)HBMusicPicPostUrl:(NSString *)string
{
    NSString *str = [NSString stringWithFormat:@"%@%@",MUSICPICURL,string];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//汉子转换字母的方法
}




@end
