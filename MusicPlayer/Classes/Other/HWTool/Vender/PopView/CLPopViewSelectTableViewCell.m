//
//  CLPopViewSelectTableViewCell.m
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLPopViewSelectTableViewCell.h"

@interface CLPopViewSelectTableViewCell ()





@end


@implementation CLPopViewSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initUI];
        [self setupUI];
        [self setupFrame];
        
    }
    return self;
    
}

- (void)initUI {
    
    _selectImage = [[UIImageView alloc] init];
    _nameLabel   = [[UILabel alloc] init];
    
    
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_selectImage];

}


- (void)setupUI {
    
    _selectImage.image = [UIImage imageNamed:@"selectPopViewNomal"];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.backgroundColor = [UIColor clearColor];
}

- (void)setupFrame {
    
    _selectImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 90, 0, 30, 30);
    
    _nameLabel.frame = CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width - 180, self.contentView.frame.size.height);
    
}

- (void)configData:(NSString *)text {
    
    _nameLabel.text = text;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (self.isSelected) {
        
        //245 222 179
        self.backgroundColor = [UIColor colorWithRed:255/255.0 green:250/255.0 blue:240/255.0 alpha:1];
        self.selectImage.image = [UIImage imageNamed:@"selectPopVIew"];
        
    } else {
    
        self.backgroundColor = [UIColor whiteColor];
        self.selectImage.image = [UIImage imageNamed:@"selectPopViewNomal"];
        
    }
}

@end
