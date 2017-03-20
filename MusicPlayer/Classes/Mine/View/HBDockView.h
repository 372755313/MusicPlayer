//
//  HBDockView.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kPicSelect,  //点击图片选项
    kMusicDone,  //
    kClearCache, //
    kAbout       //
} kDock;

typedef void(^HBOption)(kDock doing);

@interface HBDockView : UIView
@property (nonatomic,copy)HBOption option;//点击操作

+ (HBDockView *)viewWithNum:(NSInteger )num Option:(HBOption)Option;

@end
