//
//  HWAlertView.h
//  HWAlertView
//
//  Created by Kevin Cao on 13-4-29.
//  Copyright (c) 2013年 Sumi Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
//第三方提示
extern NSString *const HWAlertViewWillShowNotification;
extern NSString *const HWAlertViewDidShowNotification;
extern NSString *const HWAlertViewWillDismissNotification;
extern NSString *const HWAlertViewDidDismissNotification;

typedef NS_ENUM(NSInteger, HWAlertViewButtonType) {
    HWAlertViewButtonTypeDefault = 0,
    HWAlertViewButtonTypeDestructive,
    HWAlertViewButtonTypeCancel
};

typedef NS_ENUM(NSInteger, HWAlertViewBackgroundStyle) {
    HWAlertViewBackgroundStyleGradient = 0,
    HWAlertViewBackgroundStyleSolid,
};

typedef NS_ENUM(NSInteger, HWAlertViewButtonsListStyle) {
    HWAlertViewButtonsListStyleNormal = 0,
    HWAlertViewButtonsListStyleRows
};

typedef NS_ENUM(NSInteger, HWAlertViewTransitionStyle) {
    HWAlertViewTransitionStyleSlideFromBottom = 0,
    HWAlertViewTransitionStyleSlideFromTop,
    HWAlertViewTransitionStyleFade,
    HWAlertViewTransitionStyleBounce,
    HWAlertViewTransitionStyleDropDown
};

@class HWAlertView;
typedef void(^HWAlertViewHandler)(HWAlertView *alertView);

@interface HWAlertView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) HWAlertViewTransitionStyle transitionStyle; // default is HWAlertViewTransitionStyleSlideFromBottom
@property (nonatomic, assign) HWAlertViewBackgroundStyle backgroundStyle; // default is HWAlertViewBackgroundStyleGradient
@property (nonatomic, assign) HWAlertViewButtonsListStyle buttonsListStyle; // default is HWAlertViewButtonsListStyleNormal

@property (nonatomic, copy) HWAlertViewHandler willShowHandler;
@property (nonatomic, copy) HWAlertViewHandler didShowHandler;
@property (nonatomic, copy) HWAlertViewHandler willDismissHandler;
@property (nonatomic, copy) HWAlertViewHandler didDismissHandler;

@property (nonatomic, readonly, getter = isVisible) BOOL visible;

@property (nonatomic, readonly, getter = isParallaxEffectEnabled) BOOL enabledParallaxEffect;

@property (nonatomic, strong) UIColor *viewBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *messageFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *buttonFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *buttonColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *cancelButtonColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *destructiveButtonColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 2.0
@property (nonatomic, assign) CGFloat shadowRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 8.0

- (void)setDefaultButtonImage:(UIImage *)defaultButtonImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (void)setCancelButtonImage:(UIImage *)cancelButtonImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (void)setDestructiveButtonImage:(UIImage *)destructiveButtonImage forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)addButtonWithTitle:(NSString *)title type:(HWAlertViewButtonType)type handler:(HWAlertViewHandler)handler;

- (void)show;
- (void)dismissAnimated:(BOOL)animated;

@end
