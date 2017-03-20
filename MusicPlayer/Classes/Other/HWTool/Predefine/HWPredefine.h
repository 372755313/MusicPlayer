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
//

#ifndef __HW_PREDEFINE_H__
#define __HW_PREDEFINE_H__

// 1.判断是否为iOS7以上
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8  __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
// 2.获得RGB颜色
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HWColorA(r, g, b,c) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:c]

//根据16进制数设置颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#define DLog(fmt, ...) NSLog((@"[文件:%s]\n" "[函数:%s]\n" "[行:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)
//
#define isIphone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define isIphone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define isIphone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define isIphone6p ([UIScreen mainScreen].bounds.size.height == 736)
//5.常用字体
#define HW_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;

#define HW_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

//6.常用目录
#define kDirDoc ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject])
#define kDirCache ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject])

//常用
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight  [UIScreen mainScreen].bounds.size.height
#define KHeightS   ([UIScreen mainScreen].bounds.size.height-64)
#define KHeightL  ([UIScreen mainScreen].bounds.size.height-64-49)
#define KMainScreen  [UIScreen mainScreen].bounds
#define KAppliactionFrame  [[UIApplication sharedApplication] statusBarFrame]

#define KQueueGlobal dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define KQueueMain dispatch_get_main_queue()


//单
// ----------------------------------
// Code block
// ----------------------------------
// 单例模式
#define HWSINGLETON
static id sharedInstance;
#define hw_as_singleton    \
+ (instancetype)sharedInstance; \
+ (void)purgeSharedInstance;

#define hw_def_singleton( __token) \
static id __singleton__objc__##__token;                     \
static dispatch_once_t __singleton__token__##__token;       \
+ (instancetype)sharedInstance \
{ \
dispatch_once( &__singleton__token__##__token, ^{ __singleton__objc__##__token = [[self alloc] init]; } ); \
return __singleton__objc__##__token; \
}   \
+ (void)purgeSharedInstance \
{   \
__singleton__objc__##__token = nil;    \
__singleton__token__##__token = 0; \
}


// 定义静态常量字符串
#define hw_staticConstString(__string)               static const char * __string = #__string;



#endif








