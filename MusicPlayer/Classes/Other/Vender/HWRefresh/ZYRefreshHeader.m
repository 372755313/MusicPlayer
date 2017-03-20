//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ZYRefreshHeader.h"


NSString * const    reImgPathName               = @"refer3";
const NSInteger     reImgNum                    = 4;
NSString * const    reImgType                   = @"png";

@implementation ZYRefreshHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
     NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:reImgPathName ofType:@"bundle"];
    // 设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=reImgNum; i++) {
        NSString *imgPath= [bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",@(i),reImgType]];
        UIImage *image =[UIImage imageWithContentsOfFile:imgPath];
        [refreshingImages addObject:image];
    }
    
    [self setImages:refreshingImages forState:MJRefreshStateIdle];
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
}
@end
