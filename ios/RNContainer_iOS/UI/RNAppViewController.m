//
//  RNAppViewController.m
//  RNContainer_iOS
//
//  Created by Johnnie on 17/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import "RNAppViewController.h"
#import "RNActionSheetViewController.h"
#import "RNHelper.h"

@interface RNAppViewController ()

@end





@implementation RNAppViewController

- (instancetype)initWithTitle:(NSString *)title{
    if(self = [super initWithNoNib]){
        self.title = title;
        [self setupView];
        
        self.view = [RNHelper rctViewWithJsbundleName:TEST_APP_BUNDLE_NAME
                                           moduleName:TEST_APP_MODULE_NAME
                                    initialProperties:nil
                                        launchOptions:nil];
        
    }
    
    return self;
}

- (void)setupView{
    [self setLeftBarButtonType:LeftBarButtonTypeBack];
    [self setRightBarButtonTypes:@[@(RightBarButtonTypeMenu)]];
}

- (void)onShowAnotherTestAppClicked{
    RNActionSheetViewController *vc = [[RNActionSheetViewController alloc]
                                       initWithJsbundleName:ANOTHER_TEST_APP_BUNDLE_NAME
                                       moduleName:ANOTHER_TEST_APP_MODULE_NAME
                                       initialProperties:nil];
    [self showActionSheet:vc];
}

#pragma mark - JCBarButtonItem Delegate
- (void)rightBarButtonItemTapped:(NSInteger)btnType{
    if(btnType == RightBarButtonTypeMenu){
        [self onShowAnotherTestAppClicked];
    }
}



@end
