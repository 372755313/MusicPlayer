//
//  CLTextFieldPopView.h
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface CLTextFieldPopView : UIView


@property (nonatomic ,strong) UITextField *textField;
@property (nonatomic ,strong) UILabel *titleLabel;



+ (instancetype)TextFieldPopView:(void(^)(NSString *text))okBtnCallBack cancelBtnCallBack:(void(^)())cancelbtnCallBack;


@end
