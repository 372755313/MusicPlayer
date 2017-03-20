//
//  CLGifLoadView.h
//  CLMJRefresh
//
//  Created by Charles on 15/12/18.
//  Copyright © 2015年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CLLoadState){
    CLLoadStateLoading,//加载中
    CLLoadStateFinish, //结束
    CLLoadStateNone,   //列表没有数据
    CLLoadStateFailed  //失败
};
typedef void(^RetryBlock)();

@interface ZYLoadView : UIView
{
    RetryBlock myRetryBlock;
}
@property (nonatomic,assign) CLLoadState state;
@property (nonatomic,assign) RetryBlock retryBlcok;



- (void)setRetryBlcok:(RetryBlock)retryBlcok;

- (void)setTitle:(NSString *)title state:(CLLoadState)state;




@end
