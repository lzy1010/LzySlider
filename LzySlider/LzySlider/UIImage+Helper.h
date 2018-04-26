//
//  UIImage+Helper.h
//  easyrentcars
//
//  Created by zzc-20170215 on 2017/5/3.
//  Copyright © 2017年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

/**
 重新绘制图片
 
 @param color 填充色
 @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
