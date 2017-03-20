//
//  DockView.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "DockView.h"
#import <Masonry.h>
#import "zy.pch"

@implementation DockView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIView *alphaV = [[UIView alloc] init];
        alphaV.backgroundColor = [UIColor blackColor];
        alphaV.alpha = 0.5;
        alphaV.userInteractionEnabled = YES;
        [self addSubview:alphaV];
        _alphaV = alphaV;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest)];
        [alphaV addGestureRecognizer:tapGest];
        
        UIView *bottomV = [[UIView alloc] init];
        bottomV.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomV];
        
        __weak __typeof(&*self)weakSelf = self;
        [alphaV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.top.equalTo(weakSelf);
            make.width.equalTo(@(kWidth));
            make.height.equalTo(@(KHeight));
        }];
        
        [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.top.equalTo(alphaV.mas_bottom);
            make.width.equalTo(@(kWidth));
            make.height.equalTo(@(110));
        }];
        
        
        //dock菜单托盘
        NSArray *arr = @[@"tupian.png",@"circularsearch.png",@"clean.png",@"guanyuwomenm.png"];
        NSArray *titleArr = @[@"图文地理",@"音乐搜索",@"清除缓存",@"关于我们"];
        for (int i=0; i<4; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            if (i==0) {
                btn.tag = kkPicSelect;
            }else if (i==1){
                btn.tag = kkMusicDone;
            }else if (i==2){
                btn.tag = kkClearCache;
            }else if (i==3){
                btn.tag = kkAbout;
            }

            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bottomV addSubview:btn];
            
            UILabel *titlteL = [[UILabel alloc] init];
            titlteL.text = titleArr[i];
            titlteL.font = [UIFont systemFontOfSize:11];
            [bottomV addSubview:titlteL];
            
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset((kWidth-320)/2+(i*90));
                make.top.equalTo(bottomV).offset(20);
                make.width.equalTo(@50);
                make.height.equalTo(@50);
            }];
            
            [titlteL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset((kWidth-310)/2+(i*90));
                make.top.equalTo(weakSelf.mas_bottom).offset(-30);
            }];
        }

    }
    return self;
}


- (void)click:(UIButton *)btn
{
    if (self.dockOption) {
        self.dockOption(btn.tag);
        NSLog(@"-----------%ld",btn.tag);
    }
}

- (void)tapGest
{
    if (self.alphaOption) {
        self.alphaOption();
    }
}

@end
