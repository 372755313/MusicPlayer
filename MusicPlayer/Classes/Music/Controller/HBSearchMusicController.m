//
//  HBSearchMusicController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/18.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBSearchMusicController.h"
#import "MusicDetailViewController.h"
#import "MusicDetailViewController.h"
#import "NAVHeaderBar.h"
#import "SongModel.h"
#import "HBApiTool+music.h"



//活动指示器
#import "RTSpinKitView.h"
//单例 播放器
#import "AVplay.h"

@interface HBSearchMusicController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)NAVHeaderBar *headerBarView;
@property(nonatomic,strong)NSMutableArray *keyWordArray;
@property(nonatomic,strong)NSMutableArray *songArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *resultArray;
@property (nonatomic,strong) NSMutableArray *sArray;
@property (nonatomic,strong) NSMutableArray *vArray;

//搜索显示视图
@property (nonatomic, weak) UIView *searchView;
//搜索显示视图中的tableView
@property (nonatomic, weak) UITableView *keyTableView;
//装点击下拉列表直接放歌曲的数组
@property (nonatomic,strong) NSMutableArray *ssongModelArray;


//后面的大tableview
@property (nonatomic,weak) UITableView *bigTableView;
//活动指示器
@property (nonatomic,weak) MONActivityIndicatorView *indicatorView;

@end

@implementation HBSearchMusicController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (MONActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
        indicatorView.numberOfCircles = 5;
        indicatorView.radius = 10;
        indicatorView.internalSpacing = 6;
        indicatorView.duration = 0.5;
        indicatorView.delay = 0.2;
        indicatorView.center = self.view.center;
        [self.view addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

//下拉搜框下面的托盘
-(UIView *)searchView
{
    if (_searchView == nil)
    {
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(67, 20+kWidth/7, kWidth-113, 0)];
        searchView.backgroundColor = [UIColor whiteColor];
        searchView.layer.shadowOpacity = 1.0;
        searchView.layer.shadowOffset = CGSizeMake(0, 1);
        searchView.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
        searchView.layer.shadowRadius=3.0;
        searchView.layer.cornerRadius =0.0;
        [self.view addSubview:searchView];
        _searchView = searchView;
    }
    return _searchView;
}

//下拉音乐搜索框
-(UITableView *)keyTableView
{
    if (_keyTableView == nil) {
        UITableView *keyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth-113, 0)];
        keyTableView.layer.shadowOpacity = 1.0;
        keyTableView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        keyTableView.layer.shadowColor = [[UIColor redColor] CGColor];
        keyTableView.layer.shadowRadius=1.0;
        keyTableView.layer.cornerRadius =0.0;
        self.automaticallyAdjustsScrollViewInsets = false;
        keyTableView.dataSource = self;
        keyTableView.delegate = self;
        _keyTableView = keyTableView;
        [self.searchView addSubview:keyTableView];
    }
    return _keyTableView;
}

-(UITableView *)bigTableView
{
    if (_bigTableView == nil)
    {
        UITableView *bigTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20+(kWidth/7), kWidth,0)];
        bigTableView.backgroundColor = [UIColor whiteColor];
        bigTableView.dataSource = self;
        bigTableView.delegate = self;
        [self.view addSubview:bigTableView];
        _bigTableView = bigTableView;
    }
    return _bigTableView;
}

//中间的搜索框
- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        //设置搜索栏
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        [searchBar setTintColor:[UIColor redColor]];
        [searchBar setTranslucent:YES];
        [searchBar setShowsScopeBar:YES];
        [searchBar setSearchResultsButtonSelected:YES];
        [searchBar setShowsCancelButton:NO];
        searchBar.placeholder = @"点击搜索音乐";
        searchBar.delegate = self;
        [self.headerBarView addSubview:searchBar];
        _searchBar = searchBar;
    }
    return _searchBar;
}

