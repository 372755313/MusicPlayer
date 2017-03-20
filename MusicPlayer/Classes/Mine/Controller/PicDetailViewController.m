//
//  PicDetailViewController.m
//  MusicPlayer-B
//
//  Created by lanou on 15/7/22.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import "PicDetailViewController.h"
#import "PicModel.h"
#import "UIImageView+WebCache.h"


// 适配比例
#define KHeightScale ([UIScreen mainScreen].bounds.size.height/667.)
#define KWidthScale ([UIScreen mainScreen].bounds.size.width/375.)
@interface PicDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *picScrollView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) NSMutableArray *picArray;

@end

@implementation PicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.picArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.view.backgroundColor = [UIColor blackColor];
    //NSLog(@"--------------array---%@",self.picModelArray);
    

    
    //滚动视图
    self.picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375*KWidthScale, 667*KHeightScale)];
    self.picScrollView.backgroundColor = [UIColor blackColor];
    //可滚动的区域
    self.picScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*self.picModelArray.count, [UIScreen mainScreen].bounds.size.height);
    
    for (int i=0; i<self.picModelArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(375*KWidthScale*i, 0, 375*KWidthScale, 667*KHeightScale)];
        PicModel *pModel = [[PicModel alloc] init];
        pModel = self.picModelArray[i];
        NSURL *url = [NSURL URLWithString:pModel.url];
        [imageView sd_setImageWithURL:url];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = NO;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*KWidthScale, 500*KHeightScale, 200*KWidthScale, 30*KHeightScale)];
        //label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
        label.text = pModel.title;
        [imageView addSubview:label];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(KWidthScale, 540*KHeightScale, 375*KWidthScale, 100*KHeightScale)];
        textView.backgroundColor = [UIColor blackColor];
        textView.text = pModel.content;
        textView.textColor = [UIColor whiteColor];
        textView.autoresizesSubviews = YES;
        [imageView addSubview:textView];
        
        
        [self.picScrollView addSubview:imageView];
        self.picScrollView.pagingEnabled = YES;
        self.picScrollView.bounces = NO;
        self.picScrollView.delegate = self;
        self.picScrollView.showsHorizontalScrollIndicator=NO;
        //self.picScrollView.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        
    }
    
    [self.view addSubview:self.picScrollView];
    
    //左边logo
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 375*KWidthScale/3, 375*KWidthScale/7)];
    //leftLabel.backgroundColor = [UIColor purpleColor];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.text = @"  图 · 乐";
    leftLabel.font = [UIFont systemFontOfSize:22 weight:10];
    [self.view addSubview:leftLabel];
    
    //返回按钮
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(300*KWidthScale, 20, 375*KWidthScale/7, 375*KWidthScale/7);
    [self.backButton setImage:[UIImage imageNamed:@"guanyu-fanhui.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(doBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
 
    
    
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
