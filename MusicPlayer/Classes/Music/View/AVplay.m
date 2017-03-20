
//
//  AVplay.m
//  MusicPlayer-B
//
//  Created by lanou on 15/7/17.
//  Copyright (c) 2015年 www.lanou3g.com. All rights reserved.
//

#import "AVplay.h"
#import "SSongModel.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CircleImageModel.h"
@class MusicDetailViewController;

#define picURL @"http://lp.music.ttpod.com/pic/down?artist="

@interface AVplay ()

@property (nonatomic,strong) UIImageView *circleImageView;
@property (nonatomic,strong) UIImageView *bacImageView;
@property (nonatomic,strong) NSMutableArray *circleImageArray;

@end
@implementation AVplay
//GCD方式
+(AVplay *)shareInstance
{
    static AVplay *musicPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlayer = [[AVplay alloc] init];
    });
    return musicPlayer;
}

-(void)putItemsArray:(NSMutableArray *)itemsArray andItemNumber:(NSInteger)itemNumber//设置播放列表
{
    self.itemsArray = itemsArray;
    self.itemNumber = itemNumber;
    
    NSArray *urlArr = [self.itemsArray[self.itemNumber] objectForKey:@"url_list"];
    NSString *url = [urlArr[0] objectForKey:@"url"];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [self replaceCurrentItemWithPlayerItem:self.playerItem];
    //[self play];
   
}

-(void)nextItem:(BOOL)isPlay//下一曲
{
    NSArray *urlArr = [self.itemsArray[self.itemNumber] objectForKey:@"url_list"];
    NSString *url = [urlArr[0] objectForKey:@"url"];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [self replaceCurrentItemWithPlayerItem:self.playerItem];
    
//    //添加通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(itemPlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    if (isPlay)
    {
        [self play];
    }
}

-(void)lastItem:(BOOL)isPlay
{

    NSArray *urlArr = [self.itemsArray[self.itemNumber] objectForKey:@"url_list"];
    NSString *url = [urlArr[0] objectForKey:@"url"];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil ];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [self replaceCurrentItemWithPlayerItem:self.playerItem];

    if (isPlay)
    {
        [self play];
    }
}


#pragma -mark 暂停和播放
-(void)playAndPauseItem
{
    if (self.rate == 1.0)
    {
        [self pause];
        
    }
    else
    {
        [self play];
    }
    
}

#pragma -mark 单曲循环
-(void)singleCyclePlay
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];

    
    NSArray *urlArr = [self.itemsArray[self.itemNumber] objectForKey:@"url_list"];
    NSString *url = [urlArr[0] objectForKey:@"url"];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [self replaceCurrentItemWithPlayerItem:self.playerItem];
    
    //添加播放结束的通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidEndAndSingleCyle:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self play];
    
    
}

#pragma -mark 随机播放
-(void)randomPlay
{
    //移除通知
    NSArray *urlArr = [self.itemsArray[self.itemNumber] objectForKey:@"url_list"];
    NSString *url = [urlArr[0] objectForKey:@"url"];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    [self replaceCurrentItemWithPlayerItem:self.playerItem];
    
    //添加播放结束的通知
    [self play];
}

-(void)circulatePlay//循环播放
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(itemPlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
}



//- (void)itemPlayDidEnd:(NSNotification *)notification//循环播放的方法
//{
//    if ([notification.name isEqualToString:AVPlayerItemDidPlayToEndTimeNotification])
//    {
//        if (_num == 2)
//        {
//            [self nextItem:YES];
//        }
//        else if (_num == 1)
//        {
//            [self singleCyclePlay];
//        }
//        else if (_num == 0)
//        {
////            [self randomPlay:<#(SSongModel *)#>];
//        }
//      
//    }
//}


//-(void)playDidEndAndSingleCyle:(NSNotification *)notification//单曲循环
//{
//    if ([notification.name isEqualToString:AVPlayerItemDidPlayToEndTimeNotification])
//    {
//        if (_num == 2)
//        {
//            [self nextItem:YES];
//        }
//        else if (_num == 1)
//        {
//            [self singleCyclePlay];
//        }
//        else if (_num == 0)
//        {
////            [self randomPlay];
//        }
//   
//    }
//}

//-(void)playDidEndAndRandom:(NSNotification *)notification//随机播放
//{
//    if ([notification.name isEqualToString:AVPlayerItemDidPlayToEndTimeNotification])
//    {
//        if (_num == 2)
//        {
//            [self nextItem:YES];
//        }
//        else if (_num == 1)
//        {
//            [self singleCyclePlay];
//        }
//        else if (_num == 0)
//        {
////            [self randomPlay];
//        }
//    }
//}



@end
