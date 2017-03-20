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

#import <UIKit/UIKit.h>

/**
 * 快速设置UILabel的attributedText属性的API，参数中只能使用指定的规则，才可以生效。
 * 使用规则：必须是<style font=18 color=red backgroundcolor=#eee underline=1>中间是描述</style>
 * 目前支持的属性有：font（普通字体）、boldfont（粗体）、color（前景色）、backgroundcolor（背景色）、
 *                underline（下划线，使用【0，9】数字，分别对应NSUnderlineStyle枚举类型的成员的值）
 *                througline （中划线，使用【0，9】数字，分别对应NSUnderlineStyle枚举类型的成员的值）   NSStrikethroughStyleAttributeName
 * 1、对于字体font和boldfont的值只能是数值；
 * 2、color和backgroundcolor的值可以是任何十六进制值，支持0x|0X|#开头，
 *    也支持系统自带的生成颜色的类方法API函数名，如color=red或者color=redcolor
 * 3、underline的值只能是NSUnderlineStyle枚举成员的值，取0到9。
 *
 *
 * @see NSUnderlineStyle
 * @note <style></style>只能是全小写，对于属性名和属性值不区分大小写
 */
@interface UILabel (HwAttributedCategory)

/**
 * 快速设置UILabel的attributedText属性的API，参数中只能使用指定的规则，才可以生效。
 * 使用规则：必须是<style font=18 color=red backgroundcolor=#eee underline=1>中间是描述</style>
 * 目前支持的属性有：font（普通字体）、boldfont（粗体）、color（前景色）、backgroundcolor（背景色）、
 *                underline（下划线，使用【0，9】数字，分别对应NSUnderlineStyle枚举类型的成员的值）
 * 1、对于字体font和boldfont的值只能是数值；
 * 2、color和backgroundcolor的值可以是任何十六进制值，支持0x|0X|#开头，
 *    也支持系统自带的生成颜色的类方法API函数名，如color=red或者color=redcolor
 * 3、underline的值只能是NSUnderlineStyle枚举成员的值，取0到9。
 *
 * @param text 待设置样式的文本内容
 * @note <style></style>只能是全小写，对于属性名和属性值不区分大小写
 *
 * @return YES表示成功设置，NO表示写法有误，且无法过滤，因此无效果。
 */
- (BOOL)hw_setAttributedText:(NSString *)text;

@end
