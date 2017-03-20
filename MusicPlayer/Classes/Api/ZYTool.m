//
//  ZYTool.m
//  ziyun
//
//  Created by zy on 16/5/9.
//  Copyright © 2016年 zy. All rights reserved.
//

#import "ZYTool.h"
#import "HWAlertView.h"
#import "LCProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "TYAlertView.h"
#import "TYAlertController.h"


//#import "ZYGoodsInfoController.h"
#import "JTNavigationController.h"
//#import "ZYLoginController.h"


//#import "DataSigner.h"

#import "SvUDIDTools.h"

@implementation ZYTool


#pragma mark 签名 sign
//+ (NSString *)sign:(NSDictionary *)postDic
//{
//    DLog(@"postDic = %@",[ZYTool sortedDic:postDic]);
//    return  [ZYTool signRequestString:[ZYTool sortedDic:postDic]];
//}


//+ (NSString *)signRequestString:(NSString *)requestString
//{
//    id<DataSigner> signer = CreateRSADataSigner(nil);
//    NSString *signedStr = [signer commonSignString:requestString];
//    
//    return signedStr;
//}


+ (NSString *)sortedDic:(NSDictionary *)dict
{
    
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *formartStr;
    int i = 0;
    for (NSString *categoryId in sortedArray) {
        NSString *catVal = [NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]];
        
        if (i>0) {
            formartStr = [formartStr stringByAppendingFormat:@"&%@=%@",categoryId,catVal];
        }else{
            formartStr = [NSString stringWithFormat:@"%@=%@",categoryId,catVal];
        }
        i++;
    }
    

    return formartStr;
}

+ (void)showAlerts:(NSString *)str
{
    HWAlertView *alertView = [[HWAlertView alloc] initWithTitle:nil andMessage:str];
    [alertView addButtonWithTitle:@"确定"
                             type:HWAlertViewButtonTypeCancel
                          handler:^(HWAlertView *alert) {
                              
                          }];
    
    alertView.transitionStyle = HWAlertViewTransitionStyleDropDown;
    [alertView show];
    
}

+ (void)showAlerts:(NSString *)str Ok:(void (^)(id))Ok
{
    HWAlertView *alertView = [[HWAlertView alloc] initWithTitle:nil andMessage:str];
    
    [alertView addButtonWithTitle:@"确定"
                             type:HWAlertViewButtonTypeCancel
                          handler:^(HWAlertView *alert) {
                              Ok(alert);
                          }];
    
    alertView.transitionStyle = HWAlertViewTransitionStyleDropDown;
    [alertView show];
    
}

+ (void)showAlerts:(NSString *)str Ok:(void (^)(id))Ok Cancel:(void (^)(id))Cancel
{
    
    HWAlertView *alertView = [[HWAlertView alloc] initWithTitle:nil andMessage:str];
    [alertView addButtonWithTitle:@"取消"
                             type:HWAlertViewButtonTypeCancel
                          handler:^(HWAlertView *alertView) {
                              Cancel(alertView);
                          }];
    [alertView addButtonWithTitle:@"确定"
                             type:HWAlertViewButtonTypeDestructive
                          handler:^(HWAlertView *alertView) {
                              Ok(alertView);
                          }];
    alertView.cornerRadius = 10;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = HWAlertViewTransitionStyleDropDown;
    [alertView show];
    
}

/** 提示 */
+ (void)showAlerts:(NSString *)title msg:(NSString *)msg Ok:(void (^)(id alerts))Ok Cancel:(void (^)(id alerts))Cancel
{
    HWAlertView *alertView = [[HWAlertView alloc] initWithTitle:title andMessage:msg];
    [alertView addButtonWithTitle:@"取消"
                             type:HWAlertViewButtonTypeCancel
                          handler:^(HWAlertView *alertView) {
                              Cancel(alertView);
                          }];
    [alertView addButtonWithTitle:@"确定"
                             type:HWAlertViewButtonTypeDestructive
                          handler:^(HWAlertView *alertView) {
                              Ok(alertView);
                          }];
    alertView.cornerRadius = 10;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = HWAlertViewTransitionStyleDropDown;
    [alertView show];
    

}


