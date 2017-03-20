//
//  HBApiTool+music.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/16.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBApiTool+music.h"
#import "ZYTool.h"
#import "HWCommon.h"
#import "HWHTTPSessionManager.h"
#import "ZYUserTool.h"
#import "ZYUser.h"

NSString * const netFailMsg     = @"系统异常，请重新再试";

@implementation HBApiTool (music)

#pragma mark post 方法
//+ (void)ZYPost:(NSString *)urlString
//    parameters:(NSDictionary *)parameters
// netIdentifier:(NSString *)netIdentifier
//      progress:(void (^)(NSProgress *))progressBlock
//       success:(void (^)(ZYJsonData *data))successBlock
//       failure:(void (^)(NSString *))failureBlock
//{
//    
//    
//    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
//    if (parameters != nil) {
//        postDic[@"sign"]        = [ZYTool sign:parameters];
//        postDic[@"data"]        = [HWCommon TurnToJsonData:parameters];
//    }
//    
//    if(kISHTTPLog){
//        DLog(@"urlString = %@ postDic =  %@",urlString,postDic);
//    }
//    
//    HWHTTPSessionManager *httpHelp = [HWHTTPSessionManager shareedHTTPSessionManager];
//    httpHelp.mager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
//    httpHelp.mager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [httpHelp.mager.requestSerializer setValue:[HWCommon getTimeStamp]  forHTTPHeaderField:@"timestamp"];
//    [httpHelp.mager.requestSerializer setValue:[HWCommon getCurrentShortVersion] forHTTPHeaderField:@"appVersion"];
//    [httpHelp.mager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"appType"];
//    [httpHelp.mager.requestSerializer setValue:[ZYTool getSystemUUID] forHTTPHeaderField:@"deviceid"];
////    [httpHelp.mager.requestSerializer setValue:[ZYTool getClientIP] forHTTPHeaderField:@"ip"];
//    if (YES) {
//        [httpHelp.mager.requestSerializer setValue:[ZYUserTool loadInfo].token  forHTTPHeaderField:@"token"];
//    }
//    
//    [httpHelp post:[self ZYYPostUrl:urlString]
//        parameters:postDic
//     netIdentifier:netIdentifier
//          progress:^(NSProgress *downloadProgress) {
//              
//              dispatch_async(dispatch_get_main_queue(), ^{
//                  if (progressBlock) {
//                      progressBlock(downloadProgress);
//                  }
//              });
//              
//          } success:^(id responseObject) {
//              NSString *responseStr =  [[ NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//              NSError *error;
//              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
//              
//              if(kISHTTPLog){
//                  DLog(@"parameters = %@  responseObject =  %@",postDic,json);
//              }
//              ZYJsonData *data = [ZYJsonData loadDataWithJson: json];
//              if (data.returnCode == 1) {
//                  
//                  if (successBlock) {
//                      successBlock(data);
//                  }
//                  
//              }else{
//                  
//                  if (failureBlock) {
//                      failureBlock([self operateFail:data.returnCode msg:data.rmk do:^{
//                          [HBApiTool ZYPost:urlString parameters:parameters netIdentifier:netIdentifier progress:progressBlock success:successBlock failure:failureBlock];
//                      }]);
//                  }
//              }
//              
//              
//          } failure:^(NSError *error) {
//              if (failureBlock) {
//                  failureBlock([HBApiTool operateFail:-1 msg:nil do:^{}]);
//              }
//          }];
//    
//    
//}

//首页图片列表
+ (void)HBGetPiListWithNum:(NSInteger )num
                   success:(void(^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure
{
    [HBApiTool get:num
           success:^(NSDictionary *dic) {
               if (success) {
                   success(dic);
               }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)HBGetPicBrowserWithNum:(NSInteger )num
                       success:(void(^)(NSDictionary *))success
                       failure:(void (^)(NSError *))failure
{
    [HBApiTool picBrowseGet:num success:^(NSDictionary *dic) {
        if (success) {
            success(dic);
        }

    } failure:^(NSError *error) {
        failure(error);
    }];
}

//音乐搜索
+ (void)HBGetMusicSearchListWithText:(NSString *)string
                             success:(void(^)(NSDictionary *))success
                             failure:(void (^)(NSError *))failure
{
    [HBApiTool hbGet:string
             success:^(NSDictionary *dic) {
                 
                 if (success) {
                     success(dic);
                 }
    } failure:^(NSError *error) {
        failure(error);
    }];

}

+ (void)HBGetDidMusicListWithText:(NSString *)string
                          success:(void (^)(NSDictionary *))success
                          failure:(void (^)(NSError *))failure
{
    [HBApiTool hbMusicGet:string
                  success:^(NSDictionary *dict) {
                      if (success) {
                          success(dict);
                      }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)HBGetMusicPicWithText:(NSString *)string
                      success:(void (^)(NSDictionary *))success
                      failure:(void (^)(NSError *))failure
{
    [HBApiTool hbMusicPicGet:string
                     success:^(NSDictionary *dict) {
                         if (success) {
                             success(dict);
                         }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSString *)ZYYPostUrl:(NSString *)urlString
{
    return [NSString stringWithFormat:@"%@/app/%@",KZYAPIUrl,urlString];
}


#pragma mark 服务器返回错误处理
+ (NSString *)operateFail:(NSInteger)status
                      msg:(NSString *)msg
                       do:(void (^)())done
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"networkError" object:nil];
    
    switch (status) {
        case -1://网络错误
        {
            return  netFailMsg;
        }
            break;
        case 1001://tiket 过期
        {
            [ZYUserTool logOut];
            return netFailMsg;
        }
            break;
        case 1002://token 过期 重新获取token，再继续上次请求
        {
//            [ZYNewApiTool ZYLoginByTicket:^(NSDictionary *msg) {
//                ZYUser *user =[ZYUserTool loadInfo];
//                if (user.isLogin) {
//                    [ZYUserTool logIn:[ZYUserTool loadUserData:msg]];
//                }
//                if (done) {
//                    done();
//                }
//            } failure:^(NSString *errormsg) {
//                
//                [ZYTool showMessage:@"请重新登录"];
//                [ZYUserTool logOut];
//                
//            }];
            return  nil;
        }
            break;
            
        case 2001://账号不存在
        {
            return msg==nil?@"账号不存在":msg;
        }
            
            
            
        default:
        {
            return msg==nil?netFailMsg:msg;
            
        }
            break;
    }
    return netFailMsg;
}

@end
