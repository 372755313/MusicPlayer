//
//  LYActivityView.m
//  Finance
//
//  Created by LYoung on 15/8/12.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "LYActivityView.h"

static LYActivityView *_activityView = nil;
@implementation LYActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(LYActivityView *)shareActivityView{
    if (!_activityView) {
        _activityView = [[LYActivityView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