//导航栏
- (NAVHeaderBar *)headerBarView
{
    if (_headerBarView == nil) {
        NAVHeaderBar *headerBarView = [[NAVHeaderBar alloc] init];
        headerBarView.backgroundColor = [UIColor blackColor];
        [headerBarView.rightButton addTarget:self action:@selector(searchMusicButton:) forControlEvents:UIControlEventTouchUpInside];
        [headerBarView.leftButton addTarget:self action:@selector(doBackButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:headerBarView];
        _headerBarView = headerBarView;
    }
    return _headerBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.resultArray = [[NSMutableArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    self.sArray = [[NSMutableArray alloc] init];
    self.vArray = [[NSMutableArray alloc] init];
    self.keyWordArray = [[NSMutableArray alloc] init];
    self.songArray = [[NSMutableArray alloc] init];
    self.ssongModelArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak __typeof(&*self)weakSelf = self;
    

    [self.bigTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(20+(kWidth/7));
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@0);
    }];
    [self.view addSubview:self.indicatorView];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(67);
        make.top.equalTo(weakSelf.view).offset(20+kWidth/7);
        make.width.equalTo(@(kWidth-113));
        make.height.equalTo(@0);
    }];
    
    
    //修改了搜索栏的背景色为透明
    for (UIView *view in self.searchBar.subviews) {
        
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    
    //设置表示图

    [self.headerBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(20);
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@(kWidth/7));
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(50);
        make.top.equalTo(weakSelf.headerBarView);
        make.width.equalTo(@(kWidth-90));
        make.height.equalTo(@(kWidth/7));
    }];
    
}

#pragma -mark 文字发生了就会改变 写了中文字
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![searchText  isEqual: @""] )
    {
        [self loadData];

    }else if([searchText isEqual:@""]){
        [self recoverList];
    }
    
}


#pragma -mark 点击开始编辑时 触发的方法 1.
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    
    NSLog(@"shuould begin");
    return YES;
}

#pragma -mark 点击开始编辑时 触发的方法 2.
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    //searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    
    NSLog(@"did begin");
}

//编辑完了的触发方法
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"did end");
    searchBar.showsCancelButton = NO;

    
}

#pragma -mark 点击搜索框的搜索按钮触发方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search clicked");
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancle clicked");
    [self.searchBar resignFirstResponder];//回收键盘
    _searchBar.text = @"";

}




#pragma -mark 网络请求 解析
-(void)loadData
{
    __weak __typeof(&*self)weakSelf = self;
    [HBApiTool HBGetMusicSearchListWithText:_searchBar.text
                                    success:^(NSDictionary *dict) {
//                                        NSLog(@"---搜索框--%@",dict);
                                        [weakSelf.resultArray removeAllObjects];
                                        [weakSelf.keyWordArray removeAllObjects];
                                        [weakSelf.songArray removeAllObjects];
                                        
                                        NSDictionary *dataDic = [dict objectForKey:@"data"];
                                        [weakSelf.keyWordArray addObjectsFromArray: [dataDic objectForKey:@"keyword"]];
                                        [weakSelf.songArray addObjectsFromArray: [dataDic objectForKey:@"song"]];
                                    
                                        //传值
                                        [weakSelf.resultArray addObjectsFromArray:self.keyWordArray];
                                        [weakSelf.resultArray addObjectsFromArray:self.songArray];
                                        [weakSelf.keyTableView reloadData];
                                        [self popSearchList];
                                        [self recoverMusicList];
            
                                    } failure:^(NSError *error) {
                                        
                                    }];
}

//弹出列表
- (void)popSearchList
{
    //弹出下拉列表下面的视图
    CGRect view_frame = self.searchView.frame;
    view_frame.size.height = self.resultArray.count*44;
    CGRect frame = self.keyTableView.frame;
    frame.size.height = self.resultArray.count*44;
    [UIView animateWithDuration:0.2 animations:^{
        self.searchView.frame = view_frame;
        self.keyTableView.frame =frame ;
    }];

}

//弹出最下面的大音乐列表
- (void)popBigMuSicList
{
    CGRect frame = self.bigTableView.frame;
    frame.size.height = KHeight-20-(kWidth/7);
    [UIView animateWithDuration:0.01 animations:^{
        self.bigTableView.frame = frame;
    }];
}

//收回big音乐列表
- (void)recoverMusicList
{
    CGRect frame = self.bigTableView.frame;
    frame.size.height = 0;
    [UIView animateWithDuration:0.01 animations:^{
        self.bigTableView.frame =frame ;
    }];
}

