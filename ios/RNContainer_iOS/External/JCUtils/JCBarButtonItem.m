//
//  JCBarButtonItem.m
//  
//
//  Created by Johnnie on 13/11/15.
//

#import "JCBarButtonItem.h"
#import "JCUtils.h"
#import "UIColor+JCUtils.h"
#import "UIView+JCUtils.h"
#import "UIFont+JCUtils.h"

static CGFloat const kImageWidth = 32.0;
static CGFloat const kImageHeight = 32.0;
static CGFloat const kLeftBackContainerWidth = 40.0;
static CGFloat const kLabelWidth = 50.0;

typedef NS_ENUM(NSInteger, BarButtonSide) {
    LeftBarButton,
    RightBarButton
};

@interface JCBarButtonItem(){
    LeftBarButtonType leftBarButtonType;
    RightBarButtonType rightBarButtonType;
}

@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *text;

@end



@implementation JCBarButtonItem

- (id)initWithLeftBarButtonType:(LeftBarButtonType)type{
    leftBarButtonType = type;
    if (type != LeftBarButtonTypeNone){
        if (self = [super initWithCustomView:[self setupView:LeftBarButton]]){
            
        }
    }
    return self;
}

- (id)initWithRightBarButtonType:(RightBarButtonType)type;{
    rightBarButtonType = type;
    if (type != RightBarButtonTypeNone){
        if (self = [super initWithCustomView:[self setupView:RightBarButton]]){
            
        }
    }
    return self;
}

- (UIView *)setupView:(BarButtonSide)side{
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kImageWidth, kImageHeight)];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kImageWidth, kImageHeight)];
    [self.button setBackgroundColor:[UIColor clearColor]];
    [self.containerView addSubview:self.button];
    
    if (side == LeftBarButton){
        [self setupLeftButton];
    }
    else if (side == RightBarButton){
        [self setupRightButton];
    }
    
    [self setupContainerViewWithSide:side];
    [self setupAdditionalView];
    
//    [self.containerView setBackgroundColor:[UIColor redColor]];
//    [self.button setBackgroundColor:[UIColor blueColor]];
    return self.containerView;
}

- (void)setupLeftButton{
    [self.button addTarget:self action:@selector(leftBarButtonItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button.tag = leftBarButtonType;
    switch (leftBarButtonType){
        case LeftBarButtonTypeClose:
            _icon = [UIImage imageNamed:@"nav_close" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            break;
            
        case LeftBarButtonTypeCancel:
            [self.button jc_setWidth:kLabelWidth];
            [self.containerView jc_setWidth:kLabelWidth];
            _text = @"Cancel";
            _icon = [UIImage imageNamed:@"nav_back" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            break;
            
        case LeftBarButtonTypeBack:
            [self.button jc_setWidth:kLeftBackContainerWidth];
            [self.containerView jc_setWidth:kLeftBackContainerWidth];
            self.button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            [self.button addTarget:self action:@selector(leftBarButtonItemTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self.containerView addSubview:self.button];
            _icon = [UIImage imageNamed:@"nav_back" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            break;
            
        case LeftBarButtonTypeMenu:
            _icon = [UIImage imageNamed:@"nav_menu" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            [self.button setFrame:CGRectMake(0, 0, 60, 40)];
            [self.containerView setFrame:CGRectMake(0, 0, 60, 40)];
            self.button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
            break;
            
        case LeftBarButtonTypeNone:
        default:
            break;
    }
}

- (void)setupRightButton{
    [self.button addTarget:self action:@selector(rightBarButtonItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button.tag = rightBarButtonType;
    
    switch (rightBarButtonType){
       
        case RightBarButtonTypeMenu:
            _icon = [UIImage imageNamed:@"nav_menu" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            break;
            
        case RightBarButtonTypeShare:
            _icon = [UIImage imageNamed:@"nav_share" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            break;
            
        case RightBarButtonTypeClose:
//            _icon = [UIImage imageNamed:@"nav_close" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            _text = @"Close";
            break;
            
        case RightBarButtonTypeTouchID:
            _icon = [UIImage imageNamed:@"nav_touchID" inBundle:[JCUtils frameworkBundle] compatibleWithTraitCollection:nil];
            break;
            
        case RightBarButtonTypePasscode:
            _text = @"Passcode";
            break;
            
        case RightBarButtonTypeReset:
            _text = @"Reset";
            break;
        
            
        case RightBarButtonTypeNone:
        default:
            break;
    }
}


- (void)setupContainerViewWithSide:(BarButtonSide)side{
    if (_icon){
        UIColor *iconColor = [UIColor navigationbarIconColor];
        [self.button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        NSInteger btnType = side == LeftBarButton ? leftBarButtonType : rightBarButtonType;
        if(iconColor && ![self shouldUseOriginalIconWithSide:side btnType:btnType]){
            _icon = [_icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.button setImage:_icon forState:UIControlStateNormal];
            self.button.tintColor = iconColor;
        }
        else{
            [self.button setImage:_icon forState:UIControlStateNormal];
        }
        
    }
    
    if (_text){
        UIColor *txtColor = [UIColor navigationbarTextColor];
        [self.button setTitle:_text forState:UIControlStateNormal];
        [self.button.titleLabel sizeToFit];
        [self.button sizeToFit];
        [self.button setBackgroundColor:[UIColor clearColor]];
        [self.button.titleLabel setFont:[UIFont jc_fontWithSize:15]];
        [self.button.titleLabel setTextAlignment:NSTextAlignmentRight];
        [self.button setTitleColor:txtColor ? txtColor : [UIColor whiteColor] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor navigationbarTextHighlitColor] forState:UIControlStateHighlighted];
        self.containerView.frame = self.button.frame;
    }
    
}

//to be override by child if need
- (void)setupAdditionalView{}

- (BOOL)shouldUseOriginalIconWithSide:(BarButtonSide)side btnType:(NSInteger)btnType{
    BOOL shouldUserOriginalIcon = NO;
    if(side == LeftBarButton){
        
    }
    else{
        
    }
    return shouldUserOriginalIcon;
}

- (void)leftBarButtonItemTapped:(UIButton *)sender{
    if (sender == self.button){
        [self.delegate leftBarButtonItemTapped:self.button.tag];
    }
}

- (void)rightBarButtonItemTapped:(UIButton *)sender{
    if (sender == self.button){
        if (self.delegate && [self.delegate respondsToSelector:@selector(rightBarButtonItemTapped:)]){
            [self.delegate rightBarButtonItemTapped:self.button.tag];
        }
    }
}

@end




