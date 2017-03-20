//
//  HWRsa.m
//  tg
//
//  Created by vivyan on 14/12/5.
//  Copyright (c) 2014年 vivyan. All rights reserved.
//

#import "HWRsa.h"


@implementation HWRsa

- (id)init {
    self = [super init];
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key"
                                                              ofType:@"der"];
    if (publicKeyPath == nil) {
        DLog(@"Can not find pub.der");
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        DLog(@"Can not read from pub.der");
        return nil;
    }
    
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        DLog(@"Can not read certificate from pub.der");
        return nil;
    }
    
    policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        DLog(@"SecTrustCreateWithCertificates fail. Error Code: %ld", (long)returnCode);
        return nil;
    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        DLog(@"SecTrustEvaluate fail. Error Code: %ld", (long)returnCode);
        return nil;
    }
    
    publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        DLog(@"SecTrustCopyPublicKey fail");
        return nil;
    }
    
    maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    return self;
}

- (NSData *) encryptWithData:(NSData *)content {
    
    size_t plainLen = [content length];
    if (plainLen > maxPlainLen) {
        DLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
    }
    
    void *plain = malloc(plainLen);
    [content getBytes:plain
               length:plainLen];
    
    size_t cipherLen = 128; // 当前RSA的密钥长度是128字节
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                        plainLen, cipher, &cipherLen);
    
    NSData *result = nil;
    if (returnCode != 0) {
        DLog(@"SecKeyEncrypt fail. Error Code: %ld", (long)returnCode);
    }
    else {
        result = [NSData dataWithBytes:cipher
                                length:cipherLen];
    }
    
    free(plain);
    free(cipher);
    
    return result;
}


- (NSData *) encryptWithString:(NSString *)content {
    return [self encryptWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
}



- (void)dealloc{
    CFRelease(certificate);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(publicKey);
}

@end
