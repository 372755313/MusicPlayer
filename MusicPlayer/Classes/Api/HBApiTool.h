//
//  HBApiTool.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/16.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBApiTool : NSObject

#pragma mark post 方法
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(NSDictionary *))success
     failure:(void (^)(NSError *))failure;


#pragma mark get 方法
+ (void)get:(NSInteger )urlNum
      success:(void (^)(NSDictionary *))success
       failure:(void (^)(NSError *))failure;

+ (void)picBrowseGet:(NSInteger )urlNum
    success:(void (^)(NSDictionary *))success
    failure:(void (^)(NSError *))failure;

#pragma mark get 其他的个体方法
+ (void)hbGet:(NSString *)string
     success:(void (^)(NSDictionary *))success
     failure:(void (^)(NSError *))failure;

+ (void)hbMusicGet:(NSString *)string
       success:(void (^)(NSDictionary *))success
       failure:(void (^)(NSError *))failure;

#pragma mark- get播放音乐图片显示
+ (void)hbMusicPicGet:(NSString *)string
              success:(void (^)(NSDictionary *))success
              failure:(void (^)(NSError *))failure;

#pragma mark 线下体验店
+ (void)ZYgetOfflineExperienceStore:(NSString *)latitude
                          longitude:(NSString *)longitude
                            Success:(void(^)(NSArray *array))success
                            failure:(void (^)(NSString *error))fail;


@end
