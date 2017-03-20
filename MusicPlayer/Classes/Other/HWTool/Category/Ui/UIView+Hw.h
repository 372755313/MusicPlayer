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
#pragma mark -



typedef void(^UIViewCategoryNormalBlock)(UIView *view);
typedef void(^UIViewCategoryAnimationBlock)(void);

@interface UIView (hw)

// 增加手势
- (void)hw_addTapGestureWithTarget:(id)target action:(SEL)action;
- (void)hw_addTapGestureWithBlock:(UIViewCategoryNormalBlock)aBlock;
- (void)hw_removeTapGesture;

- (void)hw_addLongPressGestureWithBlock:(UIViewCategoryNormalBlock)aBlock;
- (void)hw_removeLongPressGesture;




// 增加背景阴影
- (void)hw_addShadeWithTarget:(id)target action:(SEL)action color:(UIColor *)aColor alpha:(float)aAlpha;
- (void)hw_addShadeWithBlock:(UIViewCategoryNormalBlock)aBlock color:(UIColor *)aColor alpha:(float)aAlpha;


- (void)hw_removeShade;
- (UIView *)hw_shadeView;

// 设置背景
- (instancetype)hw_bg:(NSString *)str;

// 旋转 1.0:顺时针180度
- (instancetype)hw_rotate:(CGFloat)angle;

// 圆形
- (instancetype)hw_rounded;
- (instancetype)hw_rounded2;
// 圆角矩形, corners:一个矩形的四个角。
- (instancetype)hw_roundedRectWith:(CGFloat)radius;
- (instancetype)hw_roundedRectWith:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;

// 边框大小,颜色
- (instancetype)hw_borderWidth:(CGFloat)width color:(UIColor *)color;

// 活动指示器
- (UIActivityIndicatorView *)hw_activityIndicatorViewShow;
- (void)hw_activityIndicatorViewHidden;

// 截屏
- (UIImage *)hw_snapshot;

// 淡出,然后移除
- (void)hw_removeFromSuperviewWithCrossfade;

- (void)hw_removeAllSubviews;
- (void)hw_removeSubviewWithTag:(NSInteger)tag;
- (void)hw_removeSubviewExceptTag:(NSInteger)tag;

// 是否显示在屏幕上
- (BOOL)hw_isDisplayedInScreen;

#pragma mark -todo attribute
- (void)hw_showDataWithDic:(NSDictionary *)dic;

#pragma mark - animation
// 淡入淡出
- (void)hw_animationCrossfadeWithDuration:(NSTimeInterval)duration;
- (void)hw_animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion;

/** 立方体翻转
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void)hw_animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void)hw_animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/** 翻转
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void)hw_animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void)hw_animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

/** 覆盖
 *kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom
 */
- (void)hw_animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction;
- (void)hw_animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion;

// 抖动
- (void)hw_animationShake;

// 返回所在的vc
- (UIViewController *)hw_currentViewController;

@end






