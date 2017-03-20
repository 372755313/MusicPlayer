
//  MusicDetailViewController.m
//  MusicPlayer-B
//
//  Created by lanou on 15/7/15.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "AVplay.h"
#import "CircleImageModel.h"
#import "Reachability.h"
#import "CommonDefine.h"
#import "HBApiTool+music.h"

@interface MusicDetailViewController ()
{
    BOOL _isPlay;
}
@property (nonatomic,assign) int num;
@property (nonatomic,assign) int flag;
//转动的图片
@property (nonatomic,strong) UIImageView *circleImageView;
//转动图片下的唱片
@property (nonatomic,weak) UIImageView *cpImageView;
//背景图
@property (weak, nonatomic) UIImageView *bacImageView;
//slide进度条
@property (strong,nonatomic) UISlider *slider;
//tempImage
@property (strong,nonatomic) UIImage *tempImage;

//透明背景蒙版视图
@property (strong,nonatomic) UIView *bacView;
//自定义导航栏
@property (nonatomic,weak) UIView *headerBarView;
@property (nonatomic,strong) UIButton *backButton;
//标题栏的歌名
@property (nonatomic,weak) UILabel *songNameLabel;
//标题栏的歌手
@property (nonatomic,weak) UILabel *singerNameLabel;

//定义转动图片的定时器
@property (nonatomic,strong) NSTimer *timer;//设置定时器
//观察者
@property (nonatomic,retain) id playbackTimeObserver;

//显示歌曲时间
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *currentTimeLabel;

@property (nonatomic,strong) NSMutableArray *circleImageArray;
@end

@implementation MusicDetailViewController



- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)initButton
{
    _num = 2;
    _isPlay = YES;
    [AVplay shareInstance].playModeNum = 0;
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(0, 20, kWidth/7+10, kWidth/7);
    
    UIImage *image=[UIImage imageNamed:@"back2.png"];
    //防止图片被控件渲染
    image =[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_backButton setBackgroundImage:image forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    __weak __typeof(&*self)weakSelf = self;
    NSArray *imageArray = @[@"shunxuxunhuan",@"shangyiqu",@"zanting",@"xiayiqu"];
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];

        if (i==0) {
            [btn addTarget:self action:@selector(moShiButton:) forControlEvents:UIControlEventTouchUpInside];
            _moShiButton = btn;
        }else if (i==1){
            [btn addTarget:self action:@selector(sYiQuButton:) forControlEvents:UIControlEventTouchUpInside];
            _sYiQuButton = btn;
        }else if (i==2){
            [btn addTarget:self action:@selector(boFangButton:) forControlEvents:UIControlEventTouchUpInside];
            _boFangButton = btn;
        }else if (i==3){
            [btn addTarget:self action:@selector(xYiQuButton:) forControlEvents:UIControlEventTouchUpInside];
            _xYiQuButton = btn;
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).offset((kWidth-330)/2+i*(70));
            make.top.equalTo(weakSelf.view.mas_bottom).offset(-90);
            make.width.equalTo(@(60));
            make.height.equalTo(@(60));
        }];
    }
    
    
}

#pragma mark 初始化标题头栏视图
-(void)initHeaderBarView
{
    UIView *headerBarView = [[UIView alloc] init];
    headerBarView.backgroundColor = [UIColor whiteColor];
    headerBarView.alpha = 0.2;
    headerBarView.layer.shadowOpacity = YES;
    headerBarView.layer.shadowOffset = CGSizeMake(0, 2);
    headerBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    headerBarView.layer.shadowRadius=1.0;
    [self.view addSubview:headerBarView];
    _headerBarView = headerBarView;
    
    __weak __typeof(&*self)weakSelf = self;
    [headerBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(20);
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@(kWidth/7));
    }];
    
    
    
    
    NSString *songName = [self.itemArray[_itemNumber] objectForKey:@"song_name"];
    NSString *singerName = [self.itemArray[_itemNumber] objectForKey:@"singer_name"];

    UILabel *songNameLabel = [[UILabel alloc] init];
    songNameLabel.text = songName;
    songNameLabel.textColor = [UIColor whiteColor];
    songNameLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:songNameLabel];
    _songNameLabel = songNameLabel;
    
    UILabel *singerNameLabel = [[UILabel alloc] init];
    singerNameLabel.text = singerName;
    singerNameLabel.textColor = [UIColor whiteColor];
    singerNameLabel.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:singerNameLabel];
    _singerNameLabel = singerNameLabel;
    
    [songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(65);
        make.top.equalTo(weakSelf.view).offset(24);
    }];
    
    [singerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(65);
        make.top.equalTo(weakSelf.view).offset(50);
    }];
    

}

