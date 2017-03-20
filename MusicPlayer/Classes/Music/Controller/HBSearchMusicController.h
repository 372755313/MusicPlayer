//
//  HBSearchMusicController.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/18.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "ZYBaseViewController.h"

typedef void (^resultBlock)(NSArray *resultArray);
@interface HBSearchMusicController : ZYBaseViewController
@property(nonatomic,weak)UISearchBar *searchBar;


@end
