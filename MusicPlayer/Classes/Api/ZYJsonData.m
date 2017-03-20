//
//  HWJsonData.m
//  tg
//
//  Copyright (c) 2015年 skywakerwei. All rights reserved.
//

#import "ZYJsonData.h"

@implementation ZYJsonData

+ (ZYJsonData *)loadDataWithJson:(NSDictionary *)json
{

    ZYJsonData *data = [ZYJsonData new];
    NSEnumerator *enumerator = [json keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        if([json[key] isEqual:[NSNull null]])
        {
            [data setValue:@"" forKey:key];
        }else{
            [data setValue:json[key] forKey:key];
        }
    }
    if (![data.rmk isKindOfClass:[NSString class]]) {
        data.rmk = @"系统异常，请重新再试";
    }
    return data;
}

@end
