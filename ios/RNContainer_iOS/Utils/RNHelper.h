//
//  RNHelper.h
//  RNContainer_iOS
//
//  Created by Johnnie on 17/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RNHelper : NSObject

+ (UIView *)rctViewWithJsbundleName:(NSString *)jsbundleName
                      moduleName:(NSString *)moduleName
               initialProperties:(NSDictionary *)initialProperties
                   launchOptions:(NSDictionary *)launchOptions;

@end
