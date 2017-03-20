//
//  CLCalendarPopView.m
//  popupView
//
//  Created by sethmedia on 16/8/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLCalendarPopView.h"
#import "CLCalendarPopViewCell.h"


#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)
#define RGBValue(value) [UIColor colorWithRed:(((value & 0xFF0000)>>16))/255.f green:(((value & 0xFF00) >> 8))/255.0f blue:((value & 0xFF)/255.0) alpha:1]

typedef void(^okeyBlock)(NSInteger year, NSInteger month, NSInteger day);


@interface CLCalendarPopView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) okeyBlock okeyblock;
@property (nonatomic, strong) UIView *titleBgView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *today;

@end


@implementation CLCalendarPopView

+ (instancetype)calendarPopView:(void (^)(NSInteger, NSInteger, NSInteger))okblock {
    
    CLCalendarPopView *popView = [[CLCalendarPopView alloc] init];
    
    popView.okeyblock = okblock;


    return popView;
    
    
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(30, (ScreenH - (88.5+(ScreenW - 60)/7.0f*6))/2, ScreenW - 60, 88.5+(ScreenW - 60)/7.0f*6)];
    if (self) {
       
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleBgView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.titleLabel];
        [self createWeek];
        [self addSubview:self.collectionView];
        [self addSwipe];
        
        self.today = [NSDate date];
        self.date = self.today;
    }
    return self;
}

- (void)createWeek {
    
    CGFloat width = self.bounds.size.width/7;
    CGFloat height = 44.f;
    CGFloat Y = CGRectGetMaxY(self.titleBgView.frame);
    
    NSArray *weeks = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        
        label.frame = CGRectMake(i * width, Y, width, height);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = weeks[i];
        label.textColor = RGBValue(0xb30006);
        
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, Y+height, width*7, 1)];
    [self addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
}




- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(0, 0, CGRectGetMinX(self.rightBtn.frame) - 10, 44);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"2015年03月";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.center = self.titleBgView.center;
    }
    
    return _titleLabel;
}


// navBg
- (UIView *)titleBgView {
    
    if (_titleBgView == nil) {
        _titleBgView = [[UIView alloc] init];
        _titleBgView.frame = CGRectMake(0, 0, self.bounds.size.width, 44);
        _titleBgView.backgroundColor = RGBValue(0xb30006);
        
    }
    
    return _titleBgView;
}

//左侧按钮
- (UIButton *)leftBtn {
    
    if (nil == _leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        _leftBtn.frame = CGRectMake(10, 12, 18, 20);
        
        [_leftBtn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}


//右侧按钮
- (UIButton *)rightBtn {
    
    if (nil == _rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
        _rightBtn.frame = CGRectMake(self.bounds.size.width - 28, 12, 18, 20);
        [_rightBtn addTarget:self action:@selector(lastMonth) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _rightBtn;
}

- (void)lastMonth {
    
    [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        self.date = [self lastMonth:self.date];
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)nextMonth {
    
    [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        self.date = [self nextMonth:self.date];
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)setDate:(NSDate *)date {
    
    _date = date;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld - %02ld",[self year:date],[self month:date]];
    [self.collectionView reloadData];
    
}




- (UICollectionView *)collectionView {
    
    if (nil == _collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        CGRect frame = CGRectMake(0,88.5, self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.titleBgView.frame) + 44.5);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame  collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[CLCalendarPopViewCell class] forCellWithReuseIdentifier:@"cellId"];

    }
    
    return _collectionView;
    
}

- (NSInteger)totalDayByThisMoney:(NSDate *)date {

    NSRange total = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return total.length;
}


// 第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1]; 
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    
    NSDate *firstDayofMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayofMonthDate];
    
    return firstDay - 1;
}

- (NSInteger)day:(NSDate *)date {
    
    NSDateComponents *comonents = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    return [comonents day];
}

- (NSInteger)month:(NSDate *)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date {

    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self.date];
    return [components year];
}

- (NSDate *)lastMonth:(NSDate *)date {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
    
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


#pragma mark - collectionViewDelegate && collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 42;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLCalendarPopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    
    NSInteger daysInThisMonth = [self totalDayByThisMoney:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:self.date];
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    
    // 如果第i个cell小于第一天就设置为空
    if (i < firstWeekday) {
        cell.contentLabel.text = @"";
    }
    // 如果 第i个cell大于这周的天数  设置为空
    else if (i > firstWeekday + daysInThisMonth - 1) {
    
        cell.contentLabel.text = @"";
        
    }
    
    else {
        
        day = i - firstWeekday + 1;
        cell.contentLabel.text = [NSString stringWithFormat:@"%ld",day];
        cell.contentLabel.textColor = RGBValue(0xbbbbbb);
        
        
        if ([self.today isEqualToDate:self.date]) {
            
            
            if (day == [self day:self.date]) {
                
                cell.contentLabel.textColor = RGBValue(0xb30006);
                
                
            } else if (day > [self day:self.date]) {
                
                cell.contentLabel.textColor = RGBValue(0x000000);
            
            }
            
            
        } else if ([self.today compare:self.date] == NSOrderedAscending){
            
            cell.contentLabel.textColor = RGBValue(0x000000);
            
        }
        
    }
    
    
    
    return cell;
}


//
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger daysInThisMonth = [self totalDayByThisMoney:self.date];
    NSInteger firstWeekday    = [self firstWeekdayInThisMonth:self.date];
    
    NSInteger day             = 0;
    NSInteger i               = indexPath.row;
    
    if (i >= firstWeekday && i <= firstWeekday +daysInThisMonth - 1) {
        day = i - firstWeekday + 1;
        
        
        if ([self.today isEqualToDate:self.date]) {
            
            if (day >= [self day:self.date]) {
                
                return YES;
            }
            
        } else if ([self.today compare:self.date] == NSOrderedAscending) {
            
            return YES;
            
        }
        
        
    }
    
    
    return NO;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateComponents *com = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    NSInteger firstWeekDay = [self firstWeekdayInThisMonth:self.date];
    
    NSInteger day = 0;
    
    NSInteger i = indexPath.row;
    
    day = i - firstWeekDay +1;
    
    if (self.okeyblock) {
        self.okeyblock([com year],[com month],day);
    }
    
    
    
}




- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = self.bounds.size.width/7;
    
    return CGSizeMake(width, width);
    
}


- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:swipRight];
}


- (void)nexAction:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.state == UIGestureRecognizerStateEnded) {
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
            self.date = [self lastMonth:self.date];
        } completion:nil];
    }
    

    
}

- (void)previouseAction:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.state == UIGestureRecognizerStateEnded) {
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
            self.date = [self nextMonth:self.date];
        } completion:nil];
    }
    
    
    
}



@end
