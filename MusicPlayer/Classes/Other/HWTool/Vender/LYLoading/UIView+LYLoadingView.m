//
//  UIView+LYLoadingView.m
//  Finance
//
//  Created by LYoung on 15/8/12.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "UIView+LYLoadingView.h"
#import "LYLoadingLabel.h"
#import "LYActivityView.h"

#define WarmLabelWidth 60
#define WaemLabelHeight 20
#define ActivityViewWidth 85
#define SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)
#define ActivityX ((SCREEN_WIDTH - ActivityViewWidth)/2)//UIActivityIndicatorViewX frame
#define WarmLabelX (ActivityX + 25)//label Frame


@implementation UIView (LYLoadingView)


-(void)initActivitytitle:(NSString *)title{
    [LYActivityView shareActivityView].center = CGPointMake(CGRectGetMidX(self.frame) - WarmLabelWidth/2, CGRectGetMidY(self.frame));

    [[LYActivityView shareActivityView] startAnimating];
    [self addSubview:[LYActivityView shareActivityView]];
    
    [LYLoadingLabel shareLoadingLabel].frame = CGRectMake(WarmLabelX, (self.frame.size.height - WaemLabelHeight)/2, WarmLabelWidth, WaemLabelHeight);
    [LYLoadingLabel shareLoadingLabel].text = title;
    [LYLoadingLabel shareLoadingLabel].hidden = NO;
    [self addSubview:[LYLoadingLabel shareLoadingLabel]];
}


-(void)showLoadingViewWithText:(NSString *)text{

    [self initActivitytitle:text];
}
-(void)dismissLoadingView{
    [self stopAnimating];
}

-(void)stopAnimating{
    [LYLoadingLabel shareLoadingLabel].hidden = YES;
    [[LYActivityView shareActivityView] stopAnimating];
    [LYLoadingLabel shareLoadingLabel].text = nil;
}

@end
