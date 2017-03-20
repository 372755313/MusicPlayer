//
//  SSongModel.h
//  MusicPlayer-B
//
//  Created by lanou on 15/7/11.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSongModel : NSObject

@property(nonatomic,strong)NSString *album_id;
@property(nonatomic,strong)NSString *album_name;

@property(nonatomic,strong)NSString *pick_count;
@property(nonatomic,strong)NSString *singer_id;
@property(nonatomic,strong)NSString *singer_name;
@property(nonatomic,strong)NSString *song_id;
@property(nonatomic,strong)NSString *song_name;

@property(nonatomic,strong)NSString *duration;
@property(nonatomic,strong)NSString *type_description;
@property(nonatomic,strong)NSString *url;


@end
