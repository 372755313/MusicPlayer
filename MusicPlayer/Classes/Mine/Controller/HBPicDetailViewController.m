//
//  HBPicDetailViewController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/20.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBPicDetailViewController.h"
#import "PicModel.h"
#import "UIImageView+WebCache.h"
#import "MWPhotoBrowser.h"
#import "HBApiTool+music.h"

// 适配比例
#define KHeightScale ([UIScreen mainScreen].bounds.size.height/667.)
#define KWidthScale ([UIScreen mainScreen].bounds.size.width/375.)
@interface HBPicDetailViewController ()<UIScrollViewDelegate,MWPhotoBrowserDelegate>
@property (nonatomic,strong) UIScrollView *picScrollView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) NSMutableArray *picArray;
@property (nonatomic,strong) NSMutableArray *MwPhotos;

@end

@implementation HBPicDetailViewController

- (void)loadData
{
    __weak __typeof(&*self)weakSelf = self;
    [HBApiTool HBGetPicBrowserWithNum:[self.picID integerValue] success:^(NSDictionary *dict) {
        NSLog(@"--dict%@",dict);
        
//        [weakSelf.MwPhotos addObjectsFromArray:[dict objectForKey:@"picture"]];
        [self pushPhoto:dict];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)pushPhoto:(NSDictionary *)data
{
    _MwPhotos = [NSMutableArray array];
   
    NSArray *array = [data objectForKey:@"picture"];
    NSInteger index = array.count;
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        NSString *url = [dic objectForKey:@"url"];
         MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        [_MwPhotos addObject:photo];
    }

    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.zoomPhotosToFill = YES;
    [browser setCurrentPhotoIndex:index];
    browser.displayNavArrows = NO;
    browser.alwaysShowControls = NO;
    
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    browser.displayActionButton = NO;
    [browser.view setFrame:CGRectMake(0, -20, kWidth, KHeight)];
    [self.navigationController pushViewController:browser animated:YES];
    [browser.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    
//    [self.navigationController pushViewController:browser animated:YES];
    
    [browser showNextPhotoAnimated:NO];
    [browser showPreviousPhotoAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.picArray = [[NSMutableArray alloc] initWithCapacity:10];

    [self loadData];
    
    
    
}

-(void)doBackButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _MwPhotos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _MwPhotos.count) {
        return [_MwPhotos objectAtIndex:index];
    }
    return nil;
}
- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
    NSString *title = [NSString stringWithFormat:@"%@/%@",@(index),@(_MwPhotos.count)];
    return title;
}

@end
