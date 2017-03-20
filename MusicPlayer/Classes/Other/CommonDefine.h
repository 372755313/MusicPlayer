//
//  CommonDefine.h
//  LastRow
//
//  Created by lanou on 15/6/22.
//  Copyright (c) 2015年 Yan. All rights reserved.
//

#ifndef LastRow_CommonDefine_h
#define LastRow_CommonDefine_h

// 获取屏幕尺寸
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
//常用
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight  [UIScreen mainScreen].bounds.size.height
#define KHeightS   ([UIScreen mainScreen].bounds.size.height-64)
#define KHeightL  ([UIScreen mainScreen].bounds.size.height-64-49)
#define KMainScreen  [UIScreen mainScreen].bounds
#define KAppliactionFrame  [[UIApplication sharedApplication] statusBarFrame]

// 适配比例
#define KHeightScale ([UIScreen mainScreen].bounds.size.height/667.)
#define KWidthScale ([UIScreen mainScreen].bounds.size.width/375.)

// bar高度
#define kTabbarHeight (40 / 667. * kScreenHeight)
#define kNavigationbarHeight (30 / 667. * kScreenHeight)
#define kNavigationbarRect  CGRectMake(0,0, kScreenWidth,kNavigationbarHeight)

//色调
// 2.获得RGB颜色
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HWColorA(r, g, b,c) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:c]

#define KBGColor   ([UIColor colorWithRed:255/255.0 green:250/250.0 blue:240/250.0 alpha:1.000])
#define KGrayColor ([UIColor colorWithWhite:0.375 alpha:1.000])
#define KSelectedColor ([UIColor colorWithRed:253/255.0 green:245/250.0 blue:230/250.0 alpha:1.000])

// 标题字体
#define kTitleFont [UIFont boldSystemFontOfSize:17]

//APPKEY
#define kAppKey @"507fcab25270157b37000010"

//Radio请求网址
#define KRadioUrl @"http://api2.pianke.me/ting/radio"
#define KRadioListUrl @"http://api2.pianke.me/ting/radio_list"

#define KDetailUrl @"http://api2.pianke.me/ting/radio_detail"
#define KDetailListUrl @"http://api2.pianke.me/ting/radio_detail_list"

// 当前网络状态
//结果说明：0-无连接   1-wifi    2-3G
//#define kNetState [[Reachability reachabilityWithHostName:@"www.apple.com"] currentReachabilityStatus]

#endif
