//
//  MusicDetailViewController.h
//  MusicPlayer-B
//
//  Created by lanou on 15/7/15.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSongModel.h"

@interface MusicDetailViewController : UIViewController

@property(nonatomic,strong) SSongModel *ssModel;
@property(nonatomic,strong)NSMutableArray *itemArray; //存放节目的数组
@property(nonatomic,assign)NSInteger itemNumber;//节目的索引

@property (weak, nonatomic) UIButton *moShiButton;
@property (weak, nonatomic) UIButton *sYiQuButton;
@property (weak, nonatomic) UIButton *boFangButton;
@property (weak, nonatomic) UIButton *xYiQuButton;


//返回到前一个页面de按钮

- (void)moShiButton:(id)sender;
- (void)sYiQuButton:(id)sender;
- (void)boFangButton:(id)sender;
- (void)xYiQuButton:(id)sender;



@end
