//
//  UIFont+JCUtils.m
//  
//
//  Created by Johnnie on 4/12/17.
//

#import "UIFont+JCUtils.h"

@implementation UIFont (JCUtils)

+ (UIFont *)jc_fontWithType:(JCFontType)type{
    return [UIFont jc_fontWithType:type size:17]; // default font size
}

+ (UIFont *)jc_fontWithSize:(CGFloat)size{
    return [UIFont jc_fontWithType:JCFontTypeRegular size:size]; // default font size
}

+ (UIFont *)jc_fontWithType:(JCFontType)type size:(CGFloat)size{
    switch (type){
        case JCFontTypeLight:
            return [UIFont fontWithName:@"Helvetica-Light" size:size];
            
        case JCFontTypeBold:
            return [UIFont fontWithName:@"Helvetica-Bold" size:size];
            
        case JCFontTypeItalic:
            return [UIFont fontWithName:@"Helvetica-Oblique" size:size];
            
        case JCFontTypeRegular:
        default:
            return [UIFont fontWithName:@"Helvetica" size:size];
    }
}

- (UIFont *)jc_convertToCustmorFont{
    UIFont *customerFont;
    if([self.fontName containsString:@"Bold"]){
        customerFont = [UIFont jc_fontWithType:JCFontTypeBold size:self.pointSize];
    }
    else if([self.fontName containsString:@"Light"]){
        customerFont = [UIFont jc_fontWithType:JCFontTypeLight size:self.pointSize];
    }
    else if([self.fontName containsString:@"Italic"]){
        customerFont = [UIFont jc_fontWithType:JCFontTypeItalic size:self.pointSize];
    }
    
    if(!customerFont){
        customerFont = [UIFont jc_fontWithSize:self.pointSize];
    }
    
    return customerFont;
}

@end
