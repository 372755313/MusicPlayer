//
//  HWDBTool.h
//  pyxiu
//
//  Created by skywakerwei on 14/11/18.
//  Copyright (c) 2014年 skywalkerwei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HWDBFieldAttribute.h"

#import "FMResultSet.h"



@class FMDatabaseQueue;

typedef  void (^MySet)(FMResultSet *);


@interface HWDBTool : NSObject

@property (nonatomic,strong) FMDatabaseQueue *DBQueue;

+ (id)shareHWDB;


/* 
 创建表 eg:
 [db HWDBToolCreateTableName:@"kt_areaCache" keyVal: ];
 */
- (BOOL)HWDBToolCreateTableName:(NSString *)tablename
                         keyVal:(NSArray *)vals;



/*
 删除表 eg:
 [db HWDBToolDorpableName:@"kt_areaCache"];
 */
- (BOOL)HWDBToolDorpableName:(NSString *)tablename;


/*
 insert 操作eg:
     [db HWDBToolInsertTableName:@"kt_areaCache" insertData:@{@"code":@"252022212abc",
                                                              @"initial":@"hw", @"lat":@"18",
                                                              @"lon":@"1", @"name":@"测试",
                                                              @"type":@"3"}];
 */
- (BOOL)HWDBToolInsertTableName:(NSString *)tablename
                     insertData:(NSDictionary *)insertData;


// count
- (NSInteger)HWDBToolCountTableName:(NSString *)tablename
                              where:(NSString *)where;

// NSString
- (NSString *)HWDBToolGetStrTableName:(NSString *)tablename
                             keyword:(NSString *)keyword
                               where:(NSString *)where;

// NSData
- (NSData *)HWDBToolGetDataTableName:(NSString *)tablename
                               keyword:(NSString *)keyword
                                 where:(NSString *)where;

/*update 操作eg:
 */
//简单条件
- (BOOL)HWDBToolUPdateTableName:(NSString *)tablename
                     upadteData:(NSDictionary *)updataData
                       conditon:(HWDBCondition *)conditon;
//复杂条件
- (BOOL)HWDBToolUPdateTableName:(NSString *)tablename
                     upadteData:(NSDictionary *)updataData
                      conditons:(HWDBConditions *)conditons;
//sql条件
- (BOOL)HWDBToolUPdateTableName:(NSString *)tablename
                     upadteData:(NSDictionary *)updataData
                          where:(NSString *)where;

//delete 操作
//简单条件
- (BOOL)HWDBToolDeleteTableName:(NSString *)tablename
                       conditon:(HWDBCondition *)conditon;
//复杂条件
- (BOOL)HWDBToolDeleteTableName:(NSString *)tablename
                      conditons:(HWDBConditions *)conditons;

- (BOOL)HWDBToolDeleteTableName:(NSString *)tablename
                          Where:(NSString *)where;
//查询
- (void)HWDBToolSelectTableName:(NSString *)tablename
                     columnList:(NSArray *)column
                          where:(NSString *)where
                        orderby:(NSString *)order
                          limit:(NSString *)limit
                         result:(MySet)set;

//直接执行sql
- (BOOL)HWDBToolExecuteUpdateWithSql:(NSString *)sql;
//直接执行查询sql
- (id)HWDBToolExecuteWithSql:(NSString *)sql;
//直接执行查询sql Block 处理
- (void)HWDBToolExecuteWithSql:(NSString *)sql result:(MySet)set;


@end
