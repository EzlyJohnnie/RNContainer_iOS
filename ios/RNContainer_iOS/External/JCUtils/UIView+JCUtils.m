//
//  UIView+PFUtils.m
//  
//
//  Created by Chris Drake on 4/08/15.
//  Copyright (c) 2015 Moa Creative. All rights reserved.
//

#import "UIView+JCUtils.h"
#import "JCUtils.h"

NSString *const JC_CONST_BOTTOM = @"jc_constBottom";
NSString *const JC_CONST_TOP = @"jc_constTop";
NSString *const JC_CONST_LEFT = @"jc_constLeft";
NSString *const JC_CONST_RIGHT = @"jc_constRight";
NSString *const JC_CONST_WIDTH = @"jc_constWdith";
NSString *const JC_CONST_HEIGHT = @"jc_constHeight";

@implementation UIView (JCUtils)

+ (instancetype)jc_initFromNib {
	Class class = [self class];
	return [UIView jc_loadNibNamed:NSStringFromClass(class)
						ofClass:class];
}

+ (instancetype)jc_initFromNib:(CGRect)frame {
	id instance = [self jc_initFromNib];
	if(self) {
		[instance setFrame:frame];
	}
	return instance;
}

+ (id)jc_loadNibNamed:(NSString *)nibName ofClass:(Class)objClass {
	if (nibName && objClass) {
		NSArray *objects = [[JCUtils frameworkBundle] loadNibNamed:nibName owner:nil options:nil];
		for (id currentObject in objects){
			if ([currentObject isKindOfClass:objClass]) {
				return currentObject;
			}
		}
	}
	
	return nil;
}

- (void)jc_removeAllSubviews {
	NSArray *views = [self subviews];
	for (UIView *v in views) {
		[v removeFromSuperview];
	}
}

- (void)jc_setWidth:(CGFloat)width {
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    [self setFrame:newFrame];
}

- (void)jc_setHeight:(CGFloat)height {
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    [self setFrame:newFrame];
}


- (CGFloat)jc_x{
    return self.frame.origin.x;
}

- (CGFloat)jc_y{
    return self.frame.origin.y;
}

- (CGFloat)jc_width
{
    return self.frame.size.width;
}

- (CGFloat)jc_height{
    return self.frame.size.height;
}

- (CGFloat)jc_right{
    return self.frame.origin.x + [self jc_width];
}

- (CGFloat)jc_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)jc_setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)jc_setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)jc_roundCornerWithRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners{
    [self jc_roundCornerWithRadius:cornerRadius corners:corners frame:self.bounds];
}

- (void)jc_roundCornerWithRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners frame:(CGRect)frame{
    self.clipsToBounds = YES;
    UIBezierPath *btnLatestMaskPath = [UIBezierPath
                                       bezierPathWithRoundedRect:frame
                                       byRoundingCorners:corners
                                       cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *btnLatestMaskLayer = [CAShapeLayer layer];
    btnLatestMaskLayer.frame = frame;
    btnLatestMaskLayer.path = btnLatestMaskPath.CGPath;
    self.layer.mask = btnLatestMaskLayer;
}

- (NSDictionary *)jc_fillInSuperView{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *width = [NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.superview
                                 attribute:NSLayoutAttributeWidth
                                 multiplier:1.0f
                                 constant:0.f];
    
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:self
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.superview
                                  attribute:NSLayoutAttributeHeight
                                  multiplier:1.0f
                                  constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.superview
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:self
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.superview
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    
    [self.superview addConstraints:@[top, leading, width, height]];
    
    return @{
             JC_CONST_TOP : top,
             JC_CONST_LEFT : leading,
             JC_CONST_WIDTH : width,
             JC_CONST_HEIGHT : height
             };
}

- (NSLayoutConstraint *)jc_addHeightConstraint:(CGFloat)height{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *heightConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:height];
    [self addConstraint:heightConstraint];
    
    return heightConstraint;
}

- (NSLayoutConstraint *)jc_addWidthConstraint:(CGFloat)width{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:width];
    [self addConstraint:widthConstraint];
    
    return widthConstraint;
}

- (NSLayoutConstraint *)jc_addCenterVerticalConstraintWithOffset:(CGFloat)offset{
    NSLayoutConstraint *yCenterConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.superview
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:offset];
    [self.superview addConstraint:yCenterConstraint];
    
    return yCenterConstraint;
}

- (NSLayoutConstraint *)jc_addCenterHorizontalConstraintWithOffset:(CGFloat)offset{
    NSLayoutConstraint *xCenterConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.superview
                                attribute:NSLayoutAttributeCenterX
                               multiplier:1.0
                                 constant:offset];
    [self.superview addConstraint:xCenterConstraint];
    
    return xCenterConstraint;
}

- (NSLayoutConstraint *)jc_addTopConstraintToParent:(CGFloat)top{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                         constraintWithItem:self
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.superview
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0f
                                         constant:top];
    [self.superview addConstraint:topConstraint];
    
    return topConstraint;
}

- (NSLayoutConstraint *)jc_addLeftConstraintToParent:(CGFloat)left{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.superview
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:left];
    [self.superview addConstraint:leading];
    
    return leading;
}

- (NSLayoutConstraint *)jc_addRightConstraintToParent:(CGFloat)right{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:self
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.superview
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0f
                                    constant:-right];
    [self.superview addConstraint:trailing];
    
    return trailing;
}

- (NSLayoutConstraint *)jc_addBottomConstraintToParent:(CGFloat)bottom{
    NSLayoutConstraint *bottomConst = [NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.superview
                                       attribute:NSLayoutAttributeBottom
                                       multiplier:1.0f
                                       constant:-bottom];
    
    [self.superview addConstraint:bottomConst];
    
    
    return bottomConst;
}

- (NSDictionary *)jc_alignParentTopFillWidth{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                    constraintWithItem:self
                                    attribute:NSLayoutAttributeTrailing
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.superview
                                    attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0f
                                    constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.superview
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    NSLayoutConstraint *top = [NSLayoutConstraint
                                  constraintWithItem:self
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.superview
                                  attribute:NSLayoutAttributeTop
                                  multiplier:1.0f
                                  constant:0.f];
    
    [self.superview addConstraints:@[leading, top, trailing]];
    
    return @{
             JC_CONST_TOP : top,
             JC_CONST_LEFT : leading,
             JC_CONST_RIGHT : trailing
             };
}

- (NSDictionary *)jc_alignParentBottomFillWidth{
    return [self jc_alignParentBottomFillWidthWithPaddingLeft:0 right:0 bottom :0];
}

- (NSDictionary *)jc_alignParentBottomFillWidthWithPaddingLeft:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeTrailing
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.superview
                                 attribute:NSLayoutAttributeTrailing
                                 multiplier:1.0f
                                 constant:-right];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.superview
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:left];
    
    NSLayoutConstraint *bottomConst = [NSLayoutConstraint
                               constraintWithItem:self
                               attribute:NSLayoutAttributeBottom
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.superview
                               attribute:NSLayoutAttributeBottom
                               multiplier:1.0f
                               constant:-bottom];
    
    [self.superview addConstraints:@[leading, bottomConst, trailing]];
    
    return @{
             JC_CONST_BOTTOM : bottomConst,
             JC_CONST_LEFT : leading,
             JC_CONST_RIGHT : trailing
             };
}

@end