#pragma mark 背景图片加转图初始化
-(void)initBacImageView
{
    UIImageView *bacImageView = [[UIImageView alloc]init] ;
    bacImageView.contentMode = UIViewContentModeScaleAspectFill;
    bacImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bacImageView];
    _bacImageView = bacImageView;
    
    __weak __typeof(&*self)weakSelf = self;
    [bacImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(20);
        make.width.equalTo(@(kWidth));
        make.height.equalTo(@(KHeight-20));
    }];
    
    //在背景图上面加入了模糊化效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, kWidth,KHeight-20);
    [_bacImageView addSubview:effectview];
    
    //放在中间
    UIImageView *cpImageView = [[UIImageView alloc] init];
    cpImageView.image = [UIImage imageNamed:@"changpian.png"];
    cpImageView.center = self.view.center;
    [self.view addSubview:cpImageView];
    _cpImageView = cpImageView;
    [cpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.width.equalTo(@(230));
        make.height.equalTo(@(230));
    }];
}

-(void)initCircleImageView
{
    self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375*KWidthScale/3+20, 375*KWidthScale/3+20)];
    self.circleImageView.center = _cpImageView.center;
    //self.circleImageView.backgroundColor = [UIColor whiteColor];
    [self.circleImageView.layer setMasksToBounds:YES];
    self.circleImageView.layer.cornerRadius = (375*KWidthScale/3+20)/2;
    [self.view addSubview:_circleImageView];
}

-(void)initSlider
{
    //进度条
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(35*KWidthScale, 520*KHeightScale,300*KWidthScale,30*KHeightScale)];
    self.slider.userInteractionEnabled = NO;
    self.slider.maximumTrackTintColor = [UIColor grayColor];
    self.slider.minimumTrackTintColor = [UIColor redColor];
    [self.slider setThumbImage:[UIImage imageNamed:@"yuanshixin.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.slider];
}

-(void)initSongTime
{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(340*KWidthScale, 530*KHeightScale, 30*KWidthScale, 10*KHeightScale)];
    self.timeLabel.font = [UIFont systemFontOfSize:10*KHeightScale];
    self.timeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.timeLabel];
    
    self.currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*KWidthScale, 530*KHeightScale, 30*KWidthScale, 10*KHeightScale)];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:10*KHeightScale];
    self.currentTimeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.currentTimeLabel];
    
}

