//
//  HWSecurity.m
//  tg
//
//  Created by vivyan on 14/12/5.
//  Copyright (c) 2014年 vivyan. All rights reserved.
//

#import "HWSecurity.h"
#import "HWGTMBase64.h"
#import "NSString+MD5.h"
#import "NSData+CommonCrypto.h"
#import "HWRsa.h"
@implementation HWSecurity


#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [HWGTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [HWGTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [HWGTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    data = [HWGTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - MD5加密
/**
 *	@brief	对string进行md5加密
 *
 *	@param 	string 	未加密的字符串
 *
 *	@return	md5加密后的字符串
 */
+ (NSString*)encryptMD5String:(NSString*)string {
    return [string md5Encrypt];
}


#pragma mark - AES加密

+ (NSString *)encryptAES:(NSString *)string pwd:(NSString *)pwd
{
    NSData *encryptedData = [[string dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[pwd dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [self encodeBase64Data:encryptedData];

}

+ (NSString *)decryptAES:(NSString *)base64EncodedString pwd:(NSString *)pwd
{
    NSData *encryptedData = [base64EncodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    encryptedData = [HWGTMBase64 decodeData:encryptedData];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[pwd dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];

}

#pragma mark - RSA 加密 公钥加密
+ (NSString *)encrypttoRSABase64String:(NSString *)content
{
    HWRsa *rsa = [[HWRsa alloc] init];
    NSData *rsadata = [rsa encryptWithString:content];
    return  [HWSecurity encodeBase64Data:rsadata];
    
}

+ (NSString *)encryptRSA:(NSString *)content
{
    HWRsa *rsa = [[HWRsa alloc] init];
    NSData *rsadata = [rsa encryptWithString:content];
    return [rsadata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
  
}

#pragma mark - DES
//文本先进行DES加密。然后再转成base64
+ (NSString *)enDEString:(NSString *)text withKey:(NSString*)key
{
    if (text && ![text isEqualToString:@""]) {
  //       NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
  //      NSData *data = [text dataUsingEncoding:gbkEncoding];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        data = [self DESEncrypt:data WithKey:key];
        return [self encodeBase64Data:data];
    }
    else {
        return @"";
    }
}

//先把base64转为文本。然后再DES解密
+ (NSString *)deDEString:(NSString *)base64string withKey:(NSString*)key
{
    if (base64string && ![base64string isEqualToString:@""]) {
        
        NSData *data = [base64string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        data = [HWGTMBase64 decodeData:data];
        data = [self DESDecrypt:data WithKey:key];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}

+ (NSString *)encrypt:(NSString *)sText
     encryptOrDecrypt:(BOOL)isEncryptOperation
                  key:(NSString *)key
{
    const void *vplainText;
    size_t plainTextBufferSize;
    CCOperation  encryptOperation = isEncryptOperation?kCCEncrypt:kCCDecrypt;
    if (encryptOperation == kCCDecrypt)
    {
        NSData *decryptData = [HWGTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
        //NSData *decryptData = [GTMBase64 decodeString:sText ];
        plainTextBufferSize = [decryptData length];
        vplainText = [decryptData bytes];
    }
    else
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [encryptData length];
        vplainText = (const void *)[encryptData bytes];
    }
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *initVec = @"01234567";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    CCCryptorStatus ccStatus = CCCrypt(encryptOperation,
                                       kCCAlgorithm3DES,
                                       kCCOptionPKCS7Padding,
                                       vkey,
                                       kCCKeySize3DES,
                                       vinitVec,
                                       vplainText,
                                       plainTextBufferSize,
                                       (void *)bufferPtr,
                                       bufferPtrSize,
                                       &movedBytes);
    NSString *result = nil;
    if (ccStatus == kCCSuccess)
    {
        if (encryptOperation == kCCDecrypt)
        {
            result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
        }
        else
        {
            NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
            result = [HWGTMBase64 stringByEncodingData:data];
            // NSLog(@"result:%@",result);
            // NSData *temp = [GTMBase64 decodeString:result];
        }
    }
    return result;
}





/*
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data  (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 */
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}


/*
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

@end
