//
//  DockView.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kkPicSelect,  //点击图片选项
    kkMusicDone,  //
    kkClearCache, //
    kkAbout       //
} kkDock;

typedef void(^dockOption) (kkDock doing);
typedef void(^alphaOption) ();

@interface DockView : UIView

@property (nonatomic,copy)dockOption dockOption;
@property (nonatomic,copy)alphaOption alphaOption;
@property (nonatomic,weak) UIView *alphaV;

@end
