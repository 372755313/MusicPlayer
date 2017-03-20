//
//  HBHeaderBarView.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/16.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Option)();
@interface HBHeaderBarView : UIView

+ (HBHeaderBarView *)view:(BOOL)isLogin Option:(Option)Option;

@end
