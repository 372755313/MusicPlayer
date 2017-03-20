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

#define HWRuntime_SORT 0        // 对返回的类,方法进行排序(1开启, 0关闭)

@interface HWRuntime : NSObject

/**
 * @brief 移魂大法
 * @param clazz 原方法的类
 * @param original 原方法
 * @param replacement 劫持后的方法
 */
+ (void)swizzleInstanceMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement;

@end

#pragma mark -

#undef	HW_class
#define	HW_class( x )		NSClassFromString(@ #x)

#undef	HW_instance
#define	HW_instance( x )	[[NSClassFromString(@ #x) alloc] init]

#pragma mark -

@interface NSObject (HWRuntime)

// class
+ (NSArray *)HW_subClasses;
+ (NSArray *)HW_classesWithProtocol:(NSString *)protocolName;

// method
+ (NSArray *)HW_methods;
+ (NSArray *)HW_methodsWithPrefix:(NSString *)prefix;
+ (NSArray *)HW_methodsUntilClass:(Class)baseClass;
+ (NSArray *)HW_methodsWithPrefix:(NSString *)prefix untilClass:(Class)baseClass;

+ (void *)HW_replaceSelector:(SEL)sel1 withSelector:(SEL)sel2;

// property
+ (NSArray *)HW_properties;
+ (NSArray *)HW_propertiesUntilClass:(Class)baseClass;
+ (NSArray *)HW_propertiesWithPrefix:(NSString *)prefix;
+ (NSArray *)HW_propertiesWithPrefix:(NSString *)prefix untilClass:(Class)baseClass;



@end