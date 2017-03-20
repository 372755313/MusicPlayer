//
//  HWHTTPSessionManager.h
//  
//
//  Created by skywalkerwei on 16/3/20.
//  Copyright © 2016年 skywalkerwei. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef enum{
    kNetStateUnknown  = -1,//未知网络
    kNetStateNone,  // 无网络
    kNetStateVLan,  // 手机网络
    kNetStateWifi,  // wifi
    
} kNetState;



typedef void(^HWProgressBlock)      (NSProgress *progress);
typedef void(^HWSuccessBlock)       (id responseObject);
typedef void(^HWFailureBlock)       (NSError   *error);

//NSString * const  kBASE_URL         = @"";
//const float   kTimeoutInterval      = 30.0f;

#define kBASE_URL           @""
#define kTimeoutInterval    30.0f

@interface HWHTTPSessionManager : NSObject



@property (nonatomic,strong) AFHTTPSessionManager *mager;

#pragma mark - shareedHTTPSessionManager

+ (instancetype)shareedHTTPSessionManager;

#pragma mark - get

//网络变化
- (void)netStatusChange:(void (^)(kNetState))statusBlock;

/**
 *  没有进度条的get请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)get:(NSString *)urlString
 parameters:(id)parameters
netIdentifier:(NSString *)netIdentifier
    success:(HWSuccessBlock)successBlock
    failure:(HWFailureBlock)failureBlock;

/**
 *  有进度条的get请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)get:(NSString *)urlString
 parameters:(id)parameter
netIdentifier:(NSString *)netIdentifier
   progress:(HWProgressBlock)progressBlock
    success:(HWSuccessBlock)successBlock
    failure:(HWFailureBlock)failureBlock;


#pragma mark - post

/**
 *  没有进度条的post请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)post:(NSString *)urlString
  parameters:(id)parameters
netIdentifier:(NSString *)netIdentifier
     success:(HWSuccessBlock)successBlock
     failure:(HWFailureBlock)failureBlock;

/**
 *  有进度条的post请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)post:(NSString *)urlString
  parameters:(id)parameters
netIdentifier:(NSString *)netIdentifier
    progress:(HWProgressBlock)progressBlock
     success:(HWSuccessBlock)successBlock
     failure:(HWFailureBlock)failureBlock;


/**
 *  有进度条的上传请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)upload:(NSString *)urlString
    parameters:(id)parameters
   uploadParam:(NSArray *)uploadParams
 netIdentifier:(NSString *)netIdentifier
      progress:(HWProgressBlock)progressBlock
       success:(HWSuccessBlock)successBlock
       failure:(HWFailureBlock)failureBlock;


#pragma mark - other

#pragma mark - 取消相关

/**
 *  取消所有网络请求
 */
- (void)cancelAllNetworking;
/**
 *  取消一组网络请求
 */
- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifier;

/**
 *  取消对应的网络请求
 */
- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier;

/**
 *  获取正在进行的网络请求
 */
- (NSArray <NSString *>*)getUnderwayNetIdentifierArray;

#pragma mark - 暂停相关

/**
 *  暂停所有网络请求
 */
- (void)suspendAllNetworking;

/**
 *  暂停一组网络请求
 */
- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray;

/**
 *  暂停对应的网络请求
 */
- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier;

/**
 *  获取正暂停的网络请求
 */
- (NSArray <NSString *>*)getSuspendNetIdentifierArray;


#pragma mark - 恢复相关

/**
 *  恢复所有暂停的网络请求
 */
- (void)resumeAllNetworking;

/**
 *  恢复一组暂停的网络请求
 */
- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray;

/**
 *  暂停暂停的的网络请求
 */
- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier;
@end


/**
 *  用来封装文件数据的模型
 */
@interface HWFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
