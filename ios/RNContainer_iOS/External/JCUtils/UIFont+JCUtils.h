//
//  UIFont+JCUtils.h
//  
//
//  Created by Johnnie on 4/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JCFontType) {
    JCFontTypeRegular,
    JCFontTypeLight,
    JCFontTypeBold,
    JCFontTypeItalic
};


@interface UIFont (JCUtils)

+ (UIFont *)jc_fontWithType:(JCFontType)type;
+ (UIFont *)jc_fontWithSize:(CGFloat)size;
+ (UIFont *)jc_fontWithType:(JCFontType)type size:(CGFloat)size;

- (UIFont *)jc_convertToCustmorFont;

@end
