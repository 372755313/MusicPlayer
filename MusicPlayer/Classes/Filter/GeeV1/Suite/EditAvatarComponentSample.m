//
//  EditAvatarComponentSample.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 tusdk.com. All rights reserved.
//

#import "EditAvatarComponentSample.h"
/**
 *  头像设置组件(编辑)范例
 */
@interface EditAvatarComponentSample()
{
    // 头像设置组件
    TuSDKCPAvatarComponent *_avatarComponent;
}
@end

@implementation EditAvatarComponentSample
- (instancetype)init;
{
    self = [super initWithGroupId:SuiteSample title:NSLocalizedString(@"sample_EditAvatarComponent", @"头像设置组件")];
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
    
    lsqLDebug(@"avatarComponentHandler");
    
    // 组件选项配置
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAvatarComponent.html
    _avatarComponent =
    [TuSDKGeeV1 avatarCommponentWithController:controller
                            callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         _avatarComponent = nil;
         // 获取头像图片
         if (error) {
             lsqLError(@"avatar reader error: %@", error.userInfo);
             return;
         }
         [result logInfo];
     }];
    
    // 组件选项配置
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKCPAvatarOptions.html
    // _avatarComponent.options
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFAlbumOptions.html
    // _avatarComponent.options.albumOptions
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFPhotosOptions.html
    // _avatarComponent.options.photosOptions
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFCameraOptions.html
    // _avatarComponent.options.cameraOptions
    
    // @see-https://tusdk.com/docs/ios/api-gee/Classes/TuSDKPFEditTurnAndCutOptions.html
    // _avatarComponent.options.editTurnAndCutOptions
    
    
    
    // 需要显示的滤镜名称列表 (如果为空将显示所有自定义滤镜)
    _avatarComponent.options.cameraOptions.filterGroup = @[@"SkinNature", @"SkinPink", @"SkinJelly", @"SkinNoir", @"SkinRuddy", @"SkinPowder", @"SkinSugar"];
    // 是否在组件执行完成后自动关闭组件 (默认:NO)
    _avatarComponent.autoDismissWhenCompelted = YES;
    [_avatarComponent showComponent];
}
@end
