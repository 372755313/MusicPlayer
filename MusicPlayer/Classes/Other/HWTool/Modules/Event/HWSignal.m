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

#import "HWSignal.h"
#import <objc/message.h>
#define kHWSignalHandler_key "NSObject.signalHandler.key"

#pragma mark- HWSignal
@implementation HWSignal
@end

#pragma mark- NSObject(__HWSignalHandler)
@interface NSObject (__HWSignalHandler) <HWSignalTarget>
@property (nonatomic, weak) id HW_nextSignalHandler;
@end

@implementation NSObject (HWSignalHandler)

- (HWSignal *)HW_sendSignalWithName:(NSString *)name userInfo:(id)userInfo
{
    return [self HW_sendSignalWithName:name userInfo:userInfo sender:self];
}

- (HWSignal *)HW_sendSignalWithName:(NSString *)name userInfo:(id)userInfo sender:(id)sender
{
    HWSignal *signal = [[HWSignal alloc] init];
    signal.sender    = sender ?: self;
    signal.name      = name;
    signal.userInfo  = userInfo;
    
    [self __HW_handleSignal:signal];
    
    return signal;
}

#pragma mark- private
- (BOOL)__HW_performSignal:(HWSignal *)signal
{
    // 1. 普通的
    NSString *string = [NSString stringWithFormat:@"__HW_handleSignal_n_%@:", signal.name];
    SEL sel = NSSelectorFromString(string);
    if ([self respondsToSelector:sel])
    {
        signal.isReach = YES;
        NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self];
        [invocation setSelector:sel];
        [invocation setArgument:&signal atIndex:2];
        [invocation invoke];
        
        return YES;
    }

    return NO;
}

- (id)__HW_handleSignal:(HWSignal *)signal
{
    id result;
    signal.jump++;
    
    [self __HW_performSignal:signal];
    
    if (signal.isDead == YES) return nil;
    if (signal.isReach == YES) return nil;
    
    id next = self.HW_nextSignalHandler ?: self.HW_defaultNextSignalHandler;
    
    result = [next __HW_handleSignal:signal];
    
    return result;
}

- (id)HW_defaultNextSignalHandler
{
    return nil;
}

hw_staticConstString(HWSignalHandler_nextSignalHandler)
- (void)setHW_nextSignalHandler:(id)nextSignalHandler
{
    objc_setAssociatedObject(self, HWSignalHandler_nextSignalHandler, nextSignalHandler, OBJC_ASSOCIATION_ASSIGN);
}
- (id)HW_nextSignalHandler
{
    return objc_getAssociatedObject(self, HWSignalHandler_nextSignalHandler);
}
@end

#pragma mark - UIView
@implementation UIView (HWSignalHandler)

- (id)HW_defaultNextSignalHandler
{
    return self.nextResponder;
}

@end

#pragma mark - UIViewController
@implementation UIViewController (HWSignalHandler)

- (id)HW_defaultNextSignalHandler
{
    id result;
    
    if ([self isKindOfClass:[UINavigationController class]])
    {
        //result = [(UINavigationController *)self topViewController];
    }
    else
    {
        result = [self parentViewController];
    }
    
    return result;
}

@end

#pragma mark -
/*
@implementation HWSignalBus
+ (instancetype)defaultBus
{
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}
@end
 */
