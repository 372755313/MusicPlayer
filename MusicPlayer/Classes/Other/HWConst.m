//
//  HWConst.m
//  kt
//
//  Created by skywakerwei on 14-12-20.
//  Copyright (c) 2015年 skywakerwei. All rights reserved.
//

NSString * const MUSICAPIURL                = @"http://so.ard.iyyin.com/sug/sugAll?uid=864855027708611&f=f62&v=v8.0.1.2015062518&app=ttpod&utdid=U513PsD%2BHc8DAKmuOMqVZ4Ih&hid=3814331173461195&s=s200&alf=alf702008&imsi=460012710623114&tid=0&net=2&q=";
NSString * const MUSICLISTURL                =  @"http://so.ard.iyyin.com/s/song_with_out?uid=864855027708611&f=f62&app=ttpod&rom=vivo%252Fmsm8974%252Fmsm8974%253A4.3%252FJLS36C%252F156%253Auser%252Fdev-keys&hid=3814331173461195&alf=alf702008&cpu=msm8974&resolution=1080x1920&net=2&size=50&v=v8.0.1.2015062518&utdid=U513PsD%2BHc8DAKmuOMqVZ4Ih&s=s200&ram=2917328+kB&page=1&active=0&mid=vivo%2BX710L&splus=4.3%252F18&client_id=bb80bb5ddf789fd23acaa515b5ea592a&imsi=460012710623114&tid=0&cpu_model=Qualcomm+MSM+8974+%28Flattened+Device+Tree%29&q=";
NSString * const MUSICPICURL                 = @"http://lp.music.ttpod.com/pic/down?artist=";
NSString * const PICIDAPIURL                =  @"http://dili.bdatu.com/jiekou/album/a";

NSString * const APPID                      = @"1102331155";

NSString * const KZYWebURL                  = @"www.11ziyun.com";
NSString * const KZYAppScheme               = @"ziyun";
NSString * const KZYAppDescription          = @"com.ziyun.app";
NSString * const KZIYUN                     = @"http://www.11ziyun.com";


NSString * const KZYAPIUrl               = @"http://appclient.11ziyun.com";

//95 环境 外网访问地址
//NSString * const KZYAPIUrl               = @"http://61.183.151.86:3838/ZyServer";
//16 环境
//NSString * const KZYAPIUrl               = @"http://192.168.1.16:8080/ZyServer";

//高德地图KEY
NSString * const KSDKlbsKey                 = @"bf2c88441669ef0ee1b44e6e5ea8ab4c";

//qq平台
NSString * const kSDKQQAppID               = @"1105616798";
NSString * const kSDKQQAppKey              = @"cg7bSvpLHw5mhavp";

//新浪微博
NSString * const kSDKSinaAppKey            = @"4039062378 ";
NSString * const kSDKSinaSecret            = @"972233f892c08dba9898e9f19d281d91";


//微信sdk
NSString * const  kSDKWeiXinBundleID        = @"cn.brochina.zyapp";
NSString * const  kSDKWeiXinAppKey          = @"wxb6d3233d4c53d86b";
NSString * const  kSDKWeiXinAppSecret       = @"4e8826490589a0e2372b7f5b6682595e";


//环信
#ifdef DEBUG
NSString *const  kEasemobAppKey             = @"skywalkerwei#11ziyun";
NSString *const  kEasemobCS                 = @"kof";
#else
NSString *const  kEasemobAppKey             = @"18171015302#11ziyun";
NSString *const  kEasemobCS                 = @"zhzy_user";
#endif
NSString *const  kEasemobPwd                = @"123456";
NSString * const kEasemobIsLogin            = @"kEasemobIsLogin";

const NSInteger   kpaperNum                 = 500;
//是否开启http log
const BOOL        kISHTTPLog                = YES;
//是否开启弱密码校验
const BOOL        kISWeakPwd                = YES;

NSString * const kUPayMode                  = @"00";//银联支付模式:01测试 00正式

//-----------------------统计分析友盟-----------------------
NSString * const  kUMAnalyticsAppKey        = @"584f6651c895764b2f001709";
//584f6651c895764b2f001709
//-----------------------文本框允许输入内容-----------------------
NSString * const kAlphaNum                  = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n";
NSString * const kNumPoint                  = @".0123456789\n";

//登录通知
NSString * const  kUserDataLogIn            = @"NOTIFICATION_TG_USERDATA_LOGIN";
//退出通知
NSString * const  kUserDataLogOut           = @"NOTIFICATION_TG_USERDATA_LOGOUT";
//notice
NSString * const  kUserDataChange           = @"NOTIFICATION_TG_USERDATA_CHANGE";
//购物车数量
NSString * const  kCartNumChange            = @"NOTIFICATION_TG_CARTNUM_CHANGE";
//支付成功通知
NSString * const  kPayOutSuccessNotice      = @"NOTIFICATION_TG_PAY_OUT_SUCCESS";
//充值成功通知
NSString * const  kPayInSuccessNotice       = @"NOTIFICATION_TG_PAY_IN_SUCCESS";
//支付类型 1 支付 2 充值
NSString * const  kKTPayOrderType            = @"kKTPayOrderType";

NSString * const  kDownloadPic              = @"kDownloadPic";
NSString * const  kAcceptPush               = @"kAcceptPush";

NSString * const  kUserClientIP             = @"kUserClientIP";
NSString * const  kZYNetState               = @"kZYNetStatus";
// 客服电话
NSString * const  kKFPhoneNumber            = @"4000002519";


//首页HTML5
NSString * const kZYH5homeUrl               = @"static/h5source/html/ziyun.html";
//商品页面
NSString * const kZYH5productUrl            = @"app/goods/goods/h5Product?productId=";
//积分商城页面
NSString * const kZYH5PointShopUrl          = @"app/goods/goods/h5PointGoods";
NSString * const kZYH5PointExchangeUrl      = @"app/goods/goods/h5PointRecord";


NSString * const KZYlatitude                = @"KZYlatitude";
NSString * const KZYlongitude               = @"KZYlongitude";
NSString * const KZYLocation                = @"KZYLocation";


