//
//  HWDBFieldAttribute.h
//  skywakerwei
//
//  Created by skywakerwei on 15/10/14.
//  Copyright © 2015年 skywakerwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWDBTypedef.h"

// 字段
@interface HWDBFieldAttribute : NSObject

//字段类型

@property (nonatomic, copy) NSString *name;             // proper name
@property (nonatomic, assign) kDataType type;            // data type of property
@property (nonatomic, assign) BOOL isPrimary;           // 是否主键
@property (nonatomic, assign) BOOL isAutoincrement;     // 是否autoincrement
@property (nonatomic, assign) BOOL isNOTNull;           // 是否可以为空


+ (HWDBFieldAttribute *)HWDBFieldAttribute:(NSString *)name
                                      type:(kDataType)type
                                 isPrimary:(BOOL)isPrimary
                           isAutoincrement:(BOOL)isAutoincrement
                                 isNOTNull:(BOOL)isNOTNull;

- (NSString *)returnToSqlStr;

@end

// 简单条件
@interface HWDBCondition : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *val;
@property (nonatomic, assign) kDataCompareType type;


+ (HWDBCondition *)HWDBCondition:(NSString *)key
                             val:(NSString *)val
                            type:(kDataCompareType)type;

- (NSString *)returnToSqlStr;

@end


// 复杂简单条件
@interface HWDBConditions : NSObject


@property (nonatomic, strong) NSArray *conditions;

- (NSString *)HWDBConditions;

@end