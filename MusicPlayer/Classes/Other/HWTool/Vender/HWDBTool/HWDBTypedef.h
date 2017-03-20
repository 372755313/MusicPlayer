//
//  HWDBTypedef.h
//
//
//

#ifndef HWDBTypedef_h
#define HWDBTypedef_h

// 结果
typedef void (^DBUpdateOperationResultBlock) (BOOL success);
typedef void (^DBQueryOperationResultBlock) (BOOL success, NSArray *result);

//数据类型
typedef NS_ENUM(NSUInteger, kDataType) {
    kDataTypeNull,       //NULL：空值。
    kDataTypeInt,       //INTEGER：带符号的整型，具体取决有存入数字的范围大小。
    kDataTypeUInt,      //INTEGER：带符号的整型，具体取决有存入数字的范围大小。
    kDataTypeReal,       //REAL：浮点数字，存储为8-byte IEEE浮点数。
    kDataTypeText,       //TEXT：字符串文本
    kDataTypeBlob,       //BLOB：二进制对象
    kDataTypeDate        //时间
};



//操作类型
typedef NS_ENUM(NSUInteger, kCapabilityType) {
    kCapabilityType_Add,     //添加
    kCapabilityType_Delete,  //删除
    kCapabilityType_Update,  //更新
    kCapabilityType_Query,   //查询
};

//sql
typedef NS_ENUM(NSUInteger, kDataCompareType) {
    kDataCompareType_Equal,         // =
    kDataCompareType_NotEqual,      // !=
    kDataCompareType_Like,          // like
    kDataCompareType_Less,          // <
    kDataCompareType_LessEqual,     // <=
    kDataCompareType_Larger,        // >
    kDataCompareType_LargerEqual,   // >=
};

//sql 连接
typedef NS_ENUM(NSUInteger, kLogicRelationship) {
    kLogicRelationship_And,         // and
    kLogicRelationship_Or,          // or
};

#endif
