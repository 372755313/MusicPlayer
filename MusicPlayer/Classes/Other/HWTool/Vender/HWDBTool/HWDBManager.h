//
//  HWDBManager.h
//  skywakerwei
//
//  Created by skywakerwei on 15/10/14.
//  Copyright © 2015年 skywakerwei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBKeyValueItem;


@interface HWDBManager : NSObject

@end




@interface DBKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end
