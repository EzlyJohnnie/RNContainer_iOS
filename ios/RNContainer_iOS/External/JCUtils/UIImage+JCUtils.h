//
//  UIImage+JCUtils.h
//  
//
//  Created by Johnnie on 4/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (JCUtils)

+ (UIImage *)jc_originalImageNamed:(NSString *)imageName;
+ (UIImage *)jc_placeholderImage;

- (NSData *)jc_getImageData;
- (BOOL)jc_isTransparentAt:(CGPoint)point;
- (UIColor *)jc_colorAtPixel:(CGPoint)point;
+ (UIImage *)jc_imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)jc_imageWithScaled:(CGFloat)scale ;
- (UIImage *)jc_resizeWithWidth:(CGFloat)width height:(CGFloat)height;
- (UIImage*)jc_rotateForExif;
- (UIImage *)jc_fillWithColor:(UIColor *)fillColor;

@end
