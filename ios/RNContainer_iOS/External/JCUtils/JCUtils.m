//
//  JCUtils.m
//  
//
//  Created by Johnnie on 4/12/17.
//

#import "JCUtils.h"
#import "JCUIAlertUtils.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation JCUtils

#pragma mark - general
+ (NSString *)appVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildNumber{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSBundle *)frameworkBundle
{
    static NSBundle* frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        frameworkBundle = [NSBundle bundleForClass:[self class]];
    });
    return frameworkBundle;
}

+ (UIViewController *)rootViewController{
    return [[[UIApplication sharedApplication] keyWindow] rootViewController];
}

+ (NSString *)getMimeTypeFromFileName:(NSString *)filename{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filename pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

+ (NSString *)getMimeTypeForData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

#pragma mark - device
+ (BOOL)isIPhone{
    return [[UIDevice currentDevice].model hasPrefix:@"iPhone"];
}

+ (BOOL)isIPad{
    return [[UIDevice currentDevice].model hasPrefix:@"iPad"];
}

+ (BOOL)isIPhoneX{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
    && ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.width == 812)
    && SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0");
}

+ (CGFloat)safeMarginForIPhoneX{
    //TODO: get proper size programmatically
    return 30;
}

+ (BOOL)isPortrait{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait
    || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortraitUpsideDown;
}

+ (BOOL)isLandscape{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight
    || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft;
}

+ (BOOL)isLandscapeLeft{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft;
}

+ (BOOL)isLandscapeRight{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight;
}

+ (CGFloat)screenWidth{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)statusBarHeight{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

#pragma mark - email
+ (void)sendEmailToEmailAddress:(NSString *)email subject:(NSString *)subject{
    NSString *emailURLStr = [NSString stringWithFormat:@"mailto:%@?subject=%@", email, subject];
    emailURLStr = [emailURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *emailURL = [NSURL URLWithString:emailURLStr];
    [[UIApplication sharedApplication] openURL:emailURL];
}

+ (void)callNumber:(NSString *)number{
    if([JCUtils isIPhone]){
        NSString *num = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", num]];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    else{
        [JCUIAlertUtils showConfirmDialog:@"Error" content:@"This device does not support for phone call." okBtnTitle:@"Ok" okHandler:nil];
    }
    
}

#pragma mark - redirection
+ (void)redirectToSystemSettingsAuthentication{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
@end
