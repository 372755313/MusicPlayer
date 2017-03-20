//
//  ZYUser
//  skywakerwei
//
//  Created by skywakerwei on 15/6/15.
//  Copyright (c) 2015年 skywakerwei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
#import "Singleton.h"


typedef enum{
    kGenderNone = 0,
    kGenderMan,
    kGenderWoman,
    kGenderOther
}kGender;

@interface ZYUser : NSObject<NSCoding>

/** 是否登录 */
@property (nonatomic,assign)BOOL isLogin;

/** 登录的token值*/
@property (nonatomic,copy) NSString *token;
/** 登录的token值*/
@property (nonatomic,copy) NSString *ticket;



/** 用户ID*/
@property (nonatomic,copy) NSString *userId;
/** 用户头像*/
@property (nonatomic,copy) NSString *icon;
/** 用户名称*/
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userAccount;
/** 用户类型*/
@property (nonatomic,assign) NSInteger userType;
@property (nonatomic,copy) NSString *userTypeStr;
/** 用户等级*/
@property (nonatomic,copy) NSString *memberLv;
/** 用户手机号码*/
@property (nonatomic,copy) NSString *userMobile;
/** 用户联系地址*/
@property (nonatomic,copy) NSString *address;
/** 邮政编码*/
@property (nonatomic,copy) NSString *zipCode;

/** 购物车数量*/
@property (nonatomic,assign) NSInteger shpingCarNumber;
/** 订单数量*/
@property (nonatomic,assign) NSInteger orderNPNum;
@property (nonatomic,assign) NSInteger orderNSNum;
@property (nonatomic,assign) NSInteger orderSINum;
@property (nonatomic,assign) NSInteger orderONum;
@property (nonatomic,assign) NSInteger orderExNum;
/** 我的设计数量*/
@property (nonatomic,assign) NSInteger designNINum;
@property (nonatomic,assign) NSInteger designINum;
@property (nonatomic,assign) NSInteger designONum;

/** 我的钱包*/
@property (nonatomic,assign) float advance;
/** 信用额度*/
@property (nonatomic,assign) float creditUse;
/** 优惠劵*/
@property (nonatomic,assign) NSInteger couponNum;
/** 积分*/
@property (nonatomic,assign) float point;

@property (nonatomic,assign) NSInteger favoriteNum;
@property (nonatomic,assign) NSInteger msgNum;

/** 折扣*/
@property (nonatomic,assign) float disCount;

/**
 *  推荐人
 */
@property (nonatomic,copy)NSString *referralsCode;

@property (nonatomic,assign)NSInteger browseNum;

//签到
@property (nonatomic,copy)NSString *signin;

//性别
@property (nonatomic,copy)NSString *sex;
//邮箱
@property (nonatomic,copy)NSString *email;
//从事行业
@property (nonatomic,copy)NSString *industry;
//职业类型
@property (nonatomic,copy)NSString *vocation;
//常用物料
@property (nonatomic,copy)NSString *materiel;
//生日
@property (nonatomic,copy)NSString *Birthday;
//联系地址
@property (nonatomic,copy)NSString *addr;
//头像地址
@property (nonatomic,copy)NSString *header;


singleton_interface(ZYUser);

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;


@end
