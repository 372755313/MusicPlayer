//
//  UIView+LYLoadingView.h
//  Finance
//
//  Created by LYoung on 15/8/12.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYLoadingView)
/**
 *  显示加载视图
 *
 *  @param text 加载文字
 */
-(void)showLoadingViewWithText:(NSString *)text;

/**
 *  加载视图消失
 */
-(void)dismissLoadingView;

@end
