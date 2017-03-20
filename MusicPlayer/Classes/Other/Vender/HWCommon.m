//
//  HWCommon.m
//  tg
//
//  Created by skywakerwei on 14/11/25.
//  Copyright (c) 2014年 skywakerwei. All rights reserved.
//

#import "HWCommon.h"


@implementation HWCommon

+(float)dirTotalSize:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+(void)clearCache
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kDirCache]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:kDirCache];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[kDirCache stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}


+ (void)removeDir:(NSString *)DirPath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:DirPath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:DirPath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[DirPath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

//判断文件夹是否存在
+(BOOL)isDirExist:(NSString *)dirName
{
    NSString *dirPath=[NSString stringWithFormat:@"%@/%@",kDirCache,dirName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isDir=FALSE;
    BOOL isDirExist=[fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    return isDirExist&&isDir;
}

//删除
+ (void)removePlist:(NSString *)plistPath
{
    NSFileManager *fileMger = [NSFileManager defaultManager];
    
    //如果文件路径存在的话
    BOOL bRet = [fileMger fileExistsAtPath:plistPath];
    if (bRet) {
        
        NSError *err;
        
        [fileMger removeItemAtPath:plistPath error:&err];
    }

}

//
+ (NSString *)formartNum:(NSNumber *)num
{
    float fnum = [num floatValue];
    NSString *formartNum;
    if (fnum < 10) {
        formartNum = [NSString stringWithFormat:@"%.2f",floor(fnum*100)/100];
    }else if (fnum>=10 && fnum<100){
        formartNum = [NSString stringWithFormat:@"%.1f",floor(fnum*10)/10];
    }else{
        formartNum = [NSString stringWithFormat:@"%.0f",floor(fnum*100)/100];
    }
    
    NSRange range =[formartNum rangeOfString:@".00"];
    if (range.location != NSNotFound) {
        formartNum = [formartNum substringToIndex:range.location];
    }
    
    NSRange range2 =[formartNum rangeOfString:@".0"];
    if (range2.location != NSNotFound) {
        if (range2.location + range2.length == formartNum.length) {
            formartNum = [formartNum substringToIndex:range2.location];
        }
    }
    
    
    return formartNum;
    
}


//创建文件夹
+(BOOL)createDir:(NSString *)dirName
{
    NSString *dirPath=[kDirCache stringByAppendingPathComponent:dirName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([HWCommon isDirExist:dirPath]) {
        return YES;
    }
    return  [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
}

//创建doc文件夹
+(BOOL)createDocDir:(NSString *)dirName
{
    NSString *dirPath=[kDirDoc stringByAppendingPathComponent:dirName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([HWCommon isDirExist:dirPath]) {
        return YES;
    }
    return  [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
}

//图片下载到本地目录内
+ (void) downLoadWebImage:(NSString *)imgUrl toDir:(NSString *)path fileName:(NSString *)fileName completion:(void (^)(void))completion
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    //        UIImage *avatarImage = nil;
        NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
    //        UIImage *avatarImage = [UIImage imageWithData:responseData];
        [HWCommon createDocDir:path];
        if ([responseData writeToFile:[kDirDoc stringByAppendingFormat:@"/%@/%@.png",path,fileName] atomically:YES])
        {
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    });

}




+(BOOL)downLoadWebImage:(NSString *)imgUrl toDir:(NSString *)path fileName:(NSString *)fileName
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];

    if ([HWCommon createDir:path]) {
        if ([data writeToFile:[kDirCache stringByAppendingFormat:@"/%@/%@.%@",path,fileName,[imgUrl pathExtension]] atomically:YES])
        {
            return YES;
        }

    }
     return NO;
}

//电话中间四位加星
+ (NSString *)getPhone:(NSString *)phoneNum
{

    return  [NSString stringWithFormat:@"%@****%@",[phoneNum substringToIndex:3],[phoneNum substringFromIndex:phoneNum.length-4]];

}

//身份证号码
+ (NSString *)ittemDisposeIdcardNumber:(NSString *)idcardNumber {
    //星号字符串
    NSString *xinghaoStr = @"";
    //动态计算星号的个数
    for (int i  = 0; i < idcardNumber.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //身份证号取前3后四中间以星号拼接
    idcardNumber = [NSString stringWithFormat:@"%@%@%@",[idcardNumber substringToIndex:3],xinghaoStr,[idcardNumber substringFromIndex:idcardNumber.length-4]];
    //返回处理好的身份证号
    return idcardNumber;
}

//字典转url串
+ (NSString *)NSDictionaryToUrlData:(NSDictionary *)dic
{

    NSString *time = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSEnumerator *enumerator = [dic keyEnumerator];
    id key;
    NSMutableString *datastr =[NSMutableString string];
    while ((key = [enumerator nextObject])) {
        NSString *path = [NSString stringWithFormat:@"%@=%@&",key,dic[key]];
       [datastr appendString:path];
    }
    [datastr appendString:[NSString stringWithFormat:@"time=%@",time]];

    return datastr;
}

+ (id)retrunJsonData:(id)jsonData replace:(id)result
{
    if([jsonData isKindOfClass:[NSNull class]] || [jsonData length]<1){
        return result;
    }
    return jsonData;

}

//转json
+ (NSString *)TurnToJsonData:(id)data
{
    if ([NSJSONSerialization isValidJSONObject:data])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&error];
        return  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}




//顶部提示文字
//+ (void)showTopMsg:(NSString *)msg withVC:(UIViewController *)vc;
//{
//
//    UIButton *btn = [[UIButton alloc] init];
//    [vc.navigationController.view insertSubview:btn belowSubview:vc.navigationController.navigationBar];
//    
//    btn.userInteractionEnabled = NO;
//    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [btn setTitle:msg forState:UIControlStateNormal];
//   
//    
//    CGFloat btnH = 30;
//    CGFloat btnY = 64 - btnH;
//    CGFloat btnX = 0;
//    CGFloat btnW = vc.view.frame.size.width;
//    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
//        
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.2 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//            btn.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            [btn removeFromSuperview];
//        }];
//        
//    }];
//}


//时间戳
+ (NSString *)getTimeStamp {
    NSTimeInterval time = [NSDate date].timeIntervalSince1970 * 1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    return [NSString stringWithFormat:@"%llu", dTime];
    
}

//时间戳 INt
+ (NSInteger)getTimeStampInt {
    NSTimeInterval time = [NSDate date].timeIntervalSince1970 ;
    return [[NSNumber numberWithDouble:time] integerValue];

}


//时间戳转换时间字符串
+ (NSString *)getTimeStr:(NSNumber *)timeStamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]];
    return  [HWCommon getDateStringWithDate:confromTimesp DateFormat:@"yyyy.MM.dd"];
}