- (void)loadPicData
{
    NSString *songName = [self.itemArray[_itemNumber] objectForKey:@"song_name"];
    NSString *singerName = [self.itemArray[_itemNumber] objectForKey:@"singer_name"];
    self.songNameLabel.text = songName;
    self.singerNameLabel.text = singerName;
    __weak __typeof(&*self)weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@%@",singerName,songName];
    [HBApiTool HBGetMusicPicWithText:str success:^(NSDictionary *dict) {
        
        NSDictionary *dic = [dict objectForKey:@"data"];
        NSString *picUrl = [dic objectForKey:@"singerPic"];
        [weakSelf.circleImageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
        [weakSelf.bacImageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
        
        //如果获取不到图片就在本地随机找一张放上去
        if (picUrl == NULL)
        {
            NSLog(@"请求到图片");
            weakSelf.circleImageView.image = weakSelf.circleImageArray[arc4random()%10];
            weakSelf.bacImageView.image = weakSelf.circleImageView.image;
        }
    } failure:^(NSError *error) {
        NSLog(@"错误");
    }];
    

}

- (void)setupUI
{
//        self.circleImageArray = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg"].mutableCopy;
    self.circleImageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [self.circleImageArray addObject:image];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(rotationAction) userInfo:nil repeats:YES];
    [self initBacImageView];
    [self initHeaderBarView];
    [self initButton];
    [self initCircleImageView];
    [self initSlider];
    [self initSongTime];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self loadPicData];
    
    
    //播放
    [[AVplay shareInstance] putItemsArray:self.itemArray andItemNumber:self.itemNumber];
    //添加观察者
    [[AVplay shareInstance].playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
     [self monitoringPlayback:[AVplay shareInstance].playerItem];// 监听播放状态

    
    // 注册添加播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    

   
}


#pragma -mark 播放结束的动作 通知----------------------------------------------------------------------------------------
- (void)playDidEnd:(NSNotification *)notification
{
    if ([notification.name isEqualToString:AVPlayerItemDidPlayToEndTimeNotification])
    {
        //移除监听播放状态
        [[AVplay shareInstance] removeTimeObserver:self.playbackTimeObserver];
        //移除通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//            [self.slider addTarget:self action:@selector(changeTime) forControlEvents:UIControlEventTouchUpInside];
        
      
        NSLog(@"歌曲放完了");
        
        //顺序循环
        if ([AVplay shareInstance].playModeNum == 2)
        {
            self.bacImageView.image = self.tempImage;
            self.itemNumber ++;
            if (self.itemNumber >= self.itemArray.count)
            {
                self.itemNumber = 0;
            }
            [AVplay shareInstance].itemNumber = self.itemNumber;
            [[AVplay shareInstance] nextItem:YES];
            [self loadPicData];
            
        }else if ([AVplay shareInstance].playModeNum == 1){

            [[AVplay shareInstance] singleCyclePlay];
            [self loadPicData];
        }else if ([AVplay shareInstance].playModeNum == 0){
            
            self.itemNumber = arc4random()%self.itemArray.count;
            [AVplay shareInstance].itemNumber = self.itemNumber;
            [[AVplay shareInstance] randomPlay];
            [self loadPicData];

        }
        [self monitoringPlayback:[AVplay shareInstance].playerItem];// 监听播放状态
//        [self.slider addTarget:self action:@selector(changeTime) forControlEvents:UIControlEventValueChanged];
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
}




- (void)moShiButton:(id)sender {
    //默认是随机播放
    [AVplay shareInstance].playModeNum++;
    if ([AVplay shareInstance].playModeNum == 3)
    {
        [AVplay shareInstance].playModeNum = 0;
    }
    
    if ([AVplay shareInstance].playModeNum == 1){
        [sender setImage:[UIImage imageNamed:@"danquxunhuan.png"] forState:UIControlStateNormal];
    }else if ([AVplay shareInstance].playModeNum == 2){
        [sender setImage:[UIImage imageNamed:@"shunxuxunhuan.png"] forState:UIControlStateNormal];
    }else if ([AVplay shareInstance].playModeNum == 0){
        [sender setImage:[UIImage imageNamed:@"suijibofang.png"] forState:UIControlStateNormal];
    }
    NSLog(@"num*-------%d",_num);

}
#pragma -mark 播放
- (void)playButtonAction
{
    if (_flag == 0)
    {
        [[AVplay shareInstance] play];

        [_timer setFireDate:[NSDate distantPast]];
    }
    else if(_flag == 1)
    {
        [[AVplay shareInstance] pause];

        [_timer setFireDate:[NSDate distantFuture]];
    }
}


#pragma -mark 上一曲
- (void)sYiQuButton:(id)sender
{
    self.bacImageView.image = self.tempImage;
    self.itemNumber --;
    if (self.itemNumber <= -1)
    {
        self.itemNumber = self.itemArray.count-1;
    }
    
    [AVplay shareInstance].itemNumber = self.itemNumber;
    
    //移除观察者
    [[AVplay shareInstance] removeTimeObserver:self.playbackTimeObserver];
    //播放上一曲
    [[AVplay shareInstance] lastItem:YES];
    [self loadPicData];

    [self monitoringPlayback:[AVplay shareInstance].playerItem];// 监听播放状态

    
}

#pragma -mark 下一曲
- (void)xYiQuButton:(id)sender
{

    self.bacImageView.image = self.tempImage;
    self.itemNumber ++;
    if (self.itemNumber >= self.itemArray.count)
    {
        self.itemNumber = 0;
    }
    [AVplay shareInstance].itemNumber = self.itemNumber;
    
    //移除观察者
    [[AVplay shareInstance] removeTimeObserver:self.playbackTimeObserver];
    //下一曲
    [[AVplay shareInstance] nextItem:YES];

    [self loadPicData];
    [self monitoringPlayback:[AVplay shareInstance].playerItem];// 监听播放状态
    
}
#pragma -mark 观察者模式-------------------------------------------------------------------
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        if ([AVplay shareInstance].playerItem.status == AVPlayerStatusReadyToPlay)
        {
            //[self monitoringPlayback:[AVplay shareInstance].playerItem];// 监听播放状态
            [[AVplay shareInstance] play];
            NSLog(@"----observer-----play");
            //[self.slider addTarget:self action:@selector(changeTime) forControlEvents:UIControlEventValueChanged];
            [[AVplay shareInstance].playerItem removeObserver:self forKeyPath:@"status"];
        }
        else if ([AVplay shareInstance].playerItem.status == AVPlayerStatusFailed)
        {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
}

#pragma -mark 时间转换 ----------------------------------------------------------------------------------------
- (NSString *)convertTime:(CGFloat)second
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1)
    {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:date];
    return showtimeNew;
}

