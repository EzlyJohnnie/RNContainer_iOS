//
//  JCBaseActionMenuViewController.h
//
//  Created by Johnnie on 19/12/17.
//

#import "JCBaseViewController.h"

@interface JCBaseActionMenuViewController : JCBaseViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic, nullable) NSLayoutConstraint *const_contentViewBottom;
@property (strong, nonatomic, nullable) NSLayoutConstraint *const_contentViewLeft;
@property (strong, nonatomic, nullable) NSLayoutConstraint *const_contentViewRight;
@property (strong, nonatomic, nullable) NSLayoutConstraint *const_viewHeight;

- (void)setupView;
- (void)viewDidRotate;
- (void)contentViewDidAppear;
- (void)dismiss;
- (void)dismissWithCompletion: (void (^ __nullable)(void))completion;

//settings from child class
- (CGFloat)bottomSafeMarginForIphoneX;//default [PFUIUtils safeMarginForIPhoneX]
- (BOOL)allowDragToDismiss;//defaule YES

@end
