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


#import "UIView+Hw.h"
#import <objc/runtime.h>
#import "HWPredefine.h"
#import "UIImage+Hw.h"

#define UIView_shadeTag                 26601
#define UIView_activityIndicatorViewTag 26602
#define UIView_animation_instant        0.15

@implementation UIView (hw)

- (void)hw_addTapGestureWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (void)hw_removeTapGesture
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers)
    {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]])
        {
            [self removeGestureRecognizer:gesture];
        }
    }
}

hw_staticConstString(UIView_key_tapBlock)

- (void)hw_addTapGestureWithBlock:(UIViewCategoryNormalBlock)aBlock
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, UIView_key_tapBlock, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)actionTap
{
    UIViewCategoryNormalBlock block = objc_getAssociatedObject(self, UIView_key_tapBlock);
    
    block ? block(self) : nil;
}

hw_staticConstString(UIView_key_longPressBlock)

- (void)hw_addLongPressGestureWithBlock:(UIViewCategoryNormalBlock)aBlock
{
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionLongPress)];
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, UIView_key_longPressBlock, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)hw_removeLongPressGesture
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers)
    {
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]])
        {
            [self removeGestureRecognizer:gesture];
        }
    }
}

- (void)actionLongPress
{
    UIViewCategoryNormalBlock block = objc_getAssociatedObject(self, UIView_key_tapBlock);
    
    block ? block(self) : nil;
}
/////////////////////////////////////////////////////////////
- (void)hw_addShadeWithTarget:(id)target action:(SEL)action color:(UIColor *)aColor alpha:(float)aAlpha
{
    UIView *tmpView = [self hw_shadeView];
    tmpView.backgroundColor = aColor ?: [UIColor blackColor];

    tmpView.alpha = aAlpha;
    [self addSubview:tmpView];
    
    [tmpView hw_addTapGestureWithTarget:target action:action];
}
- (void)hw_addShadeWithBlock:(UIViewCategoryNormalBlock)aBlock color:(UIColor *)aColor alpha:(float)aAlpha
{
    UIView *tmpView = [self hw_shadeView];
    tmpView.backgroundColor = aColor ?: [UIColor blackColor];

    tmpView.alpha = aAlpha;
    [self addSubview:tmpView];
    
    if (aBlock)
    {
        [tmpView hw_addTapGestureWithBlock:aBlock];
    }
}

- (void)hw_removeShade
{
    UIView *view = [self viewWithTag:UIView_shadeTag];
    if (!view)
        return;
    
    [UIView animateWithDuration:UIView_animation_instant delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

- (UIView *)hw_shadeView
{
    UIView *view = [self viewWithTag:UIView_shadeTag];
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:self.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.tag = UIView_shadeTag;
    }
    
    return view;
}



/////////////////////////////////////////////////////////////
- (instancetype)hw_bg:(NSString *)str
{
    UIImage *image = [UIImage imageNamed:str];
    self.layer.contents = (id) image.CGImage;
    
    return self;
}

- (instancetype)hw_rounded
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width / 2;
    
    return self;
}

- (instancetype)hw_rounded2
{
    CAShapeLayer *aCircle = [CAShapeLayer layer];
    aCircle.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.height/2].CGPath;
    aCircle.fillColor = [UIColor blackColor].CGColor;
    self.layer.mask = aCircle;
    
    return self;
}

- (instancetype)hw_roundedRectWith:(CGFloat)radius{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    
    return self;
}
- (instancetype)hw_roundedRectWith:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    return self;
}

- (instancetype)hw_borderWidth:(CGFloat)width color:(UIColor *)color
{
    self.layer.borderWidth = width;
    if (color)
    {
        self.layer.borderColor = color.CGColor;
    }
    
    return self;
}
/////////////////////////////////////////////////////////////
- (UIActivityIndicatorView *)hw_activityIndicatorViewShow
{
    UIActivityIndicatorView *aView = (UIActivityIndicatorView *)[self viewWithTag:UIView_activityIndicatorViewTag];
    if (aView == nil)
    {
        aView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        aView.center = CGPointMake(self.bounds.size.width * .5, self.bounds.size.height * .5);
        aView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        aView.tag = UIView_activityIndicatorViewTag;
    }
    
    [self addSubview:aView];
    [aView startAnimating];
    
    aView.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        aView.alpha = 1;
    }];
    
    return aView;
}