//将date时间戳转变成时间字符串
//@paaram   date            用于转换的时间
//@param    formatString    时间格式(yyyy-MM-dd HH:mm:ss)
//@return   NSString        返回字字符如（2012－8－8 11:11:11）
+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}


#pragma mark 获取系统版本
+ (NSString *)getCurrentVersion
{
    NSString *key = @"CFBundleVersion";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    return currentVersion;
}

+ (NSString *)getCurrentShortVersion
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    return currentVersion;
}

#pragma mark 检查邮箱地址的有效性
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark 检查手机号码的有效性
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString * MOBILE = @"^[1][3|4|5|7|8][0-9]{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

+ (NSString*)convertNull:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    
    return object;
    
}


+ (void)openApplicationSettings
{
    //   if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
    //       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    //   }else{
    //       UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示"
    //                                                        message:@"请到设置->隐私,打开定位服务"
    //                                                       delegate:nil
    //                                              cancelButtonTitle:@"确定"
    //                                              otherButtonTitles: nil];
    //       [alertView show];
    //   }
    
}

+ (NSString *)sortedDic:(NSDictionary *)dict
{

    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *formartStr;
    int i = 0;
    for (NSString *categoryId in sortedArray) {
        if (i>0) {
            formartStr = [formartStr stringByAppendingFormat:@"&%@=%@",categoryId,[dict objectForKey:categoryId]];
        }else{
             formartStr = [NSString stringWithFormat:@"%@=%@",categoryId,[dict objectForKey:categoryId]];
        }
        i++;
    }
    
    return formartStr;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (NSString *)utf8ToUnicode:(NSString *)string{
    
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }else if(_char >= 'a' && _char <= 'z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }else if(_char >= 'A' && _char <= 'Z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }else{
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
    return s;
}
@end
