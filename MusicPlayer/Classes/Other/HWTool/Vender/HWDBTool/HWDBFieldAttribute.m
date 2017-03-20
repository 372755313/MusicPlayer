//
//  HWDBFieldAttribute.m
//  skywakerwei
//
//  Created by skywakerwei on 15/10/14.
//  Copyright © 2015年 skywakerwei. All rights reserved.
//

#import "HWDBFieldAttribute.h"

@implementation HWDBFieldAttribute


+ (HWDBFieldAttribute *)HWDBFieldAttribute:(NSString *)name
                                      type:(kDataType)type
                                 isPrimary:(BOOL)isPrimary
                           isAutoincrement:(BOOL)isAutoincrement
                                 isNOTNull:(BOOL)isNOTNull
{
    HWDBFieldAttribute *attribute = [[HWDBFieldAttribute alloc]init];
    attribute.name = name;
    attribute.type = type;
    attribute.isPrimary = isPrimary;
    attribute.isAutoincrement = isAutoincrement;
    attribute.isNOTNull = isNOTNull;
    return attribute;
}

- (NSString *)returnToSqlStr
{
  
    NSString *sqlStr ;
    switch (self.type) {
        case kDataTypeNull: { sqlStr = [self.name stringByAppendingString:@" NULL"];} break;
        case kDataTypeInt:  { sqlStr = [self.name stringByAppendingString:@" INTEGER"];} break;
        case kDataTypeUInt: { sqlStr = [self.name stringByAppendingString:@" INTEGER unsigned"];} break;
        case kDataTypeReal: { sqlStr = [self.name stringByAppendingString:@" REAL"];} break;
        case kDataTypeText: { sqlStr = [self.name stringByAppendingString:@" TEXT"];} break;
        case kDataTypeBlob: { sqlStr = [self.name stringByAppendingString:@" BLOB"];} break;
        case kDataTypeDate: { sqlStr = [self.name stringByAppendingString:@" date"];} break;
        default: {}break;
    }
 
    if (self.isPrimary) {
       sqlStr = [sqlStr stringByAppendingString:@" primary key"];
    }
    if (self.isAutoincrement) {
        sqlStr = [sqlStr stringByAppendingString:@" autoincrement"];
    }
    if (self.isNOTNull) {
        sqlStr = [sqlStr stringByAppendingString:@" NOT NULL"];
    }
    
    return sqlStr;
}

@end

//条件
@implementation HWDBCondition

+ (HWDBCondition *)HWDBCondition:(NSString *)key val:(NSString *)val type:(kDataCompareType)type
{
    HWDBCondition *condition = [[HWDBCondition alloc]init];
    condition.key = key;
    condition.val = val;
    condition.type = type;
    return condition;
}



- (NSString *)returnToSqlStr
{
    NSString *sqlStr ;
    switch (self.type) {
        case kDataCompareType_Equal:        { sqlStr = [NSString stringWithFormat:@" %@ = %@ ",self.key,self.val];} break;
        case kDataCompareType_NotEqual:     { sqlStr = [NSString stringWithFormat:@" %@ != %@ ",self.key,self.val];} break;
        case kDataCompareType_Like:         { sqlStr = [NSString stringWithFormat:@" %@ like '%%%@%%' ",self.key,self.val];} break;
        case kDataCompareType_Less:         { sqlStr = [NSString stringWithFormat:@" %@ < %@ ",self.key,self.val];} break;
        case kDataCompareType_LessEqual:    { sqlStr = [NSString stringWithFormat:@" %@ <= %@ ",self.key,self.val];} break;
        case kDataCompareType_Larger:       { sqlStr = [NSString stringWithFormat:@" %@ > %@ ",self.key,self.val];} break;
        case kDataCompareType_LargerEqual:  { sqlStr = [NSString stringWithFormat:@" %@ >= %@ ",self.key,self.val];} break;
        default:
            break;
    }
    
    return sqlStr;
}


@end


//复杂条件
@implementation HWDBConditions
//$map['id']  = array(array('neq',6),array('gt',3),'and');
- (NSString *)HWDBConditions
{
    NSString *sqlStr ;
//      @[[HWDBCondition HWDBCondition:@"id" val:@"1" type:kDataCompareType_Equal],@(kLogicRelationship_And),[HWDBCondition HWDBCondition:@"id" val:@"1" type:kDataCompareType_Equal]];
//    for (id data in <#collection#>) {
//        <#statements#>
//    }
//    
    return sqlStr;

}

@end