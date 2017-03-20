

#import <UIKit/UIKit.h>

typedef void(^AlertViewBlock)(NSInteger index);

@protocol FDAlertViewDelegate;

@interface FDAlertView : UIView


@property (weak, nonatomic) id<FDAlertViewDelegate> delegate;
@property (nonatomic,copy)AlertViewBlock block;



- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)icon
                      message:(NSString *)message
                     delegate:(id<FDAlertViewDelegate>)delegate
                 buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (void)FDAlertView:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles
        clickButton:(AlertViewBlock)block;

// Show the alert view in current window
- (void)show;

// Hide the alert view
- (void)hide;

// Set the color and font size of title, if color is nil, default is black. if fontsize is 0, default is 14
- (void)setTitleColor:(UIColor *)color
             fontSize:(CGFloat)size;

// Set the color and font size of message, if color is nil, default is black. if fontsize is 0, default is 12
- (void)setMessageColor:(UIColor *)color
               fontSize:(CGFloat)size;

// Set the color and font size of button at the index, if color is nil, default is black. if fontsize is 0, default is 16
- (void)setButtonTitleColor:(UIColor *)color
                   fontSize:(CGFloat)size
                    atIndex:(NSInteger)index;

- (void)setButtonTitleColor:(UIColor *)color
                       font:(UIFont *)font
                    atIndex:(NSInteger)index;

@end

@protocol FDAlertViewDelegate <NSObject>

- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
