//
//  CLTextViewPopView.m
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLTextViewPopView.h"

#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)


typedef void(^okeyBtnClicked)(NSString *text);

typedef void(^cancelClicked)(void);

@interface CLTextViewPopView ()<UITextViewDelegate>


@property (nonatomic, copy) okeyBtnClicked okeyBlock;
@property (nonatomic, copy) cancelClicked cancelBlock;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) UIButton *okBtn;
@property (nonatomic ,strong) UILabel *placeLabel;


@end


@implementation CLTextViewPopView

+ (instancetype)textViewPopView:(void (^)(NSString *text))okeyBtnClicked cancelBtnClicked:(void (^)())cancelBtnClicked {
    
    CLTextViewPopView *popView = [[self alloc] init];
    popView.okeyBlock = okeyBtnClicked;
    popView.cancelBlock = cancelBtnClicked;
    popView.frame = CGRectMake(30, (ScreenH - 178)/2.0, ScreenW - 60, 178);
    return popView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        [self createTitleLabel];
        [self createTextView];
        [self createButton];
        [self createOkBtn];
        [self.textView addSubview:self.placeLabel];
    }
    return self;
}


- (void)createTitleLabel {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, ScreenW - 60, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"标题";
    [self addSubview:_titleLabel];
    
}

- (void)setPlacehold:(NSString *)placehold {
    
    _placehold = placehold;
    
    _placeLabel.text = placehold;
    
    [self caluTextHeight:placehold];
    
    
}


- (void)caluTextHeight:(NSString *)text {
    
    CGFloat lableHeight = [text boundingRectWithSize:CGSizeMake(_textView.bounds.size.width, 60) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesDeviceMetrics | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    if (lableHeight <20) {
        lableHeight = 20;
    }
    
   self.placeLabel.frame = CGRectMake(0, 0, ScreenW - 60, lableHeight);

}



- (UILabel *)placeLabel {
    
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc] init];
        
        _placeLabel.numberOfLines = 0;
        [_textView addSubview:_placeLabel];
        _placeLabel.font = [UIFont systemFontOfSize:14];
        _placeLabel.textColor = [UIColor colorWithWhite:0.89 alpha:1];
        
        [self caluTextHeight:self.placehold];
    }
    
    return _placeLabel;
}



- (void)createTextView {
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_titleLabel.frame)+8, ScreenW - 90, 70)];
    [self addSubview:_textView];
    _textView.delegate = self;

    _textView.layer.borderColor = [UIColor colorWithWhite:0.93 alpha:1].CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 3;
    
}


- (void)createButton {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:btn];
    
    btn.frame = CGRectMake(15, CGRectGetMaxY(_textView.frame)+15, (ScreenW - 120)/2.0, 35);
    
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
    
    btn.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame)+30, CGRectGetMaxY(_textView.frame)+15, (ScreenW - 120)/2.0, 35);
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    // 179 0 6
    [btn setBackgroundColor:[UIColor colorWithRed:179.0/255.0 green:0 blue:6.0f/255.0 alpha:1]];
    
    [btn addTarget:self action:@selector(okeyBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.okBtn = btn;
    
}

- (void)okeyBtnPress {
    
    if (self.okeyBlock) {
        
        NSString *text = nil;
        if ([_textView.text isEqualToString:@""]) {
            text = @"-100";
        } else {
            
            text = _textView.text;
        }
        
        self.okeyBlock(text);
    }
    
}

- (void)cancelBtnPress {
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
}


#pragma mark - textViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self.placeLabel removeFromSuperview];
    self.placeLabel = nil;
}


- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""]) {
        
        [self.textView addSubview:self.placeLabel];
        self.placeLabel.text = self.placehold;
    }
    else {
        
        if (self.placeLabel) {
            [self.placeLabel removeFromSuperview];
            self.placeLabel = nil;
        }
        
        
    }
}





@end
