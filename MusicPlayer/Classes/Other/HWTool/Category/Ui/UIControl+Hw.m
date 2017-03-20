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


#import "UIControl+Hw.h"
#import <objc/runtime.h>
#pragma mark-
@implementation UIControl (Hw)

static const char *HWControl_key_events = "HWControl_key_events";

- (void)hw_handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block
{
    NSString *methodName = [UIControl __hw_eventName:event];
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, HWControl_key_events);
    
    if(opreations == nil)
    {
        opreations = [NSMutableDictionary dictionaryWithCapacity:2];
        objc_setAssociatedObject(self, HWControl_key_events, opreations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [opreations setObject:[block copy] forKey:methodName];
    [self addTarget:self action:NSSelectorFromString(methodName) forControlEvents:event];
}

- (void)hw_removeHandlerForEvent:(UIControlEvents)event
{
    NSString *methodName = [UIControl __hw_eventName:event];
    NSMutableDictionary *opreations = (NSMutableDictionary *)objc_getAssociatedObject(self, HWControl_key_events);
    
    if(opreations == nil)
    {
        opreations = [NSMutableDictionary dictionaryWithCapacity:2];
        objc_setAssociatedObject(self, HWControl_key_events, opreations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [opreations removeObjectForKey:methodName];
    [self removeTarget:self action:NSSelectorFromString(methodName) forControlEvents:event];
}

#pragma mark - private
- (void)__hw_controlEventTouchDown{[self __hw_callActionBlock:UIControlEventTouchDown];}
- (void)__hw_controlEventTouchDownRepeat{[self __hw_callActionBlock:UIControlEventTouchDownRepeat];}
- (void)__hw_controlEventTouchDragInside{[self __hw_callActionBlock:UIControlEventTouchDragInside];}
- (void)__hw_controlEventTouchDragOutside{[self __hw_callActionBlock:UIControlEventTouchDragOutside];}
- (void)__hw_controlEventTouchDragEnter{[self __hw_callActionBlock:UIControlEventTouchDragEnter];}
- (void)__hw_controlEventTouchDragExit{[self __hw_callActionBlock:UIControlEventTouchDragExit];}
- (void)__hw_controlEventTouchUpInside{[self __hw_callActionBlock:UIControlEventTouchUpInside];}
- (void)__hw_controlEventTouchUpOutside{[self __hw_callActionBlock:UIControlEventTouchUpOutside];}
- (void)__hw_controlEventTouchCancel{[self __hw_callActionBlock:UIControlEventTouchCancel];}
- (void)__hw_controlEventValueChanged{[self __hw_callActionBlock:UIControlEventValueChanged];}
- (void)__hw_controlEventEditingDidBegin{[self __hw_callActionBlock:UIControlEventEditingDidBegin];}
- (void)__hw_controlEventEditingChanged{[self __hw_callActionBlock:UIControlEventEditingChanged];}
- (void)__hw_controlEventEditingDidEnd{[self __hw_callActionBlock:UIControlEventEditingDidEnd];}
- (void)__hw_controlEventEditingDidEndOnExit{[self __hw_callActionBlock:UIControlEventEditingDidEndOnExit];}
- (void)__hw_controlEventAllTouchEvents{[self __hw_callActionBlock:UIControlEventAllTouchEvents];}
- (void)__hw_controlEventAllEditingEvents{[self __hw_callActionBlock:UIControlEventAllEditingEvents];}
- (void)__hw_controlEventApplicationReserved{[self __hw_callActionBlock:UIControlEventApplicationReserved];}
- (void)__hw_controlEventSystemReserved{[self __hw_callActionBlock:UIControlEventSystemReserved];}
- (void)__hw_controlEventAllEvents{[self __hw_callActionBlock:UIControlEventAllEvents];}

- (void)__hw_callActionBlock:(UIControlEvents)event
{
    NSMutableDictionary *opreations = (NSMutableDictionary *)objc_getAssociatedObject(self, HWControl_key_events);
    
    if(opreations == nil)
        return;
    
    void(^block)(id sender) = [opreations objectForKey:[UIControl __hw_eventName:event]];
    
    block ? block(self) : nil ;
}

+ (NSString *)__hw_eventName:(UIControlEvents)event
{
    static NSDictionary *controlEventStrings = nil;
    
    static dispatch_once_t once;
    dispatch_once( &once, ^{
        controlEventStrings = @{@(UIControlEventTouchDown): @"__hw_controlEventTouchDown",
                                @(UIControlEventTouchDownRepeat): @"__hw_controlEventTouchDownRepeat",
                                @(UIControlEventTouchDragInside): @"__hw_controlEventTouchDragInside",
                                @(UIControlEventTouchDragOutside): @"__hw_controlEventTouchDragOutside",
                                @(UIControlEventTouchDragEnter): @"__hw_controlEventTouchDragEnter",
                                @(UIControlEventTouchDragExit): @"__hw_controlEventTouchDragExit",
                                @(UIControlEventTouchUpInside): @"__hw_controlEventTouchUpInside",
                                @(UIControlEventTouchUpOutside): @"__hw_controlEventTouchUpOutside",
                                @(UIControlEventTouchCancel): @"__hw_controlEventTouchCancel",
                                @(UIControlEventValueChanged): @"__hw_controlEventValueChanged",
                                @(UIControlEventEditingDidBegin): @"__hw_controlEventEditingDidBegin",
                                @(UIControlEventEditingChanged): @"__hw_controlEventEditingChanged",
                                @(UIControlEventEditingDidEnd): @"__hw_controlEventEditingDidEnd",
                                @(UIControlEventEditingDidEndOnExit): @"__hw_controlEventEditingDidEndOnExit",
                                @(UIControlEventAllTouchEvents): @"__hw_controlEventAllTouchEvents",
                                @(UIControlEventAllEditingEvents): @"__hw_controlEventAllEditingEvents",
                                @(UIControlEventApplicationReserved): @"__hw_controlEventApplicationReserved",
                                @(UIControlEventSystemReserved): @"__hw_controlEventSystemReserved",
                                @(UIControlEventAllEvents): @"__hw_controlEventAllEvents"
                                };
    });
    
    return controlEventStrings[@(event)];
}

@end
