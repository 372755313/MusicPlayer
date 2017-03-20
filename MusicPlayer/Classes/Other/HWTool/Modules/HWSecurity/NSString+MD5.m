//
//  NSString+MD5Encrypt.h
//

#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString *)md5Encrypt {

    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return hash;
 
}




@end