- (void)hw_activityIndicatorViewHidden
{
    UIActivityIndicatorView *aView = (UIActivityIndicatorView *)[self viewWithTag:UIView_activityIndicatorViewTag];
    if (!aView)
        return;
    
    [aView stopAnimating];
    aView.alpha = 1;
    
    [UIView animateWithDuration:.35 animations:^{
        aView.alpha = 0;
    } completion:^(BOOL finished) {
        [aView removeFromSuperview];
    }];
}
/////////////////////////////////////////////////////////////
- (UIImage *)hw_snapshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        // 这个方法比ios6下的快15倍
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (instancetype)hw_rotate:(CGFloat)angle
{
    self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI * angle);
    
    return self;
}


- (void)hw_showDataWithDic:(NSDictionary *)dic
{
    if (!dic) return;
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        id tempObj = [self valueForKeyPath:key];
        if ([tempObj isKindOfClass:[UILabel class]])
        {
            NSString *str = obj;
            [tempObj setText:str];
        }
        else if([tempObj isKindOfClass:[UIImageView class]])
        {
            if ([obj isKindOfClass:[UIImage class]])
            {
                [tempObj setImage:obj];
            }
            else if ([obj isKindOfClass:[NSString class]])
            {
                UIImage *tempImg = [UIImage imageNamed:obj];
                [tempObj setImage:tempImg];
            }
        }
        else
        {
            [self setValue:obj forKeyPath:key];
        }
        
    }];
}

- (void)hw_removeFromSuperviewWithCrossfade
{
    self.alpha = 0;
    
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = .3;
    [self.layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.3];
}

- (void)hw_removeAllSubviews
{
    for (UIView *temp in self.subviews)
    {
        [temp removeFromSuperview];
    }
}

- (void)hw_removeSubviewWithTag:(NSInteger)tag
{
    for (UIView *temp in self.subviews)
    {
        if (temp.tag == tag)
        {
            [temp removeFromSuperview];
        }
    }
}

- (void)hw_removeSubviewExceptTag:(NSInteger)tag
{
    for (UIView *temp in self.subviews)
    {
        if (temp.tag != tag)
        {
            [temp removeFromSuperview];
        }
    }
}

- (BOOL)hw_isDisplayedInScreen
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect))
        return FALSE;
    
    // 若view 隐藏
    if (self.hidden)
        return FALSE;
    
    // 若没有superview
    if (self.superview == nil)
        return FALSE;
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero))
        return  FALSE;
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect))
        return FALSE;
    
    return YES;
}

#pragma mark - animation
- (void)hw_animationCrossfadeWithDuration:(NSTimeInterval)duration
{
    //jump through a few hoops to avoid QuartzCore framework dependency
    CAAnimation *animation = [NSClassFromString(@"CATransition") animation];
    [animation setValue:@"kCATransitionFade" forKey:@"type"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)hw_animationCrossfadeWithDuration:(NSTimeInterval)duration completion:(UIViewCategoryAnimationBlock)completion
{
    [self hw_animationCrossfadeWithDuration:duration];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void)hw_animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction
{
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:@"cube"];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void)hw_animationCubeWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion
{
    [self hw_animationCubeWithDuration:duration direction:direction];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void)hw_animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction
{
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:@"oglFlip"];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void)hw_animationOglFlipWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(void (^)(void))completion
{
    [self hw_animationOglFlipWithDuration:duration direction:direction];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void)hw_animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction
{
    CATransition *transtion = [CATransition animation];
    transtion.duration = duration;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transtion setType:kCATransitionMoveIn];
    [transtion setSubtype:direction];
    [self.layer addAnimation:transtion forKey:@"transtionKey"];
}

- (void)hw_animationMoveInWithDuration:(NSTimeInterval)duration direction:(NSString *)direction completion:(UIViewCategoryAnimationBlock)completion
{
    [self hw_animationMoveInWithDuration:duration direction:direction];
    if (completion)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), completion);
    }
}

- (void)hw_animationShake
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue    = [NSNumber numberWithFloat:-0.1];
    shake.toValue      = [NSNumber numberWithFloat:+0.1];
    shake.duration     = 0.06;
    shake.autoreverses = YES;//是否重复
    shake.repeatCount  = 3;
    [self.layer addAnimation:shake forKey:@"HWShake"];
}

- (UIViewController *)hw_currentViewController
{
    id viewController = [self nextResponder];
    UIView *view      = self;
    
    while (viewController && ![viewController isKindOfClass:[UIViewController class]])
    {
        view           = [view superview];
        viewController = [view nextResponder];
    }
    
    return viewController;
}

@end


