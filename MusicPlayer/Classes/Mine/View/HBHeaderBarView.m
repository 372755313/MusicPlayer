//
//  HBHeaderBarView.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/16.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBHeaderBarView.h"
#import "OLImage.h"
#import "OLImageView.h"
#import <Masonry.h>
#import "zy.pch"

@interface HBHeaderBarView ()

@property (nonatomic,copy)Option Option;
@property (nonatomic,weak)UILabel *titleL;
@property (nonatomic,weak)UIButton *mainBtn;

@end

@implementation HBHeaderBarView

+ (HBHeaderBarView *)view:(BOOL)isLogin Option:(Option)Option
{
    HBHeaderBarView *headerV = [[HBHeaderBarView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KHeight/7)];
//    headerV.backgroundColor = HWColor(207, 45, 52);
    headerV.backgroundColor = HWColor(0, 0, 0);
    headerV.Option = Option;
    return headerV;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        OLImageView *Aimv = [OLImageView new];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"love" ofType:@"gif"];
        NSData *GIFDATA = [NSData dataWithContentsOfFile:filePath];
        Aimv.image = [OLImage imageWithData:GIFDATA];
        [self addSubview:Aimv];
        
        //菜单按钮
        UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainBtn setImage:[UIImage imageNamed:@"fdj"] forState:UIControlStateNormal];
        [mainBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        _mainBtn = mainBtn;
        [self addSubview:self.mainBtn];
        
        __weak __typeof(&*self)weakSelf = self;
        [Aimv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.top.equalTo(weakSelf).offset(0);
            make.width.equalTo(@(kWidth/7));
            make.height.equalTo(@(kWidth/7));
        }];
        
        [mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf).offset(0);
            make.width.equalTo(@(kWidth/7));
            make.height.equalTo(@(kWidth/7));
        }];
    }
    return self;
}

- (void)click
{
    if (self.Option) {
        self.Option();
    }
}

@end