/** 提示 */
+ (void)showAlerts:(NSString *)title
               msg:(NSString *)msg
                Ok:(void (^)(id alerts))Ok
           okTitle:(NSString *)okTitle
            cancel:(void (^)(id alerts))cancel
       cancelTitle:(NSString *)cancelTitle
{
    HWAlertView *alertView = [[HWAlertView alloc] initWithTitle:title andMessage:msg];
    [alertView addButtonWithTitle:cancelTitle
                             type:HWAlertViewButtonTypeCancel
                          handler:^(HWAlertView *alertView) {
                              cancel(alertView);
                          }];
    [alertView addButtonWithTitle:okTitle
                             type:HWAlertViewButtonTypeDestructive
                          handler:^(HWAlertView *alertView) {
                              Ok(alertView);
                          }];
    alertView.cornerRadius = 10;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = HWAlertViewTransitionStyleDropDown;
    [alertView show];


}

/** 输入框  多个*/
+ (void)showAlerts:(NSString *)str list:(NSArray *)list dong:(void (^)(NSInteger tag))Ok
{
    HWAlertView *alertView = [[HWAlertView alloc] initWithTitle:nil andMessage:str];
    NSInteger idx = 0;
    for (NSString *str in list) {
        [alertView addButtonWithTitle:str
                                 type:HWAlertViewButtonTypeCancel
                              handler:^(HWAlertView *alertView) {
                                  Ok(idx);
                              }];
        idx++;
    }
    [alertView show];

}

/** 输入框  单个 按钮*/
//+ (void)showAlerts:(NSString *)title
//             input:(void (^)(UITextField *textField))tf
//           okTitle:(NSString *)okTitle
//                Ok:(void (^)(NSString *))Ok
//{
//    TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:nil];
//    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        tf(textField);
//    }];
//    
//    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {}]];
//
//    __typeof (alertView) __weak weakAlertView = alertView;
//    [alertView addAction:[TYAlertAction actionWithTitle:okTitle style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
//        for (UITextField *textField in weakAlertView.textFieldArray) {
//            Ok(textField.text);
//        }
//    }]];
//    
//    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
//    [[UIWindow hw_optimizedVisibleViewController] presentViewController:alertController animated:YES completion:nil];;
//
//
//}



#pragma mark - hub
+ (void)hideHUD
{
    [LCProgressHUD hide];
}

+ (void)showLoading:(NSString*)message
{
    [LCProgressHUD showLoading:message];
}

+ (void)showSuccess:(NSString *)success
{
   [LCProgressHUD showSuccess:success];
}

+ (void)showError:(NSString *)error
{
    [LCProgressHUD showFailure:error];
}

+ (void)showInfo:(NSString *)message
{
    [LCProgressHUD showInfoMsg:message];
}

+ (void)showMessage:(NSString *)message
{
    [LCProgressHUD showMessage:message];
}



+ (void)imageView:(UIImageView *)imgV setImageWithURL:(NSString *)urlStr placeholderImage:(NSString *)placeStr
{

    UIImage *placeholder = [UIImage imageNamed:placeStr];
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (originalImage) {
        imgV.image = originalImage;
    } else {
        NSInteger netStaus = [ZYUserDefaults integerForKey:kZYNetState];
        switch (netStaus) {
            case -1: //异常
            {
               [imgV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:placeStr]];
            }
                break;
            case 0: //无网络
            {
                imgV.image = placeholder;
            }
                break;
            case 1:  // 3g
            {
//                BOOL alwaysDownloadOriginalImage = [[HWUserDefaults readObjectForKey:kDownloadPic] boolValue];
//                if (alwaysDownloadOriginalImage) {
//                    [imgV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:placeStr]];
//                } else {
//                    imgV.image = placeholder;
//                }
            }
                break;
            case 2: //wifi
            {
                 [imgV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:placeStr]];
            }
                break;
                
            default:
                break;
        }
    }
    
}

