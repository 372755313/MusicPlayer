//
//  AmapLocationTool.h
//  地理编码使用高德 
//
//  Created by skywakerwei on 14/12/15.
//  Copyright (c) 2014年 skywakerwei. All rights reserved.
//  定位服务

#import <Foundation/Foundation.h>
#import "Singleton.h"


@interface AmapSlampLocationTool : NSObject

singleton_interface(AmapSlampLocationTool);

//简单
+ (void)getLocationCoordinate:(void (^)(NSDictionary *locDict, BOOL isNew))locaiontBlock
                        error:(void (^)(NSError *error)) errorBlock;


@end
