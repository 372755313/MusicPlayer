//
//  AmapLocationTool.h
//  地理编码使用高德
//
//  Created by skywakerwei on 14/12/15.
//  Copyright (c) 2014年 skywakerwei. All rights reserved.
//


#import "AmapSlampLocationTool.h"
//定位
#import <AMapLocationKit/AMapLocationKit.h>


#define kCacheTime 60

@interface AmapSlampLocationTool()


@property (nonatomic,strong) AMapLocationManager *locationManager;

@property (nonatomic,assign)    BOOL        isCurrentLocateDeny;
@property (nonatomic,assign)    float       latitude;
@property (nonatomic,assign)    float       longitude;
@property (nonatomic,copy)      NSString    *address;
@property (nonatomic,copy)      NSString    *province;
@property (nonatomic,copy)      NSString    *city;
@property (nonatomic,copy)      NSString    *subLocality;

@property (nonatomic, assign)   NSInteger   timestamp;



@end


@implementation AmapSlampLocationTool

singleton_implementation(AmapSlampLocationTool);


- (id)init
{
    if (self = [super init]) {
        _isCurrentLocateDeny = NO;
        self.locationManager = [[AMapLocationManager alloc] init];
    }
    return self;
}

+ (void)getLocationCoordinate:(void (^)(NSDictionary *, BOOL))locaiontBlock
                        error:(void (^)(NSError *error)) errorBlock
{
    AmapSlampLocationTool *tool = [AmapSlampLocationTool sharedAmapSlampLocationTool];
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)//开启了定位
    {
        
        if(tool.isCurrentLocateDeny &&
           (tool.timestamp + kCacheTime > [[NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970] integerValue])){
            //已经定位，在有限期间
            NSDictionary *dict = @{
                                   @"address":      tool.address,
                                   @"province":     tool.province,
                                   @"city":         tool.city,
                                   @"subLocality":  tool.subLocality,
                                   @"latitude":     @(tool.latitude),
                                   @"longitude":    @(tool.longitude)
                                   };
            locaiontBlock(dict,NO);
    
        }else{
            [tool.locationManager stopUpdatingLocation];
            //无定位
            [tool.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//                [tool.locationManager stopUpdatingLocation];
                tool.timestamp = [[NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970] integerValue];
                if (error)
                {
                    tool.isCurrentLocateDeny  = NO;
                    if (errorBlock) {
                        errorBlock(error);
                    }
                }
                
                if (regeocode)
                {
//                    DLog(@"regeocode = %@",regeocode);
                    tool.isCurrentLocateDeny = YES;
                    if(regeocode.province == nil){
                        tool.province = @"未知";
                    }else{
                        tool.province = regeocode.province;
                    }
                    if(regeocode.city == nil){
                        tool.city = tool.province;
                    }else{
                        tool.city = regeocode.city;
                    }
                    if (regeocode.district == nil) {
                        tool.subLocality = tool.city;
                    }else{
                        tool.subLocality = regeocode.district;
                    }
                    if (regeocode.formattedAddress == nil) {
                       tool.address = tool.subLocality;
                    }else{
                       tool.address = regeocode.formattedAddress;
                    }
                    tool.latitude = location.coordinate.latitude;
                    tool.longitude = location.coordinate.longitude;
                    
                    if (locaiontBlock) {
                        NSDictionary *dict = @{
                                               @"address":      tool.address,
                                               @"province":     tool.province,
                                               @"city":         tool.city,
                                               @"subLocality":  tool.subLocality,
                                               @"latitude":     @(tool.latitude),
                                               @"longitude":    @(tool.longitude)
                                               };
                        locaiontBlock(dict,YES);
//                        DLog(@"new = %@",dict);
                    }
                }
            }];
            
            
            
        }
        
        
    
    }else{
        tool.isCurrentLocateDeny = NO;
        errorBlock(nil);
    
    }
    
    



}


    
@end
