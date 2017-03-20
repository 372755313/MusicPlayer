//
//
//  Copyright (C) skywalkerwei.
//
//
//	Permission is skywalkerwei granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#pragma mark -

@interface NSObject (Hw)

#pragma mark - property
// 属性列表
@property (nonatomic, readonly, strong) NSArray *hw_attributeList;

#pragma mark - conversion
- (NSInteger)hw_asInteger;     // NSNumber, NSNull, NSString, NSString, NSDate
- (float)hw_asFloat;           // NSNumber, NSNull, NSString, NSString, NSDate
- (BOOL)hw_asBool;             // NSNumber, NSNull, NSString, NSString, NSDate

- (NSNumber *)hw_asNSNumber;   // NSNumber, NSNull, NSString, NSString, NSDate
- (NSString *)hw_asNSString;   // NSString, NSNull, NSData
- (NSData *)hw_asNSData;       // NSData, NSString
- (NSArray *)hw_asNSArray;     // NSArray, NSObject

#pragma mark- copy
- (id)hw_deepCopy1; // 基于NSKeyArchive
@end


#pragma mark- HW_associated
#define hw_property_strong( __type, __name) \
        property (nonatomic, strong, setter=set__##__name:, getter=__##__name) __type __name;

#define hw_def_property_strong( __type, __name) \
        - (__type)__##__name   \
        { return [self hw_getAssociatedObjectForKey:#__name]; }   \
        - (void)set__##__name:(id)__##__name   \
        { [self hw_setRetainAssociatedObject:(id)__##__name forKey:#__name]; }

#define hw_property_weak( __type, __name) \
        property (nonatomic, weak, setter=set__##__name:, getter=__##__name) __type __name;

#define hw_def_property_weak( __type, __name) \
        - (__type)__##__name   \
        { return [self hw_getAssociatedObjectForKey:#__name]; }   \
        - (void)set__##__name:(id)__##__name   \
        { [self hw_setAssignAssociatedObject:(id)__##__name forKey:#__name]; }


#define hw_property_copy( __type, __name) \
        property (nonatomic, copy, setter=set__##__name:, getter=__##__name) __type __name;

#define hw_def_property_copy( __type, __name) \
        - (__type)__##__name   \
        { return [self hw_getAssociatedObjectForKey:#__name]; }   \
        - (void)set__##__name:(id)__##__name   \
        { [self hw_setCopyAssociatedObject:(id)__##__name forKey:#__name]; }

#define hw_property_retain( __type, __name) \
        property (nonatomic, retain, setter=set__##__name:, getter=__##__name) __type __name;

#define hw_def_property_retain( __type, __name) \
        - (__type)__##__name   \
        { return [self hw_getAssociatedObjectForKey:#__name]; }   \
        - (void)set__##__name:(id)__##__name   \
        { [self hw_setRetainAssociatedObject:(id)__##__name forKey:#__name]; }

#define hw_property_assign( __type, __name) \
        property (nonatomic, assign, setter=set__##__name:, getter=__##__name) __type __name;

#define hw_def_property_assign( __type, __name) \
        - (__type)__##__name   \
        { return [self hw_getAssociatedObjectForKey:#__name]; }   \
        - (void)set__##__name:(id)__##__name   \
        { [self hw_setAssignAssociatedObject:(id)__##__name forKey:#__name]; }

#define hw_property_basicDataType( __type, __name) \
        property (nonatomic, assign, setter=set__##__name:, getter=__##__name) __type __name;

#define hw_def_property_basicDataType( __type, __name) \
        - (__type)__##__name   \
        {   \
            NSNumber *number = [self hw_getAssociatedObjectForKey:#__name];    \
            return metamacro_concat(metamacro_concat(__hw_, __type), _value)( number ); \
        }   \
        - (void)set__##__name:(__type)__##__name   \
        { \
            NSNumber *number = @(__##__name);\
            [self hw_setRetainAssociatedObject:number forKey:#__name];     \
        }

#define __hw_int_value( __nubmer ) [__nubmer intValue]
#define __hw_char_value( __nubmer ) [__nubmer charValue]
#define __hw_short_value( __nubmer ) [__nubmer shortValue]
#define __hw_long_value( __nubmer ) [__nubmer longValue]
#define __hw_float_value( __nubmer ) [__nubmer floatValue]
#define __hw_double_value( __nubmer ) [__nubmer doubleValue]
#define __hw_BOOL_value( __nubmer ) [__nubmer boolValue]
#define __hw_NSInteger_value( __nubmer ) [__nubmer integerValue]
#define __hw_NSUInteger_value( __nubmer ) [__nubmer unsignedIntegerValue]
#define __hw_NSTimeInterval_value( __nubmer ) [__nubmer doubleValue]

// 关联对象OBJC_ASSOCIATION_ASSIGN策略不支持引用计数为0的弱引用
@interface NSObject (Hw_associated)
- (id)hw_getAssociatedObjectForKey:(const char *)key;
- (void)hw_setCopyAssociatedObject:(id)obj forKey:(const char *)key;
- (void)hw_setRetainAssociatedObject:(id)obj forKey:(const char *)key;
- (void)hw_setAssignAssociatedObject:(id)obj forKey:(const char *)key;
- (void)hw_removeAssociatedObjectForKey:(const char *)key;
- (void)hw_removeAllAssociatedObjects;
@end


