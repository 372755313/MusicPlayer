//
//  ZYActionSheetView.h
//  ZYActionSheetView
//
//  Created by WangQi on 7/4/15.
//  Copyright (c) 2015 WangQi. ZYl rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYActionSheetView;

typedef void (^ZYActionSheetViewDidSelectButtonBlock)(ZYActionSheetView *actionSheetView, NSInteger buttonIndex);

@interface ZYActionSheetView : UIView

+ (ZYActionSheetView *)showActionSheetWithTitle:(NSString *)title
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
                             otherButtondTitles:(NSArray *)otherButtondTitles
                                        handler:(ZYActionSheetViewDidSelectButtonBlock)block;



- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
           otherButtondTitles:(NSArray *)otherButtondTitles
                      handler:(ZYActionSheetViewDidSelectButtonBlock)block;

- (void)show;
- (void)dismiss;

@end
