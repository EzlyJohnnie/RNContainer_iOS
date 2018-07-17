//
//  RNHelper.h
//  RNContainer_iOS
//
//  Created by Johnnie on 17/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const TEST_APP_BUNDLE_NAME;
extern NSString *const TEST_APP_MODULE_NAME;
extern NSString *const ANOTHER_TEST_APP_BUNDLE_NAME;
extern NSString *const ANOTHER_TEST_APP_MODULE_NAME;


@interface RNHelper : NSObject

+ (UIView *)rctViewWithJsbundleName:(NSString *)jsbundleName
                      moduleName:(NSString *)moduleName
               initialProperties:(NSDictionary *)initialProperties
                   launchOptions:(NSDictionary *)launchOptions;

@end
