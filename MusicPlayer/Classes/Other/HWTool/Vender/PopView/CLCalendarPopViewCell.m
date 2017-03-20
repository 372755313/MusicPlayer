//
//  CLCalendarPopViewCell.m
//  popupView
//
//  Created by sethmedia on 16/8/27.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLCalendarPopViewCell.h"

@implementation CLCalendarPopViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:_contentLabel];
        
        _contentLabel.backgroundColor = [UIColor whiteColor];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}


@end
