//
//  HBDockView.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBDockView.h"
#import "zy.pch"
#import <Masonry.h>

@interface HBDockView ()

@property (nonatomic,assign)NSInteger num;

@end

@implementation HBDockView

+ (HBDockView *)viewWithNum:(NSInteger )num Option:(HBOption)Option
{
    HBDockView *dockV = [[HBDockView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 110)];
//    dockV.num = num;
    dockV.option = Option;
    return dockV;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray *arr = @[@"tupian.png",@"circularsearch.png",@"clean.png",@"guanyuwomenm.png"];
        NSArray *titleArr = @[@"图文地理",@"音乐搜索",@"清除缓存",@"关于我们"];
        NSArray *tagArr = @[@"kPicSelect",@"kMusicDone",@"kClearCache",@"kAbout"];
        for (int i=0; i<4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:arr[i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor cyanColor];
            btn.tag = [tagArr[i] integerValue];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            UILabel *titlteL = [[UILabel alloc] init];
            titlteL.text = titleArr[i];
            titlteL.font = [UIFont systemFontOfSize:14];
            [self addSubview:titlteL];
            
            __weak __typeof(&*self)weakSelf = self;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(20+(i*70));
                make.top.equalTo(weakSelf).offset(20);
                make.width.equalTo(@50);
                make.height.equalTo(@50);
            }];
            
            [titlteL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(20+(i*70));
                make.top.equalTo(btn.mas_bottom).offset(10);
            }];
        }
    }
    return self;
}



- (void)click:(UIButton *)btn
{
    if (self.option) {
        self.option(kMusicDone);
    }
}


@end
