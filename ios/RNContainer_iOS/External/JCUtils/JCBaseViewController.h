//
//  JCBaseViewController.h
//  
//
//  Created by Johnnie on 16/11/15.
//

#import <UIKit/UIKit.h>
#import "JCBarButtonItem.h"


@interface JCBaseViewController : UIViewController<JCBarButtonItemDelegate, UIAlertViewDelegate>{
    BOOL isShowingLoader;
}

- (instancetype)initWithOwnNib;
- (instancetype)initWithNib:(NSString *)nibName;
- (instancetype)initWithNoNib;

- (void)setTabBarImageName:(NSString *)imageName;
- (void)showStatusBarBackgroundWithColour:(UIColor *)colour;
- (void)hideNavigationBar:(BOOL)isHide;

- (void)setLeftBarButtonType:(LeftBarButtonType)type;
- (NSArray<UIBarButtonItem *> *)setRightBarButtonTypes:(NSArray<NSNumber *> *)types;

//- (void)showLoader;
//- (void)showLoaderWithTitle:(NSString *)title;
//- (void)showLoaderWithTitle:(NSString *)title onView:(UIView *)view;
//- (void)showSuccessWithCompletionBlock:(void (^)(void))completionBlock;
//- (void)showSuccessWithTitle:(NSString *)title completionBlock:(void (^)(void))completionBlock;
//- (void)showFailWithCompletionBlock:(void (^)(void))completionBlock;
//- (void)showFailWithTitle:(NSString *)title completionBlock:(void (^)(void))completionBlock;
//- (void)hideLoader;

- (void)pushViewController:(UIViewController *)viewController;
- (void)popViewController;
- (void)showActionSheet:(UIViewController *)vc;


@end
