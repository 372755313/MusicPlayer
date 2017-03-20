//
//  CLPopViewSelectTableViewCell.h
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLPopViewSelectTableViewCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *selectImage;
@property (nonatomic ,strong) UILabel *nameLabel;

- (void)configData:(NSString *)text;

@end
