//
//  NAVHeaderBar.m
//  MusicPlayer-B
//
//  Created by lanou on 15/7/9.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import "NAVHeaderBar.h"

@interface NAVHeaderBar ()


@end
@implementation NAVHeaderBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame ])
    {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/7+10, [UIScreen mainScreen].bounds.size.width/7);
        [self.leftButton setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
        [self addSubview:_leftButton];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame =CGRectMake([UIScreen mainScreen].bounds.size.width*6/7+13, [UIScreen mainScreen].bounds.size.width/7/6.7, [UIScreen mainScreen].bounds.size.width/10, [UIScreen mainScreen].bounds.size.width/10);
        [self.rightButton setImage:[UIImage imageNamed:@"fdj.png"] forState:UIControlStateNormal];
        [self addSubview:_rightButton];
        
    }
    return self;
}

@end
