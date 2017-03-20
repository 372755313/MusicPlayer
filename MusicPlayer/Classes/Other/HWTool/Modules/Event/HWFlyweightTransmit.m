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

#import "HWFlyweightTransmit.h"
#import <objc/message.h>
#pragma mark - hwFlyweightTransmit

@implementation NSObject (hwFlyweightTransmit)

hw_staticConstString(NSObject_key_flyweightData)
- (id)hw_flyweightData
{
    return objc_getAssociatedObject(self, NSObject_key_flyweightData);
}

- (void)sethw_flyweightData:(id)hw_flyweightData
{
    [self willChangeValueForKey:@"hw_flyweightData"];
    objc_setAssociatedObject(self, NSObject_key_flyweightData, hw_flyweightData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"hw_flyweightData"];
}

hw_staticConstString(NSObject_key_objectDic)
- (void)hw_receiveObject:(void(^)(id object))aBlock withIdentifier:(NSString *)identifier
{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, NSObject_key_objectDic) ?: ({
        NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithCapacity:4];
        objc_setAssociatedObject(self, NSObject_key_objectDic, tmpDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        tmpDic;
    });
    
    dic[identifier ?: @"hw_sendObject"] = [aBlock copy];
}

- (void)hw_sendObject:(id)anObject withIdentifier:(NSString *)identifier
{
    NSDictionary *dic = objc_getAssociatedObject(self, NSObject_key_objectDic);
    if (dic == nil) return;
    
    void(^aBlock)(id anObject) = dic[identifier ?: @"hw_sendObject"];
    aBlock(anObject);
}

hw_staticConstString(NSObject_key_eventBlockDic)
- (void)hw_handlerEventWithBlock:(id)aBlock withIdentifier:(NSString *)identifier
{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, NSObject_key_eventBlockDic) ?: ({
        NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithCapacity:4];
        objc_setAssociatedObject(self, NSObject_key_eventBlockDic, tmpDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        tmpDic;
    });
    
    dic[identifier ?: @"hw_handlerEvent"] = [aBlock copy];
}

- (id)hw_blockForEventWithIdentifier:(NSString *)identifier
{
    NSDictionary *dic = objc_getAssociatedObject(self, NSObject_key_eventBlockDic);
    if(dic == nil) return nil;
    
    return dic[identifier ?: @"hw_handlerEvent"];
}

@end;