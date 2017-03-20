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
#import "HWCacheProtocol.h"
#pragma mark -

#define HWFileCache_fileExpires  (7 * 24 * 60 * 60)

@interface HWFileCache : NSObject <HWCacheProtocol>

/// 路径
@property (nonatomic, copy, readonly) NSString *diskCachePath;

/// The maximum size of the cache, in bytes
@property (assign, nonatomic) NSUInteger maxCacheSize;
/// 有效期, 默认1周
@property (nonatomic, assign) NSTimeInterval maxCacheAge;

+ (instancetype)sharedInstance;

/// 用新路径建立一个cache
- (id)initWithNamespace:(NSString *)ns;

/// 返回key对应的文件名
- (NSString *)fileNameForKey:(NSString *)key;
/// 返回类文件
- (id)objectForKey:(NSString *)key objectClass:(Class)aClass;

/// 清除当前 diskCachePath 所有的文件
- (void)clearDisk;

/// 清除当前 diskCachePath 所有的文件
- (void)clearDiskOnCompletion:(void(^)(void))completion;

/// 清除当前 diskCachePath 所有过期的文件
- (void)cleanDisk;

/// 清除当前 diskCachePath 所有过期的文件
- (void)cleanDiskWithCompletionBlock:(void(^)(void))completionBlock;

/// 返回cache 大小
- (NSUInteger)getSize;

/// 返回cache 数量
- (NSUInteger)getDiskCount;

#pragma mark - HWCacheProtocol 协议里的方法
- (BOOL)hasObjectForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

@end
