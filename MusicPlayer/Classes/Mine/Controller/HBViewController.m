//
//  HBViewController.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/12/14.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBViewController.h"
#import "UMSocialData.h"
#import "UMSocial.h"
#import "UMSocialSnsService.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "WeiboUser.h"
#import "ZYTool.h"
#import "HBApiTool.h"

//高德sdk
#import "AmapSlampLocationTool.h"
#import "MJRefresh.h"
#import <MapKit/MapKit.h>

@interface HBViewController ()<UMSocialUIDelegate>

@property (nonatomic,weak)UIButton *sinaBtn;
@property (nonatomic,weak)UIButton *qqBtn;
@property (nonatomic,weak)UIButton *weixinBtn;
@property (nonatomic,weak)UIView *bottomView;


@end

@implementation HBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    [self updataCoordinates];
}

- (void)loadData{
    __weak __typeof(&*self)weakSelf = self;
    
//    [HBApiTool ZYgetOfflineExperienceStore:[NSString stringWithFormat:@"%@",[ZYUserDefaults objectForKey:KZYlatitude]] longitude:[NSString stringWithFormat:@"%@",[ZYUserDefaults objectForKey:KZYlongitude]] Success:^(NSArray *array) {
//
//    } failure:^(NSString *error) {
//        
//    }];
}

#pragma mark - 获取坐标
- (void)updataCoordinates{
    __weak __typeof(&*self)weakSelf = self;
    if(!([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied))
    {
        if (![ZYUserDefaults boolForKey:KZYLocation]) {
            [weakSelf loadData];
            return ;
        }
        [ZYUserDefaults removeObjectForKey:KZYlatitude];
        [ZYUserDefaults removeObjectForKey:KZYlongitude];
//        [weakSelf.mainScroller.mj_header endRefreshing];
        [ZYTool showAlerts:@"请前往设置->隐私打开紫云定位" Ok:^(id alerts) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
        } Cancel:^(id alerts) {
            
        }];
        [ZYUserDefaults setObject:@(0) forKey:KZYLocation];
        [ZYUserDefaults synchronize];
        [weakSelf loadData];
        
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Start" object:nil];
        [AmapSlampLocationTool getLocationCoordinate:^(NSDictionary *locDict, BOOL isNew) {
            DLog(@"地址是什么 = %@",locDict);
            [ZYUserDefaults setObject:[locDict objectForKey:@"latitude"] forKey:KZYlatitude];
            [ZYUserDefaults setObject:[locDict objectForKey:@"longitude"] forKey:KZYlongitude];
            [ZYUserDefaults setObject:@(1) forKey:KZYLocation];
            [ZYUserDefaults synchronize];
            [weakSelf loadData];
        } error:^(NSError *error) {
        }];
    }
}



- (void)setupUI
{
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithString:@"地图" target:self action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithString:@"分享" target:self action:@selector(btnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    NSMutableArray *BtnArr = [NSMutableArray array];

    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
    
    
    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaBtn setTitle:@"微博登录" forState:UIControlStateNormal];
    [sinaBtn setImage:[UIImage imageNamed:@"xinlang"] forState:UIControlStateNormal];
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"xinlang"] forState:UIControlStateNormal];
    sinaBtn.tag = UMSocialSnsTypeSina;
    [sinaBtn addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sinaBtn];
    _sinaBtn = sinaBtn;
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    qqBtn.tag = UMSocialSnsTypeMobileQQ;
    [bottomView addSubview:qqBtn];
    _qqBtn = qqBtn;
    
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [weixinBtn addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    weixinBtn.tag = UMSocialSnsTypeWechatSession;
    [bottomView addSubview:weixinBtn];
    _weixinBtn = weixinBtn;
    
    [BtnArr addObject:weixinBtn];
    [BtnArr addObject:qqBtn];
    [BtnArr addObject:sinaBtn];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-80);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(44*BtnArr.count+(BtnArr.count-1)*40, 44));
    }];
    [self makeEqualWidthViews:BtnArr inView:bottomView LRpadding:0 viewPadding:40];

    
    
}

-(void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding
{
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-LRpadding);
    }];
}


//点击第三方登录
- (void)onClickLogin:(UIButton *)button
{
    NSString *snsName = nil;
    switch (button.tag) {
        case UMSocialSnsTypeSina:
            snsName = UMShareToSina;
            break;
        case UMSocialSnsTypeMobileQQ:
            snsName = UMShareToQQ;
            break;
        case UMSocialSnsTypeWechatSession:
            snsName = UMShareToWechatSession;
            break;
        default:
            break;
    }
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response) {
        NSLog(@"unOauth response is %@",response);
        
    }];
    __weak __typeof(&*self)weakSelf = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsName];
            DLog(@"username is %@, uid is %@, token is %@ url is %@ openId is %@",snsAccount.userName,snsAccount.openId,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
            DLog(@"详细信息  %@ -----",response.thirdPlatformUserProfile);
            [weakSelf snsName:snsName snsAccount:snsAccount response:response.thirdPlatformUserProfile];
            
        }});
}

- (void)snsName:(NSString *)snsName snsAccount:(UMSocialAccountEntity *)snsAccount response:(NSDictionary *)response
{
    NSDictionary *parmes ;
    if ([snsName isEqualToString:UMShareToQQ]) {
        parmes = @{@"openid":[NSString stringWithFormat:@"%@",snsAccount.openId],
                   @"nickname":[NSString stringWithFormat:@"%@",snsAccount.userName],
                   @"url":snsAccount.iconURL,
                   @"gender":[response objectForKey:@"gender"],
                   @"province":[response objectForKey:@"province"],
                   @"city":[response objectForKey:@"city"]};
        
    }else if ([snsName isEqualToString:UMShareToSina]){
        WeiboUser *user = (WeiboUser *)response;
        parmes = @{@"openid":[NSString stringWithFormat:@"%@",snsAccount.usid],
                   @"nickname":[NSString stringWithFormat:@"%@",snsAccount.userName],
                   @"url":snsAccount.iconURL,
                   @"address":[NSString stringWithFormat:@"%@",user.location]};
        
    }else if ([snsName isEqualToString:UMShareToWechatSession]){
        parmes = @{@"openid":[NSString stringWithFormat:@"%@",snsAccount.unionId],
                   @"nickname":[NSString stringWithFormat:@"%@",snsAccount.userName],
                   @"url":snsAccount.iconURL,
                   @"province":[response objectForKey:@"province"],
                   @"city":[response objectForKey:@"city"]};
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DLog(@"登陆成功");
    });

}


- (void)btnAction
{
    //分享内嵌文字
    NSString *shareText = @"测试分享文字";
    //分享内嵌图片
    UIImage *shareImage = [UIImage imageNamed:@"icon"];
    // 分享组顺序 按照需求自己相对应修改
    NSArray *arr =  [NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone, nil];
    
    // 自定义title
    [UMSocialData defaultData].extConfig.qqData.title = @"测试";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"测试";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"测试";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"测试";
    
    // 设置点击分享内容跳转链接
    //    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMAnalyticsAppKey
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:arr
                                       delegate:self];
    
    // 测试SDK在控制台的输出后能看到相应的错误码。
    [UMSocialData openLog:YES];
}

- (void)leftBtnAction
{
    
}



@end
