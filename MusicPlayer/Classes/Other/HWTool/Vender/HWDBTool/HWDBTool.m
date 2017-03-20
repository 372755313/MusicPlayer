//
//  HWDBTool.m
//  pyxiu
//
//  Created by skywakerwei on 14/11/18.
//  Copyright (c) 2014年 skywalkerwei. All rights reserved.
//

#import "FMDB.h"
#import "HWDBTool.h"

#define kDocumentDir ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject])
#define kDataPath [kDocumentDir stringByAppendingPathComponent:@"DB.sqlite"]

static HWDBTool  *DBTool = nil;

@implementation HWDBTool


+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (DBTool == nil) {
            DBTool = [super allocWithZone:zone];
        }
    }
    return DBTool;

}

+ (id)copyWithZone:(struct _NSZone *)zone
{
         return self;
}

+ (id)shareHWDB {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBTool = [[self alloc] init];
    });
    return DBTool;
}

- (instancetype)init
{

    if (self = [super init]) {
        //创建fmdbqueue
        _DBQueue = [FMDatabaseQueue databaseQueueWithPath:kDataPath];
        DLog(@"%@",kDataPath);
        
    }

    return self;

}

#pragma mark - 创建数据库
- (BOOL)HWDBToolCreateTableName:(NSString *)tablename keyVal:(NSArray *)vals
{
    NSMutableArray *strarry = [NSMutableArray array];
    for (HWDBFieldAttribute *att in vals) {
        [strarry addObject:[att returnToSqlStr]];
    }
    NSString *sql = [NSString stringWithFormat:
                     @"create table if not exists %@ ( %@ );",
                     tablename,
                     [strarry componentsJoinedByString:@","]];
    return [self HWDBToolExecuteUpdateWithSql:sql];

}

#pragma mark 删除表
- (BOOL)HWDBToolDorpableName:(NSString *)tablename
{
    NSString *sql = [NSString stringWithFormat:
                     @"DROP TABLE %@;",
                     tablename];
    return [self HWDBToolExecuteUpdateWithSql:sql];
}

#pragma mark 插入内容
- (BOOL)HWDBToolInsertTableName:(NSString *)tablename
                     insertData:(NSDictionary *)insertData
{

    NSArray *keyarr = [insertData allKeys];
    NSArray *valarr = [insertData allValues];
    NSMutableArray *newVal = [NSMutableArray array];
    for (NSString *str in valarr) {
        [newVal addObject:[NSString stringWithFormat:@"'%@'",str]];
    }
    NSString *sql = [NSString stringWithFormat:@" insert into %@ ( %@ ) values ( %@ ); ",
                     tablename,
                     [keyarr componentsJoinedByString:@","],
                     [newVal componentsJoinedByString:@","]
                     ];
    return [self HWDBToolExecuteUpdateWithSql:sql];

}

#pragma mark count
- (NSInteger)HWDBToolCountTableName:(NSString *)tablename
                              where:(NSString *)where
{
    __block NSInteger count = 0;

    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where %@",tablename,where];
    DLog(@"%@",sql);
    [self HWDBToolExecuteWithSql:sql result:^(FMResultSet *set) {
     
        if ([set next]) {
             count = [set intForColumnIndex:0];
        }
    }];
    return count;
}

// NSString
- (NSString *)HWDBToolGetStrTableName:(NSString *)tablename keyword:(NSString *)keyword where:(NSString *)where
{
    __block NSString *str ;
    
     NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@",keyword,tablename,where];
    DLog(@"%@",sql);
    [self HWDBToolExecuteWithSql:sql result:^(FMResultSet *set) {
        
        if ([set next]) {
            str = [set stringForColumnIndex:0];
        }
    }];
    
    return str;
    
}

// NSData
- (NSData *)HWDBToolGetDataTableName:(NSString *)tablename
                             keyword:(NSString *)keyword
                               where:(NSString *)where
{
    __block NSData *data ;
    
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@",keyword,tablename,where];
    DLog(@"%@",sql);
    [self HWDBToolExecuteWithSql:sql result:^(FMResultSet *set) {
        
        if ([set next]) {
            data = [set dataForColumnIndex:0];
        }
    }];
    
    return data;

}

