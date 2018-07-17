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
