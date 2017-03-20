//
//  HBApiTool+music.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/16.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBApiTool.h"
#import "ZYJsonData.h"

@interface HBApiTool (music)

+ (void)HBGetPiListWithNum:(NSInteger )num
                   success:(void(^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure;

+ (void)HBGetPicBrowserWithNum:(NSInteger )num
                   success:(void(^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure;

+ (void)HBGetMusicSearchListWithText:(NSString *)string
                             success:(void(^)(NSDictionary *))success
                             failure:(void (^)(NSError *))failure;

+ (void)HBGetDidMusicListWithText:(NSString *)string
                          success:(void (^)(NSDictionary *))success
                          failure:(void (^)(NSError *))failure;

+ (void)HBGetMusicPicWithText:(NSString *)string
                          success:(void (^)(NSDictionary *))success
                          failure:(void (^)(NSError *))failure;

+ (void)ZYPost:(NSString *)urlString
    parameters:(NSDictionary *)parameters
 netIdentifier:(NSString *)netIdentifier
      progress:(void (^)(NSProgress *progress))progressBlock
       success:(void (^)(ZYJsonData *data))successBlock
       failure:(void (^)(NSString *msg))failureBlock;

#pragma mark 服务器返回错误处理
+ (NSString *)operateFail:(NSInteger)status
                      msg:(NSString *)msg
                       do:(void (^)())done;

@end
