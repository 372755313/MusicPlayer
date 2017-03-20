//
//  PicLieBiaoModel.h
//  MusicPlayer-B
//
//  Created by lanou on 15/7/21.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PicLieBiaoModel : NSObject
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *amd5;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *sort;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;

@property (nonatomic,strong) UIImage *image;
@end
