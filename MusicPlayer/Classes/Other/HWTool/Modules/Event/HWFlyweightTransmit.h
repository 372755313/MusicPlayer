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

// 解决a知道b,b不知道a, b传数据给a的情况

@interface NSObject (HWFlyweightTransmit)
@property (nonatomic, strong) id hw_flyweightData;
- (void)hw_receiveObject:(void(^)(id object))aBlock withIdentifier:(NSString *)identifier;
- (void)hw_sendObject:(id)anObject withIdentifier:(NSString *)identifier;
- (void)hw_handlerEventWithBlock:(id)aBlock withIdentifier:(NSString *)identifier;
- (id)hw_blockForEventWithIdentifier:(NSString *)identifier;
@end

#pragma mark-
@protocol HWFlyweightTransmit <NSObject>

@property (nonatomic, strong) id hw_flyweightData;

// 传递一个数据
- (void)hw_receiveObject:(void(^)(id object))aBlock withIdentifier:(NSString *)identifier;
- (void)hw_sendObject:(id)anObject withIdentifier:(NSString *)identifier;

// 设置一个block作为回调
- (void)hw_handlerEventWithBlock:(id)aBlock withIdentifier:(NSString *)identifier;
- (id)hw_blockForEventWithIdentifier:(NSString *)identifier;

@end


