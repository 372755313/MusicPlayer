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

typedef NSMutableArray *	(^NSArrayAppendBlock)( id obj );
typedef NSMutableArray *	(^NSMutableArrayAppendBlock)( id obj );

#pragma mark -

@interface NSArray(Hw)

- (NSArray *)hw_head:(NSUInteger)count;
- (NSArray *)hw_tail:(NSUInteger)count;

- (id)hw_safeObjectAtIndex:(NSInteger)index;
- (NSArray *)hw_safeSubarrayWithRange:(NSRange)range;
- (NSArray *)hw_safeSubarrayFromIndex:(NSUInteger)index;
- (NSArray *)hw_safeSubarrayWithCount:(NSUInteger)count;

- (NSInteger)hw_indexOfString:(NSString *)string;

@end

#pragma mark -

@interface NSMutableArray(Hw)

- (void)hw_safeAddObject:(id)anObject;

+ (NSMutableArray *)hw_nonRetainingArray;

- (NSMutableArray *)hw_pushHead:(NSObject *)obj;
- (NSMutableArray *)hw_pushHeadN:(NSArray *)all;
- (NSMutableArray *)hw_popTail;
- (NSMutableArray *)hw_popTailN:(NSUInteger)n;

- (NSMutableArray *)hw_pushTail:(NSObject *)obj;
- (NSMutableArray *)hw_pushTailN:(NSArray *)all;
- (NSMutableArray *)hw_popHead;
- (NSMutableArray *)hw_popHeadN:(NSUInteger)n;

- (NSMutableArray *)hw_keepHead:(NSUInteger)n;
- (NSMutableArray *)hw_keepTail:(NSUInteger)n;

@end
