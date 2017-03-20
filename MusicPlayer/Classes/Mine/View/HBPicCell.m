//
//  HBPicCell.m
//  MusicPlayer
//
//  Created by 胡贝贝 on 16/11/17.
//  Copyright © 2016年 胡贝贝. All rights reserved.
//

#import "HBPicCell.h"
#import <Masonry.h>
#import "zy.pch"
#import <UIImageView+WebCache.h>

@interface HBPicCell ()

@property (nonatomic,weak)UIImageView *imageV;
@property (nonatomic,weak)UILabel *titleL;

@end

@implementation HBPicCell

+ (HBPicCell *)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"HBPicCellID";
    HBPicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HBPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageV];
        _imageV = imageV;
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.text = @"图文";
        [titleL setTextAlignment:NSTextAlignmentCenter];
        [titleL setFont:[UIFont systemFontOfSize:17.0]];
        [self.contentView addSubview:titleL];
        _titleL = titleL;
        
        __weak __typeof(&*self)weakSelf = self;
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView).offset(0);
            make.width.equalTo(@(kWidth));
            make.height.equalTo(@(kWidth*3/4));
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(imageV.mas_bottom).offset(30);
        }];
    }
    return self;
}

- (void)setDic:(NSMutableDictionary *)dic
{
    NSURL *urlImage = [NSURL URLWithString:[dic objectForKey:@"url"]];
    [_imageV sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"yasuo.jpg"]];
    
    _titleL.text = [dic objectForKey:@"title"];
}

@end
