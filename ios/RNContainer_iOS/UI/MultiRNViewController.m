//
//  MultiRNViewController.m
//  RNContainer_iOS
//
//  Created by Johnnie on 17/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import "MultiRNViewController.h"
#import "RNHelper.h"

#import "UIView+JCUtils.h"

@interface MultiRNViewController ()

@property (weak, nonatomic) IBOutlet UIView *rnViewTop;
@property (weak, nonatomic) IBOutlet UIView *rnViewBottom;

@end





@implementation MultiRNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView{
    self.title = @"Multi RN Apps";
    [self setLeftBarButtonType:LeftBarButtonTypeBack];
    
    UIView *topRCTView = [RNHelper rctViewWithJsbundleName:@"test_app" moduleName:@"App" initialProperties:nil launchOptions:nil];
    [_rnViewTop addSubview:topRCTView];
    [topRCTView fillInSuperView];
    
    UIView *bottomRCTView = [RNHelper rctViewWithJsbundleName:@"another_test_app" moduleName:@"App" initialProperties:nil launchOptions:nil];
    [_rnViewBottom addSubview:bottomRCTView];
    [bottomRCTView fillInSuperView];
}


@end