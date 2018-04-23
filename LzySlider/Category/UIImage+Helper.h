//
//  UIImage+Helper.h
//  easyrentcars
//
//  Created by zzc-20170215 on 2017/5/3.
//  Copyright © 2017年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UIImage (Helper)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)scaleImageToSize:(CGSize)size scale:(CGFloat)scale;

- (NSData *)dataOfJPGImageWithQuality:(CGFloat)quality insertLocation:(CLLocation *)location andContext:(NSDictionary *)context;

/**
 重新绘制图片
 
 @param color 填充色
 @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end
