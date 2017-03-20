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

#import "HWKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

void (*HWKVO_action2)(id, SEL, id, id) = (void (*)(id, SEL, id, id))objc_msgSend;
void (*HWKVO_action3)(id, SEL, id, id, id) = (void (*)(id, SEL, id, id, id))objc_msgSend;

typedef enum {
    HWKVOType_new = 1,         // 参数只有new
    HWKVOType_new_old,         // 参数有new,old
}HWKVOType;

#pragma mark - HWKVO
@interface HWKVO ()

@property (nonatomic, assign) HWKVOType type;      // 观察者的类型

@property (nonatomic, weak) id target;                  // 被观察的对象的值改变时后的响应方法所在的对象
@property (nonatomic, assign) SEL selector;             // 被观察的对象的值改变时后的响应方法
@property (nonatomic, copy) HWKVO_block_new_old block;        // 值改变时执行的block

@property (nonatomic, assign) id sourceObject;         // 被观察的对象
@property (nonatomic, copy) NSString *keyPath;        // 被观察的对象的keyPath

- (instancetype)initWithSourceObject:(id)sourceObject keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector type:(HWKVOType)type;

- (instancetype)initWithSourceObject:(id)sourceObject keyPath:(NSString*)keyPath block:(HWKVO_block_new_old)block;

@end

@implementation HWKVO

- (instancetype)initWithSourceObject:(id)sourceObject keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector type:(HWKVOType)type
{
    self = [super init];
    if (self)
    {
        _target       = target;
        _selector     = selector;
        _sourceObject = sourceObject;
        _keyPath      = keyPath;
        _type         = type;
        NSKeyValueObservingOptions options = (_type == HWKVOType_new) ? NSKeyValueObservingOptionNew : (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld);
        [_sourceObject addObserver:self forKeyPath:keyPath options:options context:nil];
    }
    
    return self; 
}

- (instancetype)initWithSourceObject:(id)sourceObject keyPath:(NSString*)keyPath block:(HWKVO_block_new_old)block
{
    self = [super init];
    if (self)
    {
        _sourceObject = sourceObject;
        _keyPath      = keyPath;
        _block        = block;
        [_sourceObject addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    
    return self;
}
- (void)dealloc
{
    //NSLogD(@"%@", _keyPath);
    if (_sourceObject)
        [_sourceObject removeObserver:self forKeyPath:_keyPath];
}

#pragma mark NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (_block)
    {
        _block(change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
        return;
    }
    
    if (_type == HWKVOType_new)
    {
        HWKVO_action2(_target, _selector, _sourceObject, change[NSKeyValueChangeNewKey]);
    }
    else if (_type == HWKVOType_new_old)
    {
        HWKVO_action3(_target, _selector, _sourceObject, change[NSKeyValueChangeNewKey] , change[NSKeyValueChangeOldKey]);
    }
}

@end

#pragma mark - NSObject (HWKVOPrivate)
@interface NSObject (HWKVOPrivate)

- (void)observeWithObject:(id)sourceObject keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector type:(HWKVOType)type;

@end

@implementation NSObject (HWKVO)

hw_staticConstString(NSObject_observers)

- (id)hw_KVO
{
    return objc_getAssociatedObject(self, NSObject_observers) ?: ({
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        objc_setAssociatedObject(self, NSObject_observers, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        dic;
    });
}

- (void)hw_observeWithObject:(id)object property:(NSString*)property
{
    SEL aSel = nil;
    
    aSel = NSSelectorFromString([NSString stringWithFormat:@"__hw_handleKVO_%@_in:new:", property]);
    if ([self respondsToSelector:aSel])
    {
        [self observeWithObject:object
                        keyPath:property
                         target:self
                       selector:aSel
                           type:HWKVOType_new];
        return;
    }
    
    aSel = NSSelectorFromString([NSString stringWithFormat:@"__hw_handleKVO_%@_in:new:old:", property]);
    if ([self respondsToSelector:aSel])
    {
        [self observeWithObject:object
                        keyPath:property
                         target:self
                       selector:aSel
                           type:HWKVOType_new_old];
        return;
    }
}

- (void)hw_observeWithObject:(id)object property:(NSString*)property block:(HWKVO_block_new_old)block
{
    [self observeWithObject:object keyPath:property block:block];
}

- (void)observeWithObject:(id)object keyPath:(NSString*)keyPath target:(id)target selector:(SEL)selector type:(HWKVOType)type
{
    NSAssert([target respondsToSelector:selector], @"selector 必须存在");
    NSAssert(keyPath.length > 0, @"property 必须存在");
    NSAssert(object, @"被观察的对象object 必须存在");
    
    NSString *key = [NSString stringWithFormat:@"%@_%@", object, keyPath];
    HWKVO *ob     = [[HWKVO alloc] initWithSourceObject:object keyPath:keyPath target:target selector:selector type:type];
    
    self.hw_KVO[key] = ob;
}

- (void)observeWithObject:(id)object keyPath:(NSString*)keyPath block:(HWKVO_block_new_old)block
{
    NSAssert(block, @"block 必须存在");
    
    NSString *key = [NSString stringWithFormat:@"%@_%@", object, keyPath];
    HWKVO *ob     = [[HWKVO alloc] initWithSourceObject:object keyPath:keyPath block:block];

    self.hw_KVO[key] = ob;
}

- (void)hw_removeObserverWithObject:(id)object property:(NSString *)property
{
    NSString *key = [NSString stringWithFormat:@"%@_%@", object, property];
    [self.hw_KVO removeObjectForKey:key];
}

- (void)hw_removeObserverWithObject:(id)object
{
    NSString *prefix = [NSString stringWithFormat:@"%@", object];
    [self.hw_KVO enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key hasPrefix:prefix])
        {
            [self.hw_KVO removeObjectForKey:key];
        }
    }];
}

- (void)hw_removeAllObserver
{
    [self.hw_KVO removeAllObjects];
}

@end

                                                            

                                                            
                                                            
                                                            
                                                            
                                                            
