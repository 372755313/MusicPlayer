//
//  HWSecurity.h
//  tg
//
//  Created by vivyan on 14/12/5.
//  Copyright (c) 2014年 vivyan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HWSecurity : NSObject
#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)string;
+ (NSString*)decodeBase64String:(NSString *)string;

#pragma mark - MD5加密
+ (NSString*)encryptMD5String:(NSString*)string;

#pragma mark - AES加密 (base64 return base64 string)
+ (NSString *)encryptAES:(NSString *)string pwd:(NSString *)pwd;
+ (NSString *)decryptAES:(NSString *)base64EncodedString pwd:(NSString *)pwd;

#pragma mark - RSA 加密 (base64 return base64 string)
+ (NSString *)encrypttoRSABase64String:(NSString *)content;
+ (NSString *)encryptRSA:(NSString *)content;

#pragma mark - DES加密
//NSString先进行DES加密,然后再转成base64加密
+ (NSString *)enDEString:(NSString *)text withKey:(NSString*)key;



//先把base64转为NSString。然后再DES解密
+ (NSString *)deDEString:(NSString *)base64string withKey:(NSString*)key;

//NSString先进行DES加密,然后再转成base64加密
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;


+ (NSString *)encrypt:(NSString *)sText
     encryptOrDecrypt:(BOOL)isEncryptOperation
                  key:(NSString *)key;

@end