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

// 声明一个notification name
#define hw_def_notification_name( __name )                      hw_staticConstString( __name )

// 响应一个 notification
#define hw_handleNotification( __name, __notification ) \
        - (void)__hw_handleNotification_##__name:(NSNotification *)__notification

typedef void(^HWNotification_block)(NSNotification *notification);

#pragma mark - HWNotification
@interface HWNotification : NSObject

@end

#pragma mark - NSObject (HWNotification)
// 注意这里 self 自己可能是被观察者; 也可能 self 持有了观察者, 在self 销毁的时候, 取消所有的观察
@interface NSObject (HWNotification)

@property (nonatomic, readonly, strong) NSMutableDictionary *hw_notifications;

- (void)hw_registerNotification:(const char *)name;
- (void)hw_registerNotification:(const char *)name block:(HWNotification_block)block;

- (void)hw_unregisterNotification:(const char *)name;
- (void)hw_unregisterAllNotification;

- (void)hw_postNotification:(const char *)name userInfo:(id)userInfo;

@end