#pragma mark 更新内容
- (BOOL)HWDBToolUPdateTableName:(NSString *)tablename
                     upadteData:(NSDictionary *)updataData
                       conditon:(HWDBCondition *)conditon;
{
    NSEnumerator *eData = [updataData keyEnumerator];
    id key;
    NSMutableArray *strarry = [NSMutableArray array];
    while ((key = [eData nextObject])) {
        NSString *set = [NSString stringWithFormat:@"%@ = '%@'",key,updataData[key]];
        [strarry addObject:set];
    }
    NSString *where = [conditon returnToSqlStr];

    NSString *sql = [NSString stringWithFormat:@"UPDATE  %@  SET %@ WHERE %@ ",
                     tablename,
                     [strarry componentsJoinedByString:@","],
                     where];

    return [self HWDBToolExecuteUpdateWithSql:sql];
}

- (BOOL)HWDBToolUPdateTableName:(NSString *)tablename
                     upadteData:(NSDictionary *)updataData
                      conditons:(HWDBConditions *)conditons
{
    NSEnumerator *eData = [updataData keyEnumerator];
    id key;
    NSMutableArray *strarry = [NSMutableArray array];
    while ((key = [eData nextObject])) {
        NSString *set = [NSString stringWithFormat:@"%@ = '%@'",key,updataData[key]];
        [strarry addObject:set];
    }
    NSString *where = [conditons HWDBConditions];
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE  %@  SET %@ WHERE %@ ",
                     tablename,
                     [strarry componentsJoinedByString:@","],
                     where];
    
    return [self HWDBToolExecuteUpdateWithSql:sql];

}

//sql条件
- (BOOL)HWDBToolUPdateTableName:(NSString *)tablename
                     upadteData:(NSDictionary *)updataData
                          where:(NSString *)where
{
    NSEnumerator *eData = [updataData keyEnumerator];
    id key;
    NSMutableArray *strarry = [NSMutableArray array];
    while ((key = [eData nextObject])) {
        NSString *set = [NSString stringWithFormat:@"%@ = '%@'",key,updataData[key]];
        [strarry addObject:set];
    }
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE  %@  SET %@ WHERE %@ ",
                     tablename,
                     [strarry componentsJoinedByString:@","],
                     where];
    
    return [self HWDBToolExecuteUpdateWithSql:sql];

}



#pragma mark 删除
//简单条件
- (BOOL)HWDBToolDeleteTableName:(NSString *)tablename
                       conditon:(HWDBCondition *)conditon
{
    NSString *where = [conditon returnToSqlStr];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",
                     tablename,
                     where];
    
    return [self HWDBToolExecuteUpdateWithSql:sql];
}
//复杂条件
- (BOOL)HWDBToolDeleteTableName:(NSString *)tablename
                      conditons:(HWDBConditions *)conditons
{
    NSString *where = [conditons HWDBConditions];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",
                     tablename,
                     where];
    return [self HWDBToolExecuteUpdateWithSql:sql];

}
//sql条件
- (BOOL)HWDBToolDeleteTableName:(NSString *)tablename
                          Where:(NSString *)where
{

    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",
                     tablename,
                     where];
    
    return [self HWDBToolExecuteUpdateWithSql:sql];
}

#pragma mark - 查询
- (void)HWDBToolSelectTableName:(NSString *)tablename
                     columnList:(NSArray *)column
                          where:(NSString *)where
                        orderby:(NSString *)order
                          limit:(NSString *)limit
                         result:(MySet)set
{
    NSString *cList = (column == nil)?@"*":[column componentsJoinedByString:@","];
    NSString *whereStr = (where != nil)?[NSString stringWithFormat:@" where %@",where]:@"";
    NSString *orderStr = (order != nil)?[NSString stringWithFormat:@" order by %@",order]:@"";
    NSString *limitStr = (limit != nil)?[NSString stringWithFormat:@" limit %@",limit]:@"";

    NSString *sql = [NSString stringWithFormat:@"select %@ from %@%@%@%@",cList,tablename,whereStr,orderStr,limitStr];

   [self HWDBToolExecuteWithSql:sql result:set];


}

#pragma mark - 执行
- (BOOL)HWDBToolExecuteUpdateWithSql:(NSString *)sql
{
    __block NSInteger executeBool = 0;
    [_DBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        if ([db executeUpdate:sql]) {
            executeBool = 1;
        }
        [db close];

    }];
    [_DBQueue close];
    return executeBool;

}

//查询
- (id)HWDBToolExecuteWithSql:(NSString *)sql
{
    
    __block id datas;
    [_DBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        FMResultSet *rs = [db executeQuery:sql];
        datas = rs;
        [db close];
    }];
    [_DBQueue close];
    return datas;
}

- (void)HWDBToolExecuteWithSql:(NSString *)sql result:(MySet)set
{

    [_DBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        FMResultSet *rs = [db executeQuery:sql];
        set(rs);
        [db close];
    }];
    [_DBQueue close];

}

@end