+ (void)button:(UIButton *)button setImageWithURL:(NSString *)urlStr forState:(UIControlState)UIControlState placeholderImage:(NSString *)placeStr
{
    
    
    UIImage *placeholder = [UIImage imageNamed:placeStr];
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (originalImage) {
        [button setImage:originalImage forState:UIControlStateNormal];
    } else {
        NSInteger netStaus = [ZYUserDefaults integerForKey:kZYNetState];
        switch (netStaus) {
            case -1: //异常
            {
                [button sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeStr]];
            }
                break;
            case 0: //无网络
            {
                [button setImage:placeholder forState:UIControlStateNormal];
            }
                break;
            case 1:  // 3g
            {
//                BOOL alwaysDownloadOriginalImage = [[HWUserDefaults readObjectForKey:kDownloadPic] boolValue];
//                if (alwaysDownloadOriginalImage) {
//                    [button sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeStr]];
//                } else {
//                    [button setImage:placeholder forState:UIControlStateNormal];
//                }
            }
                break;
            case 2: //wifi
            {
                [button sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeStr]];
            }
                break;
                
            default:
                break;
        }
    }

    
    
}

+ (void)imgCacheclear
{
    // 1.清除内存中的缓存图片
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 2.取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}


//格
+ (NSString *)delSpace:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    return string;
}



+(NSString*)dataTojsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        DLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//+ (NSString *)getClientIP
//{
//    NSString *ip = [HWUserDefaults userDefaultsRead:kUserClientIP];
//    if (ip == nil) {
//        ip = @"192.168.1.1";
//    }
//    return ip;
//}

+ (NSString *)getSystemUUID {
    
//    return  [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    return [SvUDIDTools UDID];
}

//+ (void)currentVersion:(void (^)(BOOL isNew))isNewVersion
//{
//    NSString *currentVersion = [HWCommon getCurrentVersion];
//    if ([[ZYUserDefaults valueForKey:@"CFBundleVersion"] isEqual:currentVersion]) {
//        isNewVersion(NO);
//    }else{
//        isNewVersion(YES);
//        [ZYUserDefaults setObject:currentVersion forKey:@"CFBundleVersion"];
//        [ZYUserDefaults synchronize];
//    }
//
//}

+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (from + (arc4random() % (to - from + 1)));
}
//+ (void)pushHome:(UINavigationController *)nav
//  addcartBuyType:(NSString *)addcartBuyType
//       productId:(NSString *)productId{
//    
//    ZYGoodsInfoController *gVc = [[ZYGoodsInfoController alloc]init];
//    gVc.productId = productId;
//    [nav pushViewController:gVc animated:YES];
//
//}

//+ (void)pushFromVc:(UINavigationController *)nav
//    addcartBuyType:(NSString *)addcartBuyType
//    productId:(NSString *)productId{
//    
//    ZYGoodsInfoController *gVc = [[ZYGoodsInfoController alloc]init];
//    gVc.productId = productId;
//    [nav pushViewController:gVc animated:YES];
//}

//+ (void)loginVc:(UIViewController *)vc
//{
//    if (!vc.automaticallyAdjustsScrollViewInsets) {
//        [vc.navigationController setNavigationBarHidden:YES animated:NO];
//    }
//    JTNavigationController *loginNav = [[JTNavigationController alloc]initWithRootViewController:[[ZYLoginController alloc]init]];
//    [vc presentViewController:loginNav animated:YES completion:^{
//        
//    }];
//
//}


