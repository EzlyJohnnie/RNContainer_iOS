//
//  JCBaseViewController.m
//  
//
//  Created by Johnnie on 16/11/15.
//

#import "JCBaseViewController.h"

#import "JCUtils.h"
#import "UIColor+JCUtils.h"
#import "UIImage+JCUtils.h"
#import "UIView+JCUtils.h"
#import "UINavigationBar+JCUtils.h"

@interface JCBaseViewController (){
    NSString *phoneToCall;
}

@property (strong, nonatomic) UIView *statusBarView;
@property (strong, nonatomic) UIImageView *ivBG;

@end

@implementation JCBaseViewController

#pragma mark - Initialisers

- (instancetype)init{
    if (self = [self initWithOwnNib]){
        self.tabBarItem.title = @"";
    }
    return self;
}

- (instancetype)initWithOwnNib{
    return [self initWithNibName:NSStringFromClass([self class]) bundle:[JCUtils frameworkBundle]];
}

- (instancetype)initWithNib:(NSString *)nibName{
    return [self initWithNibName:nibName bundle:[JCUtils frameworkBundle]];
}


- (instancetype)initWithNoNib{
    if (self = [super init]){
        self.tabBarItem.title = @"";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if([self preventViewControllerBehindNavigationBar]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
    [self setBackgrondImage];
}

- (BOOL)preventViewControllerBehindNavigationBar{
    return YES;
}

- (BOOL)allowNavigationBarTranslucent{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar jc_setBackgroundColor:[UIColor navigationbarBackgroundColor] extendToStatusBar:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage jc_imageWithColor: [UIColor navigationbarBackgroundColor] size:CGSizeMake([JCUtils screenWidth], 1)];
}

- (void)hideNavigationBar:(BOOL) isHide{
    [self.navigationController.navigationBar setHidden:isHide];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Custom Functions
- (void)setupNavBar{
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [self.navigationItem setTitle:@""];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor navigationbarTextColor]}];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setBackgrondImage{
    if([self hasBackgroundImage] && !_ivBG){
        _ivBG = [UIImageView new];
        _ivBG.clipsToBounds = YES;
        _ivBG.contentMode = UIViewContentModeScaleAspectFill;
        _ivBG.image = [UIImage imageNamed:[JCUtils isIPhone] ? @"default_bg_image_iphone" : @"default_bg_image_iphone"];
        [self.view insertSubview:_ivBG atIndex:0];
        [_ivBG jc_fillInSuperView];
    }
}

- (BOOL)hasBackgroundImage{
    return YES;
}

- (void)setLeftBarButtonType:(LeftBarButtonType)type{
    JCBarButtonItem *barButtonItem = [[JCBarButtonItem alloc] initWithLeftBarButtonType:type];
    [barButtonItem setDelegate:self];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGFloat width = 0;
    if(type == LeftBarButtonTypeBack || type == LeftBarButtonTypeCancel){
        width = - 15;
    }
    [spacer setWidth:width];
    
    [self.navigationItem setLeftBarButtonItems:@[spacer, barButtonItem]];
    [self.navigationItem setHidesBackButton:YES];
}

- (NSArray<UIBarButtonItem *> *)setRightBarButtonTypes:(NSArray<NSNumber *> *)types{
    NSMutableArray<JCBarButtonItem *> *buttons = [NSMutableArray array];
    for(NSNumber *typeNum in types){
        RightBarButtonType type = [typeNum integerValue];
        JCBarButtonItem *btn = [[JCBarButtonItem alloc] initWithRightBarButtonType:type];
        [btn setDelegate:self];
        [buttons addObject:btn];
    }
    
    if(buttons && [buttons count]){
        NSMutableArray *wrappedButtons = [NSMutableArray array];
        UIBarButtonItem *righSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        RightBarButtonType firstBtnType = [[types objectAtIndex:0] integerValue];
        if(firstBtnType == RightBarButtonTypeShare){
            [righSpacer setWidth:-8];
        }
        else{
            [righSpacer setWidth:0];
        }
        
        [wrappedButtons addObject:righSpacer];
        [wrappedButtons addObjectsFromArray:buttons];
        [self.navigationItem setRightBarButtonItems:wrappedButtons];
    }
    
    return buttons;
}

- (void)setTabBarImageName:(NSString *)imageName{
    self.tabBarItem.image = [UIImage jc_originalImageNamed:[NSString stringWithFormat:@"%@", imageName]];
    self.tabBarItem.selectedImage = [UIImage jc_originalImageNamed:[NSString stringWithFormat:@"%@_sel", imageName]];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
}

- (void)showStatusBarBackgroundWithColour:(UIColor *)colour{
    if(_statusBarView){
        [_statusBarView removeFromSuperview];
    }
    _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.jc_width, [JCUtils statusBarHeight])];
    [_statusBarView setBackgroundColor:colour];
    [self.view insertSubview:_statusBarView atIndex:999];
}

- (void)pushViewController:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showActionSheet:(UIViewController *)vc{
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    UINavigationController *rootNav = (UINavigationController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootNav presentViewController:vc animated:NO completion:nil];
}

#pragma mark - JCBarButtonItem Delegate
- (void)leftBarButtonItemTapped:(NSInteger)btnType{
    NSLog(@"left bar button item tapped");
    if(btnType == LeftBarButtonTypeBack){
        [self popViewController];
    }
}

- (void)rightBarButtonItemTapped:(NSInteger)btnType{
    NSLog(@"right bar button item tapped: %ld", (long)btnType);
}
@end
