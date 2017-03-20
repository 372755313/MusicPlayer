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

#import "HWUserDefaults.h"

@implementation HWUserDefaults

static id __singleton__objc__token;
static dispatch_once_t __singleton__token__token;
+ (instancetype)sharedInstance
{
    dispatch_once(&__singleton__token__token, ^{ __singleton__objc__token = [[self alloc] init]; });
    return __singleton__objc__token;
}

+ (void)purgeSharedInstance
{
    __singleton__objc__token  = nil;
    __singleton__token__token = 0;
}

- (BOOL)hasObjectForKey:(id)key
{
	id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
	return value ? YES : NO;
}

- (id)objectForKey:(NSString *)key
{
	if ( nil == key )
		return nil;
	
	id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
	return value;
}

- (void)setObject:(id)value forKey:(NSString *)key
{
	if ( nil == key || nil == value )
		return;
    
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeObjectForKey:(NSString *)key
{
	if ( nil == key )
		return;
	
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAllObjects
{
	[NSUserDefaults resetStandardUserDefaults];
}

- (id)objectForKeyedSubscript:(id)key
{
	return [self objectForKey:key];
}

@end

@implementation NSObject(HWUserDefaults)

+ (NSString *)persistenceKey:(NSString *)key
{
	if ( key )
	{
		key = [NSString stringWithFormat:@"%@.%@", [self description], key];
	}
	else
	{
		key = [NSString stringWithFormat:@"%@", [self description]];
	}
	
	key = [key stringByReplacingOccurrencesOfString:@"." withString:@"_"];
	key = [key stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
	key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	
	return key.uppercaseString;
}

+ (id)userDefaultsRead:(NSString *)key
{
	if ( nil == key )
		return nil;
    
	key = [self persistenceKey:key];
	
	return [[HWUserDefaults sharedInstance] objectForKey:key];
}

+ (void)userDefaultsWrite:(id)value forKey:(NSString *)key
{
	if ( nil == key || nil == value )
		return;
	
	key = [self persistenceKey:key];
	
	[[HWUserDefaults sharedInstance] setObject:value forKey:key];
}

+ (void)userDefaultsRemove:(NSString *)key
{
	if ( nil == key )
		return;
    
	key = [self persistenceKey:key];
	
	[[HWUserDefaults sharedInstance] removeObjectForKey:key];
}

- (id)userDefaultsRead:(NSString *)key
{
	return [[self class] userDefaultsRead:key];
}

- (void)userDefaultsWrite:(id)value forKey:(NSString *)key
{
	[[self class] userDefaultsWrite:value forKey:key];
}

- (void)userDefaultsRemove:(NSString *)key
{
	[[self class] userDefaultsRemove:key];
}

+ (id)readObject
{
	return [self readObjectForKey:nil];
}

+ (id)readObjectForKey:(NSString *)key
{
	key = [self persistenceKey:key];
	
	id value = [[HWUserDefaults sharedInstance] objectForKey:key];
	if ( value )
	{
		//return [self objectFromAny:value];
        return value;
	}
    
	return nil;
}

+ (void)saveObject:(id)obj
{
	[self saveObject:obj forKey:nil];
}

+ (void)saveObject:(id)obj forKey:(NSString *)key
{
	if ( nil == obj )
		return;
	
	key = [self persistenceKey:key];
	/*
	NSString * value = [obj objectToString];
	if ( value && value.length )
	{
		[[HWUserDefaults sharedInstance] setObject:value forKey:key];
	}
	else
	{
		[[HWUserDefaults sharedInstance] removeObjectForKey:key];
	}
     */
    if (obj) {
        [[HWUserDefaults sharedInstance] setObject:obj forKey:key];
    }else {
        [[HWUserDefaults sharedInstance] removeObjectForKey:key];
    }
}

+ (void)removeObject
{
	[self removeObjectForKey:nil];
}

+ (void)removeObjectForKey:(NSString *)key
{
	key = [self persistenceKey:key];
    
	[[HWUserDefaults sharedInstance] removeObjectForKey:key];
}

@end

