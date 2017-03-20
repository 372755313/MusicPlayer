//
//  HWJsonData.h
//  tg
//
//  Copyright (c) 2015年 skywakerwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYJsonData : NSObject
/**
 *  message
 */
@property (nonatomic, assign) NSString  *rmk;

/**
 *  错误代码
 */
@property (nonatomic, assign) NSInteger returnCode;

/**
 *  message
 */
@property (nonatomic, strong) id data;

+ (ZYJsonData *)loadDataWithJson:(NSDictionary *)json;
@end
