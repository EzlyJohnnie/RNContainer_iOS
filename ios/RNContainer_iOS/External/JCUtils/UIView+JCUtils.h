//
//  UIView+PFUtils.h
//  
//
//  Created by Chris Drake on 4/08/15.
//  Copyright (c) 2015 Moa Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const JC_CONST_BOTTOM;
extern NSString *const JC_CONST_TOP;
extern NSString *const JC_CONST_LEFT;
extern NSString *const JC_CONST_RIGHT;
extern NSString *const JC_CONST_WIDTH;
extern NSString *const JC_CONST_HEIGHT;

@interface UIView (JCUtils)

+ (instancetype)jc_initFromNib;
+ (instancetype)jc_initFromNib:(CGRect)frame;

+ (id)jc_loadNibNamed:(NSString *)nibName ofClass:(Class)objClass;

- (void)jc_removeAllSubviews;

- (void)jc_setWidth:(CGFloat)width;

- (void)jc_setHeight:(CGFloat)height;

- (CGFloat)jc_x;

- (CGFloat)jc_y;

- (CGFloat)jc_width;

- (CGFloat)jc_height;

- (CGFloat)jc_right;

- (CGFloat)jc_bottom;

- (void)jc_setX:(CGFloat)x;

- (void)jc_setY:(CGFloat)y;

- (void)jc_roundCornerWithRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;
- (void)jc_roundCornerWithRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners frame:(CGRect)frame;

- (NSDictionary *)jc_fillInSuperView;
- (NSLayoutConstraint *)jc_addHeightConstraint:(CGFloat)height;
- (NSLayoutConstraint *)jc_addWidthConstraint:(CGFloat)width;
- (NSLayoutConstraint *)jc_addTopConstraintToParent:(CGFloat)top;
- (NSLayoutConstraint *)jc_addLeftConstraintToParent:(CGFloat)left;
- (NSLayoutConstraint *)jc_addRightConstraintToParent:(CGFloat)right;
- (NSLayoutConstraint *)jc_addBottomConstraintToParent:(CGFloat)bottom;
- (NSLayoutConstraint *)jc_addCenterVerticalConstraintWithOffset:(CGFloat)offset;
- (NSLayoutConstraint *)jc_addCenterHorizontalConstraintWithOffset:(CGFloat)offset;

- (NSDictionary *)jc_alignParentTopFillWidth;
- (NSDictionary *)jc_alignParentBottomFillWidth;
- (NSDictionary *)jc_alignParentBottomFillWidthWithPaddingLeft:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom;

@end
