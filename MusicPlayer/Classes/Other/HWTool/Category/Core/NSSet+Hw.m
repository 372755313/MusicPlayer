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

#import "NSSet+Hw.h"

static const void *__HWRetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
static void __HWReleaseNoOp(CFAllocatorRef allocator, const void *value) { }

@implementation NSSet (Hw)

+ (NSMutableSet *)hw_nonRetainSet
{
    CFSetCallBacks callbacks = kCFTypeSetCallBacks;
    callbacks.retain         = __HWRetainNoOp;
    callbacks.release        = __HWReleaseNoOp;
    
    return  (__bridge_transfer NSMutableSet*)CFSetCreateMutable(nil, 0, &callbacks);
}


@end

@implementation NSMutableSet (Hw)

- (void)hw_safeAddObject:(id)object
{
    if (object)
    {
        [self addObject:object];
    }
}

- (void)hw_safeRemoveObject:(id)object
{
    if (object)
    {
        [self removeObject:object];
    }
}

@end



