//
//  CLPopView.m
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//


#import "CLPopView.h"


#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)



@interface CLPopView ()




@property (nonatomic ,strong) UIView *bgView;



@end

@implementation CLPopView


+ (instancetype)popView {
    
    
    CLPopView *pop = [[self alloc] init];
    pop.frame = [UIScreen mainScreen].bounds;
    
    return pop;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setupBgView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifitionTextView:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifitionText:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
    }
    return self;
}

- (void)notifitionText:(NSNotification *)note {
    
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    if (keyboardY == [UIScreen mainScreen].bounds.size.height) {
        self.transform = CGAffineTransformIdentity;
        return;
    }
    
    CGFloat textY = CGRectGetMaxY(_textPopView.frame);
    
    if (textY > keyboardY) { // 盖住控件
        self.transform = CGAffineTransformMakeTranslation(0, keyboardY - textY);
    }

    
}


- (void)notifitionTextView:(NSNotification *)note {
    
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    if (keyboardY == [UIScreen mainScreen].bounds.size.height) {
        self.transform = CGAffineTransformIdentity;
        return;
    }
    
    CGFloat textY = CGRectGetMaxY(_textViewPopView.frame);
    
    if (textY > keyboardY) { // 盖住控件
        self.transform = CGAffineTransformMakeTranslation(0, keyboardY - textY);
    }
    
}




- (void)textDismiss {
    
    [UIView animateWithDuration:0.1 animations:^{
       
      self.textPopView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
    }completion:^(BOOL finished) {
    
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        self.bgView = nil;
        
       
    }];
    
}


- (void)setupBgView {
    

    self.bgView= [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.2;
    
    [self addSubview:self.bgView];
    
    
    
}

- (void)setPopViewType:(CLPopViewType)popViewType {

    switch (popViewType) {
        
        case CLPopViewTextField:
        {
            [self PopViewTextField];
        }
            break;
        
        case CLPopViewTypeSelect:
        {
            [self popViewSelect];
        }
            break;
            
        case CLPopViewTypeTextView:
        {
            [self popViewTextView];
        }
            break;
            
        case CLPopViewTypeCalendar:
        {
            [self popViewCalendar];
        }
            break;
            
        default:
            break;
    }
    
    

}


- (void)popViewCalendar {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];

    CLCalendarPopView *popView = [CLCalendarPopView calendarPopView:^(NSInteger year,NSInteger month, NSInteger day) {
       

        if (_delegate && [_delegate respondsToSelector:@selector(popViewOkBtnClicked:class:popViewType:)]) {
            
            [_delegate popViewOkBtnClicked:[NSString stringWithFormat:@"%04ld-%02ld-%02ld",year,month,day] class:[CLCalendarPopView class] popViewType:CLPopViewTypeCalendar];
            
        }
        
        [self dismiss:self.calendarPopView];
        
        
    }];
    
    [self addSubview:popView];
    
    popView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
       
        popView.transform = CGAffineTransformIdentity;
        
        
    }];
    
    self.calendarPopView = popView;
    
    

    
    
}




- (void)tap:(UITapGestureRecognizer *)tap {

    
    if (_delegate && [_delegate respondsToSelector:@selector(popViewOkBtnClicked:class:popViewType:)]) {
        
        [_delegate popViewOkBtnClicked:@"-100" class:[CLCalendarPopView class] popViewType:CLPopViewTypeCalendar];
        
    }
    
    [self dismiss:self.calendarPopView];
    
}



- (void)popViewTextView {
    
    CLTextViewPopView *popView = [CLTextViewPopView textViewPopView:^(NSString *text){
        
        if (_delegate && [_delegate respondsToSelector:@selector(popViewOkBtnClicked:class:popViewType:)]) {
            [_delegate popViewOkBtnClicked:text class:[CLTextViewPopView class] popViewType:CLPopViewTypeTextView];
        }
        [self dismiss:self.textViewPopView];
        
        
    } cancelBtnClicked:^{
        
        if (_delegate && [_delegate respondsToSelector:@selector(popViewCancelBtnClicked:popViewType:)]) {
            [_delegate popViewCancelBtnClicked:[CLTextViewPopView class] popViewType:CLPopViewTypeTextView];
        }
        
        [self dismiss:self.textViewPopView];
        
        
        
    }];
    
    self.textViewPopView = popView;
    [self addSubview:popView];
    
    popView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
       
        popView.transform = CGAffineTransformIdentity;
        
        
    }];
    
    
}




- (void)popViewSelect {
    
    CLSelectPOPView *popView = [CLSelectPOPView selectPopView:^(NSInteger index){

        if (_delegate && [_delegate respondsToSelector:@selector(popViewOkBtnClicked:class:popViewType:)]) {
            [_delegate popViewOkBtnClicked:@(index) class:[CLSelectPOPView class] popViewType:CLPopViewTypeSelect];
        }
        [self dismiss:self.selectPopView];

    } cancelBtnCallBack:^{

        if (_delegate && [_delegate respondsToSelector:@selector(popViewCancelBtnClicked:popViewType:)]) {
            [_delegate popViewCancelBtnClicked:[CLSelectPOPView class] popViewType:CLPopViewTypeSelect];
        }

        [self dismiss:self.selectPopView];


    }];

    [self addSubview:popView];



    popView.transform = CGAffineTransformMakeScale(0, 0);


    [UIView animateWithDuration:0.2 animations:^{

        popView.transform = CGAffineTransformIdentity;

    }];


    _selectPopView    = popView;

    
}


- (void)setSelectDataSource:(NSArray<NSString *> *)selectDataSource {
    
    _selectDataSource = selectDataSource;
    _selectPopView.dataSource = selectDataSource;
    
}


- (void)PopViewTextField {
    
    CLTextFieldPopView *popView = [CLTextFieldPopView TextFieldPopView:^(NSString *text){
        
        if (_delegate && [_delegate respondsToSelector:@selector(popViewOkBtnClicked:class:popViewType:)]) {
            [_delegate popViewOkBtnClicked:text class:[CLTextFieldPopView class] popViewType:CLPopViewTextField];
        }
        
        [self dismiss:self.textPopView];
    
    } cancelBtnCallBack:^{
        
        if (_delegate && [_delegate respondsToSelector:@selector(popViewCancelBtnClicked:popViewType:)]) {
            [_delegate popViewCancelBtnClicked:[CLTextFieldPopView class] popViewType:CLPopViewTextField];
        }
        
       [self dismiss:self.textPopView];
        
        
    }];
   
    [self addSubview:popView];
     self.textPopView = popView;
    
    popView.transform = CGAffineTransformMakeScale(0, 0);
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        popView.transform = CGAffineTransformIdentity;
        
    }];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
    
}


- (void)dismiss:(UIView *)view {
    
    [UIView animateWithDuration:0.1 animations:^{
        
        view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
    }completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        self.bgView = nil;
        
        
    }];
    
    
}




@end
