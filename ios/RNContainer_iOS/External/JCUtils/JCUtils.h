//
//  JCUtils.h
//  
//
//  Created by Johnnie on 4/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface JCUtils : NSObject

+ (NSString *)appVersion;
+ (NSString *)appBuildNumber;

+ (NSBundle *)frameworkBundle;
+ (UIViewController *)rootViewController;

+ (NSString *)getMimeTypeFromFileName:(NSString *)filename;
+ (NSString *)getMimeTypeForData:(NSData *)data;

#pragma mark - device info
+ (BOOL)isIPad;
+ (BOOL)isIPhone;
+ (BOOL)isIPhoneX;
+ (CGFloat)safeMarginForIPhoneX;
+ (BOOL)isPortrait;
+ (BOOL)isLandscape;
+ (BOOL)isLandscapeLeft;
+ (BOOL)isLandscapeRight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGFloat)statusBarHeight;

#pragma mark - email
+ (void)sendEmailToEmailAddress:(NSString *)email subject:(NSString *)subject;

#pragma mark - call
+ (void)callNumber:(NSString *)number;

#pragma mark - redirection
+ (void)redirectToSystemSettingsAuthentication;
@end
