//
//  ZYTool.h
//  ziyun
//
//  Created by zy on 16/5/9.
//  Copyright © 2016年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYTool : NSObject
+ (NSString *)sign:(NSDictionary *)postDic;

//警告
+ (void)showAlerts:(NSString *)str;
//警告2
+ (void)showAlerts:(NSString *)str Ok:(void (^)(id alerts))Ok;
/** 提示 */
+ (void)showAlerts:(NSString *)str Ok:(void (^)(id alerts))Ok Cancel:(void (^)(id alerts))Cancel;
/** 提示 */
+ (void)showAlerts:(NSString *)title msg:(NSString *)msg Ok:(void (^)(id alerts))Ok Cancel:(void (^)(id alerts))Cancel;

/** 提示 */
+ (void)showAlerts:(NSString *)title
               msg:(NSString *)msg
                Ok:(void (^)(id alerts))Ok
           okTitle:(NSString *)okTitle
            cancel:(void (^)(id alerts))cancel
       cancelTitle:(NSString *)cancelTitle;


/** 输入框  单个 按钮*/
+ (void)showAlerts:(NSString *)title
             input:(void (^)(UITextField *textField))tf
           okTitle:(NSString *)okTitle
                Ok:(void (^)(NSString *str))Ok;
/** 输入框  多个*/
+ (void)showAlerts:(NSString *)str list:(NSArray *)list dong:(void (^)(NSInteger tag))Ok;




#pragma mark - hub
+ (void)hideHUD;
+ (void)showLoading:(NSString*)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showInfo:(NSString *)message;
+ (void)showMessage:(NSString *)message;


+ (void)imageView:(UIImageView *)imgV
    setImageWithURL:(NSString *)urlStr
   placeholderImage:(NSString *)placeStr;

+ (void)button:(UIButton *)button setImageWithURL:(NSString *)urlStr forState:(UIControlState)UIControlState placeholderImage:(NSString *)placeStr;

+ (void)imgCacheclear;
+ (NSString *)delSpace:(NSString *)string;
+(NSString*)dataTojsonString:(id)object;
//获取IP
+ (NSString *)getClientIP;
+ (NSString *)getSystemUUID;
//新版本特性
+ (void)currentVersion:(void (^)(BOOL isNew))ver;
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;


+ (void)pushHome:(UINavigationController *)nav
  addcartBuyType:(NSString *)addcartBuyType
       productId:(NSString *)productId;

+ (void)pushFromVc:(UINavigationController *)nav
    addcartBuyType:(NSString *)addcartBuyType
         productId:(NSString *)productId;


+ (void)loginVc:(UIViewController *)vc;
+ (void)checkAppUpdate;

+ (UIColor *)colorWithHexString:(NSString *)hexString;


+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
