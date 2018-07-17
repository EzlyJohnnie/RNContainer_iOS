//
//  RNHelper.m
//  RNContainer_iOS
//
//  Created by Johnnie on 17/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import "RNHelper.h"

#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

NSString *const TEST_APP_BUNDLE_NAME = @"test_app";
NSString *const TEST_APP_MODULE_NAME = @"App";
NSString *const ANOTHER_TEST_APP_BUNDLE_NAME = @"another_test_app";
NSString *const ANOTHER_TEST_APP_MODULE_NAME = @"App";

@implementation RNHelper

+ (UIView *)rctViewWithJsbundleName:(NSString *)jsbundleName
                      moduleName:(NSString *)moduleName
               initialProperties:(NSDictionary *)initialProperties
                   launchOptions:(NSDictionary *)launchOptions
{
    NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:jsbundleName withExtension:@"jsbundle"];
    return [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                                moduleName        : moduleName
                                initialProperties : initialProperties
                                 launchOptions    : launchOptions];
}

@end
