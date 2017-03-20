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

#import "NSObject+Hw.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Hw)

@dynamic hw_attributeList;

#pragma mark - hook

#pragma mark - perform

#pragma mark - property
- (NSArray *)hw_attributeList
{
    unsigned int propertyCount = 0;
    objc_property_t*properties = class_copyPropertyList( [self class], &propertyCount );
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *name = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        //   const char *attr = property_getAttributes(properties[i]);
        // NSLogD(@"%@, %s", propertyName, attr);
        [array addObject:propertyName];
    }
    free( properties );
    
    return array;
}

#pragma mark - Conversion
- (NSInteger)hw_asInteger
{
	return [[self hw_asNSNumber] integerValue];
}

- (float)hw_asFloat
{
	return [[self hw_asNSNumber] floatValue];
}

- (BOOL)hw_asBool
{
	return [[self hw_asNSNumber] boolValue];
}

- (NSNumber *)hw_asNSNumber
{
	if ( [self isKindOfClass:[NSNumber class]] )
	{
		return (NSNumber *)self;
	}
    else if ( [self isKindOfClass:[NSNull class]] )
    {
        return [NSNumber numberWithInteger:0];
    }
	else if ( [self isKindOfClass:[NSString class]] )
	{
		return [NSNumber numberWithInteger:[(NSString *)self integerValue]];
	}
	else if ( [self isKindOfClass:[NSDate class]] )
	{
		return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
	}

    
	return nil;
}

- (NSString *)hw_asNSString
{
    if ( [self isKindOfClass:[NSString class]] )
    {
        return (NSString *)self;
    }
    else if ( [self isKindOfClass:[NSNull class]] )
    {
        return nil;
    }
	else if ( [self isKindOfClass:[NSData class]] )
	{
		NSData * data = (NSData *)self;
		return [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
	}
	else
	{
		return [NSString stringWithFormat:@"%@", self];
	}
}


- (NSData *)hw_asNSData
{
    if ( [self isKindOfClass:[NSData class]] )
    {
        return (NSData *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
	{
		return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	}

	return nil;
}

- (NSArray *)hw_asNSArray
{
	if ( [self isKindOfClass:[NSArray class]] )
	{
		return (NSArray *)self;
	}
	else
	{
		return [NSArray arrayWithObject:self];
	}
}

#pragma mark- copy
- (id)hw_deepCopy1
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}


@end

@implementation NSObject (Hw_associated)
- (id)hw_getAssociatedObjectForKey:(const char *)key
{
    return objc_getAssociatedObject( self, key );
}

- (void)hw_setCopyAssociatedObject:(id)obj forKey:(const char *)key
{
    objc_setAssociatedObject( self, key, obj, OBJC_ASSOCIATION_COPY );
}

- (void)hw_setRetainAssociatedObject:(id)obj forKey:(const char *)key;
{
    objc_setAssociatedObject( self, key, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

- (void)hw_setAssignAssociatedObject:(id)obj forKey:(const char *)key
{
    objc_setAssociatedObject( self, key, obj, OBJC_ASSOCIATION_ASSIGN );
}

- (void)hw_removeAssociatedObjectForKey:(const char *)key
{
    objc_setAssociatedObject( self, key, nil, OBJC_ASSOCIATION_ASSIGN );
}

- (void)hw_removeAllAssociatedObjects
{
    objc_removeAssociatedObjects( self );
}

@end





