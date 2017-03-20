//
//  CLPopView.h
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTextFieldPopView.h"
#import "CLSelectPOPView.h"
#import "CLTextViewPopView.h"
#import "CLCalendarPopView.h"

typedef NS_ENUM(NSInteger, CLPopViewType) {
    
    CLPopViewTypeSelect, // 选择框
    CLPopViewTextField, // 单行输入框
    CLPopViewTypeTextView, // 多行输入框
    CLPopViewTypeCalendar // 日历选择日期
};

@protocol CLPopViewDelegate <NSObject>

@required
- (void)popViewOkBtnClicked:(id)text class:(Class)lClass popViewType:(CLPopViewType)ViewType;  // 返回值是-100时为默认值  及用户没做处理


@optional
- (void)popViewCancelBtnClicked:(Class)lClass popViewType:(CLPopViewType)viewType;



@end


@interface CLPopView : UIView

//通用
@property (nonatomic ,weak) id <CLPopViewDelegate> delegate;
@property (nonatomic, assign)  CLPopViewType popViewType;


// 但行输入框
@property (nonatomic ,strong) CLTextFieldPopView *textPopView;


// 多行输入框
@property (nonatomic ,strong) CLTextViewPopView *textViewPopView;


// 选择框
@property (nonatomic ,strong) CLSelectPOPView *selectPopView;
@property (nonatomic ,strong) NSArray<NSString *> *selectDataSource;


// 日历选择
@property (nonatomic, strong) CLCalendarPopView *calendarPopView;



+ (instancetype)popView;

//- (void)selectRow:(NSInteger *)row;

@end