//收回列表
- (void)recoverList
{
    //弹出下拉列表下面的视图
    CGRect view_frame = self.searchView.frame;
    view_frame.size.height = 0;
    //弹出keytableview
    CGRect frame = self.keyTableView.frame;
    frame.size.height = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.frame = view_frame;
        self.keyTableView.frame =frame ;
//        self.searchView.hidden = YES;
    }];
}

//tableView的两个代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _keyTableView)
    {
        return self.resultArray.count;
    }else if (tableView == _bigTableView){
        return self.dataArray.count;
    }
    return 0;
    
}


#pragma -mark cell行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual: _keyTableView])
    {
        return 44;
    }
    else if ([tableView isEqual: _bigTableView])
    {
        return 44;
    }
    
    return 0;
}

//cell复用方法
#pragma -mark
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当等于大的视图时
    if (tableView == _bigTableView)
    {
        static NSString *Identifiel = @"BigCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifiel];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifiel];
            [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor]; //边框颜色
        }
        
        NSDictionary *dict = self.dataArray[indexPath.row];
        cell.textLabel.text = [dict objectForKey:@"song_name"];
        cell.detailTextLabel.text = [dict objectForKey:@"singer_name"];
        
        return cell;
        
        
    }else if (tableView == _keyTableView){
        
        static NSString *Identifiel = @"KeyCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifiel];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifiel];
            cell.backgroundColor = [UIColor colorWithRed:249/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        }
        
        NSDictionary *dic = self.resultArray[indexPath.row];
        if ([dic objectForKey:@"val"]) {
            cell.textLabel.text = [dic objectForKey:@"val"];
        }else if ([dic objectForKey:@"name"]){
            cell.textLabel.text = [dic objectForKey:@"name"];
            cell.detailTextLabel.text = [dic objectForKey:@"singer_name"];
        }
        
        
        return cell;
        
    }
    return nil;
    
}


#pragma -mark 选中单元格的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.keyTableView)
    {
        [self recoverList];
        __weak __typeof(&*self)weakSelf = self;
        NSDictionary *dict = self.resultArray[indexPath.row];
        if ([dict objectForKey:@"val"]) {
            
            [self.indicatorView startAnimating];
            [HBApiTool hbMusicGet:[dict objectForKey:@"val"] success:^(NSDictionary *dic) {
//                NSLog(@"-dic--%@-",dic);
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:[dic objectForKey:@"data"]];
                [weakSelf.bigTableView reloadData];
                [self popBigMuSicList];
                [self.indicatorView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"cuowu");
            }];
        }else if ([dict objectForKey:@"name"]){
            //跳转播音乐
            [HBApiTool hbMusicGet:[dict objectForKey:@"name"] success:^(NSDictionary *dic) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray addObjectsFromArray:[dic objectForKey:@"data"]];
                [weakSelf.bigTableView reloadData];
                [self popBigMuSicList];
                [self.indicatorView stopAnimating];
            } failure:^(NSError *error) {
                NSLog(@"错误");
            }];
            
        }
    }else if (tableView == self.bigTableView){
        NSLog(@"big");
        MusicDetailViewController *musicVc = [[MusicDetailViewController alloc] init];
        musicVc.itemArray = [[NSMutableArray alloc] init];
        [musicVc.itemArray addObjectsFromArray:self.dataArray];
        musicVc.itemNumber = indexPath.row;
        [self.navigationController pushViewController:musicVc animated:YES];
    }

}



#pragma -mark 点击返回
-(void)doBackButton
{
    NSLog(@"+++");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
}

#pragma -mark 点击放大镜搜索的方法
-(void)searchMusicButton:(id)searchButton
{
    [self recoverList];
    [self.searchBar resignFirstResponder];//回收键盘
    
    if ([_searchBar.text  isEqual: @""])
    {
        return;
    }
    
    __weak __typeof(&*self) weakSelf = self;
    [self.indicatorView startAnimating];
    [HBApiTool HBGetDidMusicListWithText:_searchBar.text success:^(NSDictionary *dict) {
//        NSLog(@"---%@",dict);
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:[dict objectForKey:@"data"]];
        [weakSelf.bigTableView reloadData];
        [self popBigMuSicList];
        [self.indicatorView stopAnimating];
        
    } failure:^(NSError *error) {
        NSLog(@"错误");
    }];
    
}

//tableview的cell有任何的滑动将执行的方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"开始拖动");

    [self.searchBar resignFirstResponder];//回收键盘
}




@end
