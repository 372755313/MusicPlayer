//
//  CLSelectPOPView.h
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSelectPOPView : UIView

+ (instancetype)selectPopView:(void(^)(NSInteger index))OkeyBtnClicked cancelBtnCallBack:(void(^)())cancelBtnCallBack;


@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) NSArray *dataSource;


@end