//手动拖动滑块
- (void)changeTime
{
    CGFloat percent = self.slider.value/self.slider.maximumValue;
    CGFloat totalSecond = [AVplay shareInstance].playerItem.duration.value/[AVplay shareInstance].playerItem.duration.timescale;
    NSTimeInterval currentTime = totalSecond * percent;
    CMTime ctime = CMTimeMake(currentTime, 1);
    [[AVplay shareInstance].playerItem seekToTime:ctime];
    [[AVplay shareInstance] play];
}

#pragma -mark 观察/调节播放时长 ----------------------------------------------------------------------------------------
- (void)monitoringPlayback:(AVPlayerItem*)playerItem
{
    __block MusicDetailViewController *weakSelf = self;
    self.playbackTimeObserver = [[AVplay shareInstance] addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        CGFloat totalSecond = playerItem.duration.value/playerItem.duration.timescale;

        NSLog(@"current----%f",currentSecond);
        NSLog(@"totalSecond----%f",totalSecond);
     
        [weakSelf.slider setValue:(currentSecond/totalSecond) animated:YES];
        NSString *timeString = [weakSelf convertTime:currentSecond];
        NSString *totalTimeString = [weakSelf convertTime:totalSecond];

        weakSelf.currentTimeLabel.text = [NSString stringWithFormat:@"%@",timeString];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@",totalTimeString];
    }];
}
                                 
//调节时长
-(void)updateSliderValue:(CGFloat)currentSecond
{
    [self.slider setValue:currentSecond animated:YES];
}


- (void)boFangButton:(id)sender {
    
    _isPlay = !_isPlay;
    if (_isPlay == NO)
    {
        [sender setImage:[UIImage imageNamed:@"bof.png"] forState:UIControlStateNormal];
        [[AVplay shareInstance] pause];
        [_timer setFireDate:[NSDate distantFuture]];
        
    }
    else if (_isPlay == YES)
        {

            [sender setImage:[UIImage imageNamed:@"zanting.png"] forState:UIControlStateNormal];
            [[AVplay shareInstance] play];
            [_timer setFireDate:[NSDate distantPast]];
        }
        
    
}



-(void)backButton:(id*)button
{
    //[self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma -mark 定时器方法 -----------------------------------------------------------------------------
- (void)rotationAction
{
    self.circleImageView.transform = CGAffineTransformRotate(self.circleImageView.transform,M_PI/1800);;
}

//音乐播放器后台播放
-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
//    if (kNetState == 0)
//    {
//        [self waitForNet];
//    }
    
}

//网络判断
#pragma -mark 无网络等待
-(void)waitForNet
{
    //创建一个子线程来做数据请求
    dispatch_queue_t downLoadQueue = dispatch_queue_create("downLoad", NULL);
    
    __block MusicDetailViewController *weakSelf = self;
    //在线程队列里面创建一个子线程
    dispatch_async(downLoadQueue, ^{
        while (1)
        {
//            if (kNetState != 0)
//            {
//                break;
//            }
        }
        [[AVplay shareInstance] putItemsArray:weakSelf.itemArray andItemNumber:weakSelf.itemNumber];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[AVplay shareInstance].program.webview_url]];
//        [weakSelf.webView loadRequest:request];
        //返回主线程更新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
//            weakSelf.playView.titleLabel.text = [AVplay shareInstance].program.programtitle;
//            [weakSelf.playView.imageView sd_setImageWithURL:[NSURL URLWithString:[AVplay shareInstance].program.coverimg]];
            //添加观察者
            [[AVplay shareInstance].playerItem addObserver:weakSelf forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//            [weakSelf.scrollView addSubview:weakSelf.playView];
//            [weakSelf.scrollView addSubview:weakSelf.webView];
            
//            [SVProgressHUD dismiss];
        });
    });
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent
{
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype)
        {
                
            case UIEventSubtypeRemoteControlPause:
                [self boFangButton:self.boFangButton];
                break;
                
            case UIEventSubtypeRemoteControlPlay:
                [self boFangButton:self.boFangButton];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self xYiQuButton:self.xYiQuButton];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                [self sYiQuButton:self.sYiQuButton];
                break;
                
            default:
                break;
        }
    }
}



@end
