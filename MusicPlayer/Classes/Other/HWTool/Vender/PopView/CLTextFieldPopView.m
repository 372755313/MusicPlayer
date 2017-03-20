//
//  CLTextFieldPopView.m
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLTextFieldPopView.h"
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)


typedef void(^okBtnCallBack)(NSString *text);
typedef void(^cancelBtnCallBack)(void);

@interface CLTextFieldPopView ()

@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) UIButton *okeyBtn;
@property (nonatomic ,copy) okBtnCallBack okeyBtnCallBack;
@property (nonatomic ,copy) cancelBtnCallBack cancelBtnCallBack;


@end


@implementation CLTextFieldPopView


+ (instancetype)TextFieldPopView:(void(^)(NSString *text))okBtnCallBack cancelBtnCallBack:(void(^)())cancelbtnCallBack {

    CLTextFieldPopView *popView = [[self alloc] init];
    popView.frame = CGRectMake(30, (ScreenH - 155)/2.0f, ScreenW - 60, 155);

    popView.okeyBtnCallBack = okBtnCallBack;
    popView.cancelBtnCallBack = cancelbtnCallBack;
    
    
    return popView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        [self createTitleLabel];
        [self createTextField];
        [self createButton];
        [self createOkBtn];
        

        
        
    }
    return self;
}



- (void)createTitleLabel {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, ScreenW - 60, 30)];
    _titleLabel.font          = [UIFont systemFontOfSize:23];
    _titleLabel.text          = @"标题";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_titleLabel];
}

- (void)createTextField {
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_titleLabel.frame) + 15, ScreenW - 90, 38)];
    [self addSubview:_textField];
    
    _textField.placeholder = @"请输入2~4位汉字";
    _textField.tintColor = [UIColor grayColor];
    _textField.layer.borderWidth = 0.5;
    _textField.layer.borderColor = [UIColor colorWithWhite:0.93 alpha:1].CGColor;
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 3;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 38)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)createButton {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:btn];
    
    btn.frame = CGRectMake(15, CGRectGetMaxY(_textField.frame)+15, (ScreenW - 120)/2.0, 35);
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelBtn = btn;
    [btn setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [btn addTarget:self action:@selector(cancelBtnPress) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createOkBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:btn];
    
    btn.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame)+30, CGRectGetMaxY(_textField.frame)+15, (ScreenW - 120)/2.0, 35);
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    // 179 0 6
    [btn setBackgroundColor:[UIColor colorWithRed:179.0/255.0 green:0 blue:6.0f/255.0 alpha:1]];
    
    [btn addTarget:self action:@selector(okeyBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.okeyBtn = btn;
    
}

- (void)okeyBtnPress {
    
    if (self.okeyBtnCallBack) {
        
        NSString *text = nil;
        if ([_textField.text isEqualToString:@""]) {
            text = @"-100";
        } else {
            
            text = _textField.text;
        }
        
        self.okeyBtnCallBack(text);
    }
    
}

- (void)cancelBtnPress {
    
    if (self.cancelBtnCallBack) {
        self.cancelBtnCallBack();
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}



@end
