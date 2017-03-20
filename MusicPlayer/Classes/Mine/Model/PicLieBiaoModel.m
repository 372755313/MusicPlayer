//
//  PicLieBiaoModel.m
//  MusicPlayer-B
//
//  Created by lanou on 15/7/21.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import "PicLieBiaoModel.h"
#import "UIImageView+WebCache.h"
@implementation PicLieBiaoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"---key--%@",key);
    if ([key isEqualToString:@"id"])
    {
        _ID = value;
    }
}


@end
