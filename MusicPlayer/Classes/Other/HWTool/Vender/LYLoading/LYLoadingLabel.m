//
//  LYLoadingLabel.m
//  Finance
//
//  Created by LYoung on 15/8/12.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#import "LYLoadingLabel.h"

static LYLoadingLabel *_loadingLabel = nil;
@implementation LYLoadingLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(LYLoadingLabel *)shareLoadingLabel{
    if (!_loadingLabel) {
        _loadingLabel = [[LYLoadingLabel alloc] init];
        _loadingLabel.font = [UIFont systemFontOfSize:14.0];
        _loadingLabel.backgroundColor = [UIColor clearColor];        
    }
    return _loadingLabel;
}

@end
