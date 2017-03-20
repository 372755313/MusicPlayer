//
//  ZYUser.m
//  skywakerwei
//
//  Created by skywakerwei on 15/6/15.
//  Copyright (c) 2015年 skywakerwei. All rights reserved.
//

#import "ZYUser.h"

@implementation ZYUser


MJCodingImplementation;

singleton_implementation(ZYUser);


- (NSString *)description
{
    return [NSString stringWithFormat:@"userName = %@ userId = %@ userType = %@ ",
            self.userName,
            self.userId,
            self.userTypeStr];

}

@end