//
//  CLSelectPOPView.m
//  popupView
//
//  Created by hezhijingwei on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLSelectPOPView.h"
#import "CLPopViewSelectTableViewCell.h"
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

typedef void(^OkeyBtnClicked)(NSInteger index);
typedef void(^cancelBtnCallBack)(void);


@interface CLSelectPOPView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, assign) NSInteger         flag;
@property (nonatomic, copy  ) OkeyBtnClicked    OkeyBtnClicked;
@property (nonatomic, copy  ) cancelBtnCallBack cancelBtnCallBack;
@property (nonatomic ,strong) UITableView       *tableView;
@property (nonatomic ,strong) UIButton *okBtn;
@property (nonatomic ,strong) UIButton *cancelBtn;
@property (nonatomic ,strong) UIView *footerView;



@end


@implementation CLSelectPOPView

+ (instancetype)selectPopView:(void (^)(NSInteger index))OkeyBtnClicked cancelBtnCallBack:(void (^)())cancelBtnCallBack {
    
    CLSelectPOPView *PopView = [[self alloc] init];
    
    PopView.frame = CGRectMake(30, (ScreenW - 44)/2.0f, ScreenW - 60, 44);
    
    PopView.OkeyBtnClicked    = OkeyBtnClicked;
    PopView.cancelBtnCallBack = cancelBtnCallBack;
    
    return PopView;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.flag = -100;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        
        
        [self createTitleLabel];
        [self createTableView];
        
    }
    return self;
}



- (void)setDataSource:(NSArray *)dataSource {

    _dataSource = dataSource;
    [self NewDataSource];
    
}


- (void)createTitleLabel {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, ScreenW - 60, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"标题";
    [self addSubview:_titleLabel];
    
    
    
}




- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    
    [_tableView registerClass:[CLPopViewSelectTableViewCell class] forCellReuseIdentifier:@"cellId"];

}


- (UIView *)createfooterView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (ScreenW - 44)/2.0f, 65)];
    
    view.backgroundColor = [UIColor greenColor];
    return view;
}

- (void)createButton {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn.frame = CGRectMake(15, 15, (ScreenW - 120)/2.0, 35);
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelBtn = btn;
    [btn setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [btn addTarget:self action:@selector(cancelBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    [_footerView addSubview:btn];
    
}

- (void)createOkBtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:btn];
    
    btn.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame)+30, 15, (ScreenW - 120)/2.0, 35);
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.bounds.size.height/2;
    
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    // 179 0 6
    [btn setBackgroundColor:[UIColor colorWithRed:179.0/255.0 green:0 blue:6.0f/255.0 alpha:1]];
    
    [btn addTarget:self action:@selector(okeyBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
     [_footerView addSubview:btn];
    self.okBtn = btn;
    
}

- (void)okeyBtnPress {
    
    if (self.OkeyBtnClicked) {
        self.OkeyBtnClicked(self.flag);
    }
    
}

- (void)cancelBtnPress {
    
    if (self.cancelBtnCallBack) {
        self.cancelBtnCallBack();
    }
    
}





- (void)NewDataSource {
    
    if (self.dataSource.count <= 5) {
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+10, ScreenW - 60, 44*self.dataSource.count+65);
    } else {
        
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+10, ScreenW - 60, 44*5+65);
        
    }
 
    self.frame = CGRectMake(30, (ScreenW - 44)/2.0f, ScreenW - 60, CGRectGetMaxY(_tableView.frame));
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

}


#pragma mark - tableViewDelegate && tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPopViewSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.preservesSuperviewLayoutMargins = NO;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;

    [cell configData:self.dataSource[indexPath.row]];

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     self.flag = indexPath.row;
  //   CLPopViewSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.selectImage.image = [UIImage imageNamed:@"selectPopVIew"];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // CLPopViewSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   
  //  cell.selectImage.image = [UIImage imageNamed:@"selectPopViewNomal"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (ScreenW - 60), 65)];
    [self createButton];
    [self createOkBtn];
    
    return _footerView;
    
}



@end
