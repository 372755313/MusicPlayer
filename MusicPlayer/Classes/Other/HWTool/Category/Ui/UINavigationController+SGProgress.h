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

#define kSGProgressTitleChanged @"kSGProgressTitleChanged"
#define kSGProgressOldTitle @"kSGProgressOldTitle"

@interface UINavigationController (SGProgress)

- (void)showSGProgress;
- (void)showSGProgressWithDuration:(float)duration;
- (void)showSGProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor;
- (void)showSGProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title;
- (void)showSGProgressWithMaskAndDuration:(float)duration;
- (void)showSGProgressWithMaskAndDuration:(float)duration andTitle:(NSString *) title;


- (void)setSGProgressPercentage:(float)percentage;
- (void)setSGProgressPercentage:(float)percentage andTitle:(NSString *)title;
- (void)setSGProgressPercentage:(float)percentage andTintColor:(UIColor *)tintColor;
- (void)setSGProgressMaskWithPercentage:(float)percentage;
- (void)setSGProgressMaskWithPercentage:(float)percentage andTitle:(NSString *)title;


- (void)finishSGProgress;
- (void)cancelSGProgress;
@end
