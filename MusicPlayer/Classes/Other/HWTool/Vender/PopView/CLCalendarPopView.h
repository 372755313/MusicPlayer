//
//  CLCalendarPopView.h
//  popupView
//
//  Created by sethmedia on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLCalendarPopView : UIView

+ (instancetype)calendarPopView:(void(^)(NSInteger, NSInteger, NSInteger))okblock;

@property (nonatomic, strong) UIColor *titleBgColor;


@end
