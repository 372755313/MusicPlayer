//
//  HWImageTool.m
//  tg
//
//  Created by skywakerwei on 14/12/16.
//  Copyright (c) 2014年 skywakerwei. All rights reserved.
//

#import "HWImageTool.h"
#import "UIImageView+WebCache.h"
@implementation HWImageTool

+ (void)clear
{
    // 1.清除内存中的缓存图片
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 2.取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}


@end
