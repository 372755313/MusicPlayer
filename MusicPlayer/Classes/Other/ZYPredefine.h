//
//  ZYPredefine.h
//  ziyun
//
//  Created by zy on 16/5/13.
//  Copyright © 2016年 zy. All rights reserved.
//

#ifndef __ZY_PREDEFINE_H__
#define __ZY_PREDEFINE_H__

//颜色
#define KpriceRed [UIColor colorWithRed:219/255.0 green:50/255.0 blue:57/255.0 alpha:1]
#define KlineGray [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]
#define KOrange [UIColor colorWithRed:225/255.0 green:91/255.0 blue:65/255.0 alpha:1]
#define KGray   [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]

#define ZYNotificationCenter [NSNotificationCenter defaultCenter]
#define ZYUserDefaults [NSUserDefaults standardUserDefaults]


#define kCartsObjIdentList  [kDirDoc stringByAppendingPathComponent:@"kCartsObjIdentList.plist"]

//
#define ZYH5Url(url) [KZYAPIUrl stringByAppendingPathComponent:url]



#endif
