//
//  MainViewController.m
//  RNContainer_iOS
//
//  Created by Johnnie on 17/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import "MainViewController.h"
#import "RNAppViewController.h"
#import "RNActionSheetViewController.h"
#import "MultiRNViewController.h"

@interface MainViewController ()

@end





@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RN Container";
}

#pragma - actions
- (IBAction)onShowTestAppClicked:(id)sender {
    RNAppViewController *vc = [[RNAppViewController alloc] initWithTitle:@"RN Test App"
                                                                    jsbundleName:@"test_app"
                                                                      moduleName:@"App"
                                                               initialProperties:nil];
    [self pushViewController:vc];
}

- (IBAction)onShowAnotherTestAppClicked:(id)sender {
    RNActionSheetViewController *vc = [[RNActionSheetViewController alloc] initWithJsbundleName:@"another_test_app"
                                                                                     moduleName:@"App"
                                                                              initialProperties:nil];
    [self showActionSheet:vc];
}

- (IBAction)showBothClicked:(id)sender {
    MultiRNViewController *vc = [MultiRNViewController new];
    [self pushViewController:vc];
}

@end
