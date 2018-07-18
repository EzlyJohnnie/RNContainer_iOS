//
//  RNActionSheetViewController.m
//
//  Created by Johnnie on 19/12/17.
//

#import "RNActionSheetViewController.h"
#import "RNHelper.h"

#import "UIView+JCUtils.h"
#import "UIColor+JCUtils.h"

@interface RNActionSheetViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *const_contentLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *const_contentRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *const_contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constBottom;

@property (strong, nonatomic) NSString *jsbundleName;
@property (strong, nonatomic) NSString *moduleName;
@property (strong, nonatomic) NSDictionary *initialProperties;

@end




@implementation RNActionSheetViewController


- (instancetype)initWithJsbundleName:(NSString *)jsbundleName
                          moduleName:(NSString *)moduleName
                   initialProperties:(NSDictionary *)initialProperties
{
    if(self = [super init]){
        _jsbundleName = jsbundleName;
        _moduleName = moduleName;
        _initialProperties = initialProperties;
    }
    
    return self;
}

- (UIView *)getContentView{
    return _contentView;
}

- (void)setupView{
    _constBottom.constant = -_contentView.jc_height;
    super.const_contentViewBottom = _constBottom;
    super.const_contentViewLeft = _const_contentLeft;
    super.const_contentViewRight = _const_contentRight;
    super.const_viewHeight = _const_contentViewHeight;
    [super setupView];
    
    UIView *rctRootView = [RNHelper rctViewWithJsbundleName:_jsbundleName
                                                 moduleName:_moduleName
                                          initialProperties:_initialProperties
                                              launchOptions:nil];
    
    [_contentView addSubview:rctRootView];
    [rctRootView jc_fillInSuperView];
}

@end
