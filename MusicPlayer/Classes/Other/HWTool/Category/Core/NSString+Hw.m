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

#import "NSString+Hw.h"

@implementation NSString (Hw)
/**
 *  快速计算出文本的真实尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
- (CGSize)hw_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *arrts = @{NSFontAttributeName:font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}

/**
 *  快速计算出文本的真实尺寸
 *
 *  @param text    需要计算尺寸的文本
 *  @param font    文字的字体
 *  @param maxSize 文本的最大尺寸
 *
 *  @return 快速计算出文本的真实尺寸
 */
+ (CGSize)hw_sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    return [text hw_sizeWithFont:font andMaxSize:maxSize];
}


- (BOOL)email
{
    NSString *emailEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)weakPswd
{
    NSString *pswdEx =
    @"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,20}$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pswdEx];
    return [regExPredicate evaluateWithObject:self];
}
- (BOOL)emptyOrWhitespace
{
    return self == nil || !([self length] > 0) || [[self trimmedString] length] == 0 || [self isKindOfClass:[NSNull class]];
}

- (NSString *)trimmedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimmedWhitespaceAndNewlineString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)telephone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * cm = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * cu = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * ct = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * phs = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regexmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regexcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
    NSPredicate *regexcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
    NSPredicate *regexct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
    NSPredicate *regexphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phs];
    
    return  [regexmobile evaluateWithObject:self]   ||
    [regexphs evaluateWithObject:self]      ||
    [regexct evaluateWithObject:self]       ||
    [regexcu evaluateWithObject:self]       ||
    [regexcm evaluateWithObject:self];
}


- (BOOL)hw_isNum
{
    unichar c;
    NSString *str =  [self trimmedString];
    for (NSInteger i=0; i<str.length; i++) {
        c=[str characterAtIndex:i];
        if (!isdigit(c)) {
            return YES;
        }
    }
    return NO;
   
}





@end
