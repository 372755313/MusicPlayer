//
//  CLGifLoadView.m
//  CLMJRefresh
//
//  Created by Charles on 15/12/18.
//  Copyright © 2015年 Charles. All rights reserved.
//


#import "ZYLoadView.h"
#import "UIView+MJExtension.h"

const float   kWidthLoading                 = 100;
const float   kHeightLoading                = 65;

const float   kWidthFailed                  = 100;
const float   kHeightFailed                 = 60;

const float   kWidthNone                    = 100;
const float   kHeightNone                   = 60;

NSString * const imgPathName                = @"dh";
const NSInteger   imgNum                    = 6;
NSString * const  imgType                   = @"png";
NSString * const iconError                  = @"icon_error_unkown";

@interface ZYLoadView()
@property (nonatomic,weak) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (nonatomic,strong) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (nonatomic,strong)  NSMutableDictionary *stateDurations;

@property (nonatomic,weak)  UILabel * stateLabel;

@property (nonatomic,strong)  UIButton * btnRetry;

@property (nonatomic,copy)NSString *loadingTitle;
@property (nonatomic,copy)NSString *failTitle;
@property (nonatomic,copy)NSString *noneTitle;

@end

@implementation ZYLoadView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self makeView];
    }
    return self;
}

- (void)makeView{
    // 设置普通状态的动画图片
    self.gifView = [self gifView];
    self.gifView.frame = CGRectMake(0,0, kWidthLoading, kHeightLoading);
    self.gifView.backgroundColor = [UIColor clearColor];
    self.gifView.center = CGPointMake(self.center.x, self.center.y-66);
    
     UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.gifView.frame.origin.x, CGRectGetMaxY(self.gifView.frame) + 10, self.gifView.frame.size.width, 20)];
    self.stateLabel = stateLabel;
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.font = [UIFont systemFontOfSize:12.0f];
    self.stateLabel.textColor = [UIColor lightGrayColor];
    self.stateLabel.text = @"努力加载中...";
    [self addSubview:self.stateLabel];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:imgPathName ofType:@"bundle"];
    for (NSUInteger i = 1; i<=imgNum; i++) {
        NSString *imgPath= [bundlePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",@(i),imgType]];
        UIImage *image =[UIImage imageWithContentsOfFile:imgPath];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:CLLoadStateLoading];

    [self setState:CLLoadStateLoading];
}
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(CLLoadState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(CLLoadState)state
{
    [self setImages:images duration:images.count * 0.1 forState:state];
}


- (void)setTitle:(NSString *)title state:(CLLoadState)state
{
    switch (state) {
        case CLLoadStateLoading://加载中
        {
            self.loadingTitle = title;
            self.state = CLLoadStateLoading;
        }
            break;
        case CLLoadStateFinish://结束
        {
            self.state = CLLoadStateFinish;
        }
            break;
        case CLLoadStateNone://列表没有数据
        {
            self.noneTitle = title;
            self.state = CLLoadStateNone;
        }
            break;
        case CLLoadStateFailed: //失败
        {
            self.failTitle = title;
            self.state = CLLoadStateFailed;
        }
            break;
            
        default:
            break;
    }

}


#pragma mark - 实现父类的方法

- (void)placeSubviews
{
    
    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

- (void)setState:(CLLoadState)state
{
    // 根据状态做事情
    if (state == CLLoadStateLoading) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        [self.gifView stopAnimating];
        self.gifView.frame = CGRectMake(0,0, kWidthLoading, kHeightLoading);
//        self.gifView.center = self.center;
        self.gifView.center = CGPointMake(self.center.x, self.center.y-64);
        self.stateLabel.frame = CGRectMake(self.gifView.frame.origin.x, CGRectGetMaxY(self.gifView.frame) + 10, self.gifView.frame.size.width, 20);
        if (self.loadingTitle == nil) {
            self.stateLabel.text = @"努力加载中...";
        }else{
            self.stateLabel.text = self.loadingTitle;
        }
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
        if(self.btnRetry){
         self.btnRetry.hidden = YES;
        }
    }else if (state == CLLoadStateFinish){
        [self hide:self After:0.50f];
    }else if(state == CLLoadStateFailed){
        [self.gifView stopAnimating];
        self.gifView.image = [UIImage imageNamed:iconError];
        self.gifView.frame = CGRectMake(0, 0, kWidthFailed, kHeightFailed);
        self.gifView.center = CGPointMake(self.center.x, self.center.y-64);
        self.stateLabel.frame = CGRectMake(self.gifView.frame.origin.x - 5, CGRectGetMaxY(self.gifView.frame) + 10, self.gifView.frame.size.width + 10, 20);
        
        if (self.failTitle == nil) {
            self.stateLabel.text = @"加载数据失败,请重试~";
        }else{
            self.stateLabel.text = self.failTitle;
        }
    
        if (!self.btnRetry) {
            self.btnRetry = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnRetry.frame = CGRectMake(self.gifView.frame.origin.x, CGRectGetMaxY(self.stateLabel.frame) + 10, self.gifView.frame.size.width, 30);
            [self.btnRetry setTitle:@"重试" forState:UIControlStateNormal];
            [self.btnRetry setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.btnRetry.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.btnRetry.backgroundColor = [UIColor whiteColor];
            self.btnRetry.layer.cornerRadius = 2.0f;
            self.btnRetry.clipsToBounds = YES;
            [self.btnRetry addTarget:self action:@selector(btnRetry:) forControlEvents:UIControlEventTouchUpInside];
            self.btnRetry.layer.borderWidth = .5f;
            self.btnRetry.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [self addSubview:self.btnRetry];
        }
        else{
            self.btnRetry.frame = CGRectMake(self.gifView.frame.origin.x, CGRectGetMaxY(self.stateLabel.frame) + 10, self.gifView.frame.size.width, 30);
            self.btnRetry.hidden = NO;
        }
    }else if(state == CLLoadStateNone){
        [self.gifView stopAnimating];
        self.gifView.image = [UIImage imageNamed:iconError];
        self.gifView.frame = CGRectMake(0, 0, kWidthNone, kHeightNone);
        self.gifView.center = CGPointMake(self.center.x, self.center.y-66);
        self.stateLabel.frame = CGRectMake(self.gifView.frame.origin.x - 5, CGRectGetMaxY(self.gifView.frame) + 10, self.gifView.frame.size.width + 10, 20);
        if (self.noneTitle == nil) {
          self.stateLabel.text = @"这里什么都没有~";
        }else{
            self.stateLabel.text = self.noneTitle;
        }
        if(self.btnRetry){
            self.btnRetry.hidden = YES;
        }
    }
}
- (void)btnRetry:(UIButton *)sender{
    self.btnRetry.hidden = YES;
    myRetryBlock();
    [self setState:CLLoadStateLoading];
}
- (void)setRetryBlcok:(RetryBlock)retryBlcok{
    myRetryBlock = retryBlcok;
}

- (void)hide{
    [self removeFromSuperview];
}
- (void)hide:(UIView *)view After:(NSTimeInterval)duration{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
      
    });
}


@end
