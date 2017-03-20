//
//  HBPicCell.h
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBPicCell : UITableViewCell

@property (nonatomic,strong)NSMutableDictionary *dic;

+ (HBPicCell *)cellWithTable:(UITableView *)tableView;

@end
