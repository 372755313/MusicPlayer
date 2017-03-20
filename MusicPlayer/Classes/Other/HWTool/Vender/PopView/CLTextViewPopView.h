//
//  CLTextViewPopView.h
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTextViewPopView : UIView

+ (instancetype)textViewPopView:(void(^)(NSString *text))okeyBtnClicked cancelBtnClicked:(void(^)())cancelBtnClicked;


@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) NSString *placehold;



@end
