//
//  HBGuanYuViewController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/19.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBGuanYuViewController.h"

@interface HBGuanYuViewController ()
@property (nonatomic,strong) UIImageView *guanYuImageView;
@property (nonatomic,strong) UIView *headerBarView;
@property (nonatomic,strong) UILabel *guanYuLabel;
//@property (nonatomic,strong) HeaderBar *headerBar;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation HBGuanYuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //    self.headerBar = [[HeaderBar alloc] initWithFrame:CGRectMake(0, 20, 375*KWidthScale, 375*KWidthScale/7)];
    //    self.headerBar.backgroundColor = [UIColor redColor];
    //    [self.headerBar.mainButton addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏
    self.headerBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 375*KWidthScale, 375*KWidthScale/7)];
    self.headerBarView.backgroundColor = [UIColor colorWithRed:207/255.0 green:45/255.0 blue:52/255.0 alpha:1];
    [self.view addSubview:self.headerBarView];
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, 20, 375*KWidthScale/7, 375*KWidthScale/7);
    [self.backButton setImage:[UIImage imageNamed:@"guanyu-fanhui.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(doBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    //标题 关于图乐
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(375*KWidthScale/6, 20, 375*KWidthScale/3, 375*KWidthScale/7)];
    //self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"关于图·乐";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    //内容图片
    self.guanYuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20+375*KWidthScale/7, 375*KWidthScale, 667*KHeightScale-20)];
    self.guanYuImageView.image = [UIImage imageNamed:@"bj.png"];
    [self.view addSubview:self.guanYuImageView];
    
    //内容
    //    self.guanYuLabel = [[UILabel alloc] initWithFrame:CGRectMake(50*KWidthScale, 20+375*KWidthScale/7, 375*KWidthScale-100*KWidthScale, 667*KHeightScale-20-375*KWidthScale/7)];
    //    self.guanYuLabel.backgroundColor = [UIColor whiteColor];
    //    self.guanYuLabel.text = @""
    //    [self.view addSubview:self.guanYuLabel];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(50*KWidthScale, 20+375*KHeightScale/7+60*KHeightScale, 375*KWidthScale-100*KWidthScale, 100*KHeightScale)];
    label1.text =@"       图·乐,是一款以图片和音乐组成的图文音乐类应用,旨在以观赏美图，倾听音乐，来调节心情，让用户获得愉悦的体验。";
    label1.numberOfLines = 0;
    label1.font = [UIFont systemFontOfSize:15];
    //label1.backgroundColor = [UIColor whiteColor];
    label1.textColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(120*KWidthScale, 20+375*KHeightScale/7+190*KHeightScale, 375*KWidthScale-240*KWidthScale, 40*KHeightScale)];
    //label2.backgroundColor = [UIColor whiteColor];
    label2.textColor = [UIColor whiteColor];
    label2.font =[UIFont systemFontOfSize:16];
    label2.font = [UIFont systemFontOfSize:16 weight:1];
    label2.text =@"     免责声明";
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(50*KWidthScale, 20+375*KWidthScale/7+240*KHeightScale, 375*KWidthScale-100*KWidthScale, 230*KHeightScale)];
    //label3.backgroundColor = [UIColor whiteColor];
    label3.textColor = [UIColor whiteColor];
    label3.text = @"       本应用软件所有内容，包括文字、图片、音乐、以及版式设计均来源于网络，访问者可以将本应用提供的内容或服务用于个人学习、研究或者鉴赏，以及其他非商业性或非营利性用途，但同时应遵守著作权法及其他相关法律的规定。除此之外，降本应用任何内容或服务用于其他用途时，须征得本应用及相关权利人的书面许可，并支付报酬。\n       本应用内容原作者如不愿意在本应用刊登内容，请及时通知本应用，予以删除。";
    label3.numberOfLines =0;
    label3.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(50*KWidthScale, 20+375*KWidthScale/7+560*KHeightScale,  375*KWidthScale-100*KWidthScale, 30*KHeightScale)];
    //label4.backgroundColor = [UIColor whiteColor];
    label4.textColor = [UIColor whiteColor];
    label4.font = [UIFont systemFontOfSize:12];
    label4.text = @"     Copyright (c) 2015年 Hu. All rights reserved.";
    [self.view addSubview:label4];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doBackButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