+ (void)checkAppUpdate
{
    /*
    NSString *nowVersion = [HWCommon getCurrentShortVersion];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", APPID]];
    NSString * file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];

    if (file !=  nil) {
        NSError *error;
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:[file dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        NSDictionary *results = [jsonStr[@"results"] hw_safeObjectAtIndex:0];
        
        NSString *newVersion = [results hw_safeObjectForKey:@"version"];
        //    NSString *releaseNotes = [results hw_safeObjectForKey:@"releaseNotes"];
        NSString *artistViewUrl = [results hw_safeObjectForKey:@"artistViewUrl"];
        
        if( [nowVersion compare:newVersion options:NSNumericSearch]== -1)
        {
            NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，是否下载新版本？",nowVersion,newVersion];
            
            [ZYTool showAlerts:@"升级提示" msg:msg Ok:^(id alerts) {
                NSURL *url = [NSURL URLWithString:artistViewUrl];
                [[UIApplication sharedApplication] openURL:url];
            } okTitle:@"现在升级" cancel:^(id alerts) {
                
            } cancelTitle:@"下次再说"];
            
        }
    }
*/
//    __weak __typeof(&*self)weakSelf = self;
//    [ZYNewApiTool  ZYgetAppVersion:^(NSDictionary *dic) {
//        [weakSelf setAppVers:dic];
//    } failure:^(NSString *errormsg) {
//    }];
    
}
//+ (void)setAppVers:(NSDictionary *)dic{
//    
//    if ([[dic hw_safeObjectForKey:@"isForce"] boolValue]) {
//        NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，如果不升级会影响你的正常使用，请升级",[HWCommon getCurrentShortVersion],[dic hw_safeObjectForKey:@"verNo"]];
//        NSString *artistViewUrl = [dic hw_safeObjectForKey:@"verUrl"];
//        [ZYTool showAlerts:@"升级提示" msg:msg Ok:^(id alerts) {
//            NSURL *url = [NSURL URLWithString:artistViewUrl];
//            [[UIApplication sharedApplication] openURL:url];
//             [ZYTool setAppVers:dic];
//        } okTitle:@"现在升级" cancel:^(id alerts) {
//            NSURL *url = [NSURL URLWithString:artistViewUrl];
//            [[UIApplication sharedApplication] openURL:url];
//             [ZYTool setAppVers:dic];
//        } cancelTitle:@"还是去升级吧"];
//    }else{
//        NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，是否下载新版本？",[HWCommon getCurrentShortVersion],[dic hw_safeObjectForKey:@"verNo"]];
//        NSString *artistViewUrl = [dic hw_safeObjectForKey:@"verUrl"];
//        [ZYTool showAlerts:@"升级提示" msg:msg Ok:^(id alerts) {
//            NSURL *url = [NSURL URLWithString:artistViewUrl];
//            [[UIApplication sharedApplication] openURL:url];
//        } okTitle:@"现在升级" cancel:^(id alerts) {
//            
//        } cancelTitle:@"下次再说"];
//    }
//
//}


+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self private_colorComponentFrom:colorString start:0 length:1];
            green = [self private_colorComponentFrom:colorString start:1 length:1];
            blue = [self private_colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self private_colorComponentFrom:colorString start:0 length:1];
            red = [self private_colorComponentFrom:colorString start:1 length:1];
            green = [self private_colorComponentFrom:colorString start:2 length:1];
            blue = [self private_colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self private_colorComponentFrom:colorString start:0 length:2];
            green = [self private_colorComponentFrom:colorString start:2 length:2];
            blue = [self private_colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self private_colorComponentFrom:colorString start:0 length:2];
            red = [self private_colorComponentFrom:colorString start:2 length:2];
            green = [self private_colorComponentFrom:colorString start:4 length:2];
            blue = [self private_colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            alpha = 0.0f;
            red = 0.0f;            green = 0.0f;
            blue = 0.0f;
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)private_colorComponentFrom:(NSString *)string
                                    start:(NSUInteger)start
                                   length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@",
                                                   substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    
    return hexComponent / 255.0;
}


//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


@end
