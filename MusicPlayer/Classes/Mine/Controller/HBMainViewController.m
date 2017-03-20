//
//  HBMainViewController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBMainViewController.h"
#import "MusicDetailViewController.h"
#import "HBGuanYuViewController.h"
#import "PicDetailViewController.h"
#import "HBApiTool+music.h"
#import "HBHeaderBarView.h"
#import "HBPicCell.h"
#import "HBDockView.h"
#import "DockView.h"
#import "HBSearchMusicController.h"
#import "HBPicDetailViewController.h"
#import "MWPhotoBrowser.h"

@interface HBMainViewController ()<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>

@property (nonatomic,weak) MONActivityIndicatorView *indicatorView;
@property (nonatomic,weak) HBHeaderBarView *headerV;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) DockView *dockV;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,strong) NSMutableArray *MwPhotos;

@end

@implementation HBMainViewController

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.dockV.hidden == NO) {
        __weak __typeof(&*self)weakSelf = self;
        CGRect frame = self.dockV.frame;
        frame.origin.y += 110;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.dockV.frame = frame;
            weakSelf.dockV.hidden = YES;
        }];
    }
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)loadData
{
    __weak __typeof(&*self)weakSelf = self;
    _pageNum = 1;
    [HBApiTool get:_pageNum success:^(NSDictionary *dict) {
        NSMutableArray *array = [dict objectForKey:@"album"];
        NSLog(@"---------%@",array);
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        NSLog(@"error---%@",error);
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    [self loadReferView];
    
}

//刷新
- (void)loadReferView
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadMoreData
{
    __weak __typeof(&*self)weakSelf = self;
    _pageNum++;
    [HBApiTool get:_pageNum success:^(NSDictionary *dict) {
        NSMutableArray *array = [dict objectForKey:@"album"];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"error---%@",error);
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
}


- (void)setupUI
{
    self.dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏
    __weak __typeof(&*self)weakSelf = self;
    HBHeaderBarView *headerV = [HBHeaderBarView view:YES Option:^{
        NSLog(@"回调成功");
        HBSearchMusicController *searchVc = [[HBSearchMusicController alloc] init];
        [weakSelf.navigationController pushViewController:searchVc animated:YES];
        
    }];
    _headerV = headerV;
    [self.view addSubview:headerV];
    
    [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(20);
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@(KHeight/7));
    }];
    
    NSInteger barHeight = 20+(kWidth/7);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(barHeight);
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@(KHeight-barHeight-49));
    }];
    
    self.dockV.hidden = YES;
    self.dockV.userInteractionEnabled = YES;

    [self.dockV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(0);
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@(110+KHeight));
    }];
    
}

- (DockView *)dockV
{
    __weak __typeof(&*self)weakSelf = self;
    if (_dockV == nil) {
        DockView *dockV = [[DockView alloc] init];
        dockV.backgroundColor = [UIColor clearColor];
        [self.view addSubview:dockV];
        _dockV = dockV;
        dockV.alphaOption = ^{
            CGRect frame = weakSelf.dockV.frame;
            frame.origin.y += 110;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.dockV.frame = frame;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.dockV.hidden = YES;
                });
            }];
        };
        dockV.dockOption = ^(kkDock doing){
            
            switch (doing) {
                case kkPicSelect:
                {
                    NSLog(@"1");
                }
                    break;
                    
                case kkMusicDone:
                {
                    NSLog(@"2");
                    HBSearchMusicController *hbMusicVc = [[HBSearchMusicController alloc] init];
                    [self.navigationController pushViewController:hbMusicVc animated:YES];

                }
                    break;
                    
                case kkClearCache:
                {
                    NSLog(@"3");

                }
                    break;
                    
                case kkAbout:
                {
                    NSLog(@"4");

                }
                    break;
                default:
                    break;
            }
        };
    }
    return _dockV;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBPicCell *cell = [HBPicCell cellWithTable:tableView];
    cell.dic = self.dataArray[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWidth;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"di--%ld",indexPath.row);
    self.navigationController.navigationBar.hidden = NO;
    
    __weak __typeof(&*self)weakSelf = self;
    NSString *str = [self.dataArray[indexPath.row] objectForKey:@"id"];
    [HBApiTool HBGetPicBrowserWithNum:[str integerValue] success:^(NSDictionary *dict) {
        NSLog(@"--dict%@",dict);
        
        [self pushPhoto:dict];
        
    } failure:^(NSError *error) {
        
    }];
    
//    HBPicDetailViewController *picVc = [[HBPicDetailViewController alloc] init];
//    picVc.picID = [self.dataArray[indexPath.row] objectForKey:@"id"];
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController pushViewController:picVc animated:YES];
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
    [browser setCurrentPhotoIndex:0];
    browser.displayNavArrows = NO;
    browser.alwaysShowControls = NO;
    
    browser.enableGrid = YES;
    browser.startOnGrid = YES;
    browser.autoPlayOnAppear = NO;
    browser.displayActionButton = NO;
    [browser.view setFrame:CGRectMake(0, -20, kWidth, KHeight)];
    [self.navigationController pushViewController:browser animated:YES];
    [browser.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    
    //    [self.navigationController pushViewController:browser animated:YES];
    
    [browser showNextPhotoAnimated:NO];
    [browser showPreviousPhotoAnimated:YES];
    
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
