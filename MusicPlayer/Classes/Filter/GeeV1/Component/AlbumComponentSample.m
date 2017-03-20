//
//  AlbumComponentSample.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "AlbumComponentSample.h"
/**
 *  相册组件范例
 */
@interface AlbumComponentSample ()
{
    // 相册组件
    TuSDKCPAlbumComponent *_albumComponent;
}
@end

@implementation AlbumComponentSample
- (instancetype)init;
{
    self = [super initWithGroupId:ComponentSample title:NSLocalizedString(@"sample_AlbumComponent", @"相册组件")];
    return self;
}

/**
 *  显示范例
 *
 *  @param controller 启动控制器
 */
- (void)showSampleWithController:(UIViewController *)controller;
{
    if (!controller) return;
    self.controller = controller;

    lsqLDebug(@"albumComponentHandler");

    // 组件选项配置
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAlbumComponent.html

    _albumComponent =
    [TuSDKGeeV1 albumCommponentWithController:controller
                           callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         _albumComponent = nil;
         // 获取头像图片
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         
         // if (controller) [controller dismissModalViewControllerAnimated];
         [result logInfo];
     }];
    
    // 组件选项配置
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAlbumComponent.html
    // _albumComponent.options
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFAlbumOptions.html
    // _albumComponent.options.albumOptions
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFPhotosOptions.html
    // _albumComponent.options.photosOptions
    
    // 是否在组件执行完成后自动关闭组件 (默认:NO)
    _albumComponent.autoDismissWhenCompelted = YES;
    [_albumComponent showComponent];
}
@end
