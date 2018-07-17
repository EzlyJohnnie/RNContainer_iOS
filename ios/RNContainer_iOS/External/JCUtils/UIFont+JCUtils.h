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

+ (UIFont *)fontWithType:(JCFontType)type;
+ (UIFont *)fontWithSize:(CGFloat)size;
+ (UIFont *)fontWithType:(JCFontType)type size:(CGFloat)size;

- (UIFont *)convertToCustmorFont;

@end
