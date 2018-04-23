//
//  UIImage+Helper.m
//  easyrentcars
//
//  Created by zzc-20170215 on 2017/5/3.
//  Copyright © 2017年 zzc-20170215. All rights reserved.
//

#import "UIImage+Helper.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Helper)

- (UIImage *)scaleImageToSize:(CGSize)size scale:(CGFloat)scale
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    
    if (width > targetWidth || height > targetHeight)
    {
        UIImage *newImage = nil;
        CGFloat scaleFactor = 0.0;
        CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
        CGFloat scaledWidth = targetWidth;
        CGFloat scaledHeight = targetHeight;
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor < heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor > heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaledWidth, scaledHeight), NO, scale);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        
        [self drawInRect:thumbnailRect];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        if(newImage == nil) NSLog(@"could not scale image");
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    
    return self;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (NSData *)dataOfJPGImageWithQuality:(CGFloat)quality insertLocation:(CLLocation *)location andContext:(NSDictionary *)context
{
    
    NSData *imageData = UIImageJPEGRepresentation(self, quality);
    CFDataRef imageDataRef = (__bridge CFDataRef)imageData;
    CGImageSourceRef source = CGImageSourceCreateWithData(imageDataRef, NULL);
    
    NSMutableDictionary *insertDict = [NSMutableDictionary dictionaryWithDictionary:context];
    if (location)
    {
        NSMutableDictionary *locDict = [NSMutableDictionary dictionary];
        [locDict setValue:@(location.coordinate.latitude) forKey:(__bridge NSString *)kCGImagePropertyGPSLatitude];
        [locDict setValue:@(location.coordinate.longitude) forKey:(__bridge NSString *)kCGImagePropertyGPSLongitude];
        [locDict setValue:@(location.altitude) forKey:(__bridge NSString *)kCGImagePropertyGPSAltitude];
        NSString *ref = nil;
        
        if (location.coordinate.latitude < 0)
        {
            ref = @"S";
        }else
        {
            ref = @"N";
        }
        [locDict setValue:ref forKey:(__bridge NSString *)kCGImagePropertyGPSLatitudeRef];
        
        if (location.coordinate.longitude < 0)
        {
            ref = @"W";
        }else
        {
            ref = @"E";
        }
        [locDict setValue:ref forKey:(__bridge NSString *)kCGImagePropertyGPSLongitudeRef];
        
        if (location.altitude < 0) {
            ref = @"1";
        }else
        {
            ref = @"0";
        }
        [locDict setValue:ref forKey:(__bridge NSString *)kCGImagePropertyGPSAltitudeRef];
        
        [insertDict setObject:locDict forKey:(__bridge NSString *)kCGImagePropertyGPSDictionary];
    }
    NSData *data = nil;
    NSMutableData *resultData = [NSMutableData data];
    CGImageDestinationRef destinationRef = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)resultData, CGImageSourceGetType(source), 1,NULL);
    if (!destinationRef) {
        
        NSLog(@"写入失败__CGImageDestinationCreateWithData");
        data = imageData;
    }
    
    CGImageDestinationAddImageFromSource(destinationRef, source, 0, (__bridge CFDictionaryRef)insertDict);
    if (!CGImageDestinationFinalize(destinationRef))
    {
        NSLog(@"写入失败__CGImageDestinationAddImageFromSource");
        data = imageData;
    }
    
    CFRelease(destinationRef);
    CFRelease(source);
    return [resultData copy];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
