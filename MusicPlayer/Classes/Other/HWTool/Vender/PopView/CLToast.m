//
//  CLToast.m
//  popupView
//
//  Created by sethmedia on 16/8/27.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLToast.h"

#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface CLToast ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel  *label;

@end


@implementation CLToast


- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {


    }
    return self;
}



- (UIView *)bgView {
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.78;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 3;
        
    }
    
    return _bgView;
}



- (UILabel *)label {
    
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:13];
    
    }
    
    return _label;
}


+ (instancetype)defaultToast {
    
    static CLToast *toast = nil;
    
    @synchronized(self) {
    
        toast = [[self alloc] init];
        
    }
    return toast;
    
}

+ (instancetype)showWithText:(NSString *)text {
    
    CLToast *toast = [CLToast defaultToast];
    
    [toast addSubview:toast.bgView];
    [toast addSubview:toast.label];
    toast.label.text = text;
    
//    toast.bgView.frame = CGRectMake((ScreenW -[CLToast calculateWidthByText:text])/2.0, ScreenH, [CLToast calculateWidthByText:text], 30);
//    
//    toast.label.frame = CGRectMake((ScreenW -[CLToast calculateWidthByText:text])/2.0, ScreenH, [CLToast calculateWidthByText:text], 20);
    
    toast.bgView.frame = CGRectMake((ScreenW -[CLToast calculateWidthByText:text] - 30)/2.0, ScreenH - 80, [CLToast calculateWidthByText:text] + 30, 30);
    
    toast.label.frame = CGRectMake((ScreenW -[CLToast calculateWidthByText:text])/2.0, ScreenH - 75, [CLToast calculateWidthByText:text], 20);
    
    toast.bgView.alpha = 0;
    toast.label.alpha = 0;
    
    
    [UIView animateWithDuration:0.2 animations:^{
       
        toast.bgView.alpha = 1;
        toast.label.alpha = 1;
        
    }completion:^(BOOL finished) {
        
        [toast performSelector:@selector(goRun:) withObject:toast afterDelay:0.5];
        
        
    }];
    
    
    return toast;
}

- (void)goRun:(CLToast *)num {
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
//        self.bgView.frame = CGRectMake((ScreenW -[num floatValue] - 30)/2.0, ScreenH, [num floatValue]+30, 30);
//        
//        self.label.frame = CGRectMake((ScreenW -[num floatValue])/2.0, ScreenH, [num floatValue], 20);
        
        num.bgView.alpha = 0;
        num.label.alpha = 0;
        
        
        
    }completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        self.bgView = nil;
        
        [self removeFromSuperview];
        
    }];
    
}


+ (CGFloat)calculateWidthByText:(NSString *)text {
    
    CGFloat width = [text boundingRectWithSize:CGSizeMake(ScreenW - 60, 20)
                                       options: NSStringDrawingUsesLineFragmentOrigin |
                     NSStringDrawingUsesFontLeading
    
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                       context:nil].size.width;
    
    
    return width;
}





@end
