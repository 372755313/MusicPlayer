//
//  HWHTTPSessionManager.h
//
//
//  Created by skywalkerwei on 16/3/20.
//  Copyright © 2016年 skywalkerwei. All rights reserved.
//

#import "HWHTTPSessionManager.h"


#define fUNC_NIL_BLOCK(block,blocks)  \
            if (block) {              \
                blocks;               \
            }                         \

@interface HWHTTPSessionManager ()

@property (strong, nonatomic) NSMutableArray <NSDictionary<NSString *,NSURLSessionDataTask *> *> *networkingManagerArray;


@end

@implementation HWHTTPSessionManager

#pragma mark -


- (instancetype)init {
    
    if (self = [super init]) {
        _networkingManagerArray = [NSMutableArray array];
        
        self.mager = (kBASE_URL.length > 0) ?  [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBASE_URL]] : [[AFHTTPSessionManager alloc] init];
       
        AFHTTPRequestSerializer *requestSerializerNotCache = [AFHTTPRequestSerializer serializer];
        requestSerializerNotCache.timeoutInterval = kTimeoutInterval;
//        self.mager.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    return self;
}

+ (instancetype)shareedHTTPSessionManager {
    
    static  HWHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sessionManager == nil) {
            sessionManager  = [[[self class] alloc] init];
        }
    });
    return sessionManager;
}

#pragma mark - get

- (void)netStatusChange:(void (^)(kNetState))statusBlock
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        kNetState netState ;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                netState = kNetStateUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                 netState = kNetStateNone;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netState = kNetStateVLan;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                 netState = kNetStateWifi;
                break;
                
            default:
                break;
        }
        
        if(statusBlock){
            statusBlock(netState);
        }
    }];
}



- (void)get:(NSString *)urlString
 parameters:(id)parameters
netIdentifier:(NSString *)netIdentifier
    success:(HWSuccessBlock)successBlock
    failure:(HWFailureBlock)failureBlock
{
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

- (void)get:(NSString *)urlString
 parameters:(id)parameter
netIdentifier:(NSString *)netIdentifier
   progress:(HWProgressBlock)progressBlock
    success:(HWSuccessBlock)successBlock
    failure:(HWFailureBlock)failureBlock
{
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameter netIdentifier:netIdentifier progress:progressBlock success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

#pragma mark - post

- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(HWSuccessBlock)successBlock failure:(HWFailureBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

- (void)post:(NSString *)urlString
  parameters:(id)parameters
netIdentifier:(NSString *)netIdentifier
    progress:(HWProgressBlock)progressBlock
     success:(HWSuccessBlock)successBlock
     failure:(HWFailureBlock)failureBlock
{
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:progressBlock success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}


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
       failure:(HWFailureBlock)failureBlock
{
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:progressBlock success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        for (HWFormData *formData in uploadParams) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progressBlock) {
            progressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
    
}

#pragma mark - cancel

- (void)cancelAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        [task cancel];
    }
    [self.networkingManagerArray removeAllObjects];
}

- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self cancelNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task cancel];
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
            return;
        }
    }
}

- (NSArray <NSString *>*)getUnderwayNetIdentifierArray {
    
    NSMutableArray *muarr = [NSMutableArray array];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        [muarr addObject:key];
    }
    return muarr;
}

#pragma mark - suspend

- (void)suspendAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateRunning) {
            [task suspend];
        }
    }
}

- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self suspendNetworkingWithNetIdentifier:netIdentifier];
    }
    
}

- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task suspend];
        }
    }
}

- (NSArray<NSString *> *)getSuspendNetIdentifierArray {
    
    NSMutableArray *muarr = [NSMutableArray array];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        
        if (task.state == NSURLSessionTaskStateSuspended) {
            [muarr addObject:key];
        }
    }
    return muarr;
}

#pragma  mark - resume

- (void)resumeAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateSuspended) {
            [task resume];
        }
    }
}

- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        
        [self resumeNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            if (task.state == NSURLSessionTaskStateSuspended) {
                [task resume];
            }
        }
    }
}

#pragma  mark - 私有方法

- (AFHTTPSessionManager *)getManagerWithWithPath:(const NSString *)path
                                      parameters:(id)parameters
                                   netIdentifier:(NSString *)netIdentifier
                                        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                         success:(void (^)(id responseObject))successBlock
                                         failure:(void (^)(NSError   *error))failureBlock {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
//            DLog(@"当前的请求正在进行,拦截请求");
            if (failureBlock) {
                NSError *cancelError = [NSError errorWithDomain:@"请求正在进行!" code:(-12001) userInfo:nil];
                fUNC_NIL_BLOCK(failureBlock , failureBlock(cancelError));
            }
            return nil;
        }
    }
    
   
    return  self.mager;
}

@end


/**
 *  用来封装文件数据的模型
 */
@implementation HWFormData

@end