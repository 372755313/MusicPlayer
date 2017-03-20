//
//  HWRsa.h
//  tg
//
//  Created by vivyan on 14/12/5.
//  Copyright (c) 2014年 vivyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWRsa : NSObject{
    SecKeyRef publicKey;
    SecCertificateRef certificate;
    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}


- (NSData *) encryptWithString:(NSString *)content;

@end
