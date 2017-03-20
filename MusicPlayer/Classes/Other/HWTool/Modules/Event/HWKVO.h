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
#import "HWPredefine.h"
#pragma mark -

#pragma mark - #define

// 响应一个KVO属性
#define hw_handleKVO( __property, __sourceObject, ...)            \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))         \
        (__hw_handleKVO_1(__property, __sourceObject, __VA_ARGS__))    \
        (__hw_handleKVO_2(__property, __sourceObject, __VA_ARGS__))


#define __hw_handleKVO_1( __property, __sourceObject, __newValue) \
        - (void)__hw_handleKVO_##__property##_in:(id)sourceObject new:(id)newValue

#define __hw_handleKVO_2( __property, __sourceObject, __newValue, __oldValue ) \
        - (void)__hw_handleKVO_##__property##_in:(id)sourceObject new:(id)newValue old:(id)oldValue

typedef void(^HWKVO_block_new_old)(id newValue, id oldValue);

#pragma mark - HWKVO
@interface HWKVO : NSObject

@end

#pragma mark - NSObject (HWObserve)

// 注意这里是 self 持有了观察者, 在 self 销毁的时候, 取消所有的观察
@interface NSObject (HWKVO)

@property (nonatomic, readonly, strong) NSMutableDictionary *hw_KVO;

/**
 * api parameters 说明
 *
 * sourceObject 被观察的对象
 * keyPath 被观察的属性keypath
 * target 默认是self
 * block selector, block二选一
 */
- (void)hw_observeWithObject:(id)sourceObject property:(NSString *)property;
- (void)hw_observeWithObject:(id)sourceObject property:(NSString *)property block:(HWKVO_block_new_old)block;

- (void)hw_removeObserverWithObject:(id)sourceObject property:(NSString *)property;
- (void)hw_removeObserverWithObject:(id)sourceObject;
- (void)hw_removeAllObserver;

@end